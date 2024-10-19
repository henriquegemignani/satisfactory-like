# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pillow",
# ]
# ///

import argparse
import configparser
import json
import os
from pathlib import Path
import string
import typing
from PIL import Image
import pprint
import re

# TODO:
# Fuel values
# Uranium/Plutonium waste

output_locale = configparser.ConfigParser()
sf_item_to_fac_name = {
    "Desc_Coal_C": "coal",
    "Desc_Wood_C": "wood",
    "Desc_Stone_C": "stone",
    "Desc_OreIron_C": "iron-ore",
    "Desc_OreCopper_C": "copper-ore",
    "Desc_Wire_C": "copper-cable",
    "Desc_Water_C": "water",
    "Desc_Sulfur_C": "sulfur",
    "Desc_OreCopper_C": "copper-ore",
    "Desc_OreUranium_C": "uranium-ore",
    "Desc_LiquidOil_C": "crude-oil",
    "Desc_Cement_C": "concrete",
    "Desc_RailroadTrack_C": "rail",
    "Desc_RailroadBlockSignal_C": "rail-signal",
    "Desc_RailroadPathSignal_C": "rail-chain-signal",
    "Desc_TrainStation_C": "train-stop",
    "Desc_Locomotive_C": "locomotive",
    "Desc_FreightWagon_C": "cargo-wagon",

    "Desc_PowerPoleMk1_C": "small-electric-pole",
    "Desc_PowerPoleMk2_C": "medium-electric-pole",
    "Desc_PowerPoleMk3_C": "substation",
    "Desc_PowerTower_C": "big-electric-pole",
    "Desc_PowerStorageMk1_C": "accumulator",

    "Desc_PipelinePump_C": "pump",
    "Desc_Pipeline_C": "pipe",
    # 
    "Desc_DroneStation_C": "roboport",
    "Desc_DroneTransport_C": "flying-robot-frame",
    #
    "Desc_WaterPump_C": "offshore-pump",
    "Desc_OilPump_C": "pumpjack",
    "BP_ItemDescriptorPortableMiner_C": "burner-mining-drill",
    "Desc_MinerMk1_C": "electric-mining-drill",
    "Desc_ConveyorBeltMk1_C": "sl-mk1-transport-belt",
    "Desc_ConveyorBeltMk2_C": "transport-belt",
    "Desc_ConveyorBeltMk3_C": "fast-transport-belt",
    "Desc_ConveyorBeltMk4_C": "express-transport-belt",
    "Desc_ConveyorBeltMk5_C": "sl-mk5-transport-belt",
    "Desc_ConveyorBeltMk6_C": "sl-mk6-transport-belt",
    "Desc_ConveyorLiftMk1_C": "sl-mk1-underground-belt",
    "Desc_ConveyorLiftMk2_C": "underground-belt",
    "Desc_ConveyorLiftMk3_C": "fast-underground-belt",
    "Desc_ConveyorLiftMk4_C": "express-underground-belt",
    "Desc_ConveyorLiftMk5_C": "sl-mk5-underground-belt",
    "Desc_ConveyorLiftMk6_C": "sl-mk6-underground-belt",
    "Desc_ConveyorAttachmentSplitter_C": "sl-mk1-splitter",
    "Desc_ConveyorAttachmentSplitterSmart_C": "sl-mk5-splitter",
    "Desc_ConveyorAttachmentSplitterProgrammable_C": "sl-mk6-splitter",
    # Additional mapping just for mod compatibility
    "Desc_IronIngot_C": "iron-plate",
    "Desc_CopperIngot_C": "copper-plate",
    "Desc_SteelIngot_C": "steel-plate",
    "Desc_IronRod_C": "iron-stick",
    "Desc_IronScrew_C": "iron-gear-wheel",
    "Desc_CircuitBoard_C": "electronic-circuit",
    "Desc_Computer_C": "advanced-circuit",
    "Desc_ComputerSuper_C": "processing-unit",
    "Desc_FluidCanister_C": "empty-barrel",
    "Desc_Fuel_C": "solid-fuel",
    "Desc_Plastic_C": "plastic-bar",
    "Desc_PackagedRocketFuel_C": "rocket-fuel",
    "Desc_NuclearFuelRod_C": "uranium-fuel-cell",
    "Desc_NuclearWaste_C": "used-up-uranium-fuel-cell",
    "Desc_Motor_C": "engine-unit",
    "Desc_MotorLightweight_C": "electric-engine-unit",
    "Desc_SulfuricAcid_C": "sulfuric-acid",
    "Desc_HeavyOilResidue_C": "heavy-oil",
    "Desc_Battery_C": "battery",
}
CUSTOM_ITEM_TYPE = {
    "rail": "rail-planner",
    "locomotive": "item-with-entity-data",
    "cargo-wagon": "item-with-entity-data",
}
KEEP_ORIGINAL_ICONS = {
    "offshore-pump",
    "pumpjack",
    "pipe",
    # Belts
    "sl-mk1-transport-belt",
    "transport-belt",
    "fast-transport-belt",
    "express-transport-belt",
    "sl-mk5-transport-belt",
    "sl-mk6-transport-belt",
    "sl-mk1-underground-belt",
    "underground-belt",
    "fast-underground-belt",
    "express-underground-belt",
    "sl-mk5-underground-belt",
    "sl-mk6-underground-belt",
    "sl-mk1-splitter",
    "sl-mk5-splitter",
    "sl-mk6-splitter",
    # Miners
    "burner-mining-drill",
    "electric-mining-drill",
    # Trains
    "rail",
    "rail-signal",
    "rail-chain-signal",
    "train-stop",
    "locomotive",
    "cargo-wagon",
    # Power
    "small-electric-pole",
    "medium-electric-pole",
    "substation",
    "big-electric-pole",
    "accumulator",
}
STACK_SIZES = {
    "SS_ONE": 1,
    "SS_SMALL": 50,
    "SS_MEDIUM": 100,
    "SS_BIG": 200,
    "SS_HUGE": 500,
    "SS_FLUID": None,
}
COLOR_RE = re.compile(r"\(B=(\d+),G=(\d+),R=(\d+),A=(\d+)\)")
SF_THINGS_TO_IGNORE = {
    "Recipe_CartridgeChaos_C",

    # Equipment things we're ignoring for now
    "Recipe_SpikedRebar_C",
    "Recipe_CartridgeSmart_C",
    "Recipe_Rebar_Stunshot_C",
    "Recipe_NobeliskGas_C",
    "Recipe_NobeliskShockwave_C",
    "Recipe_Rebar_Spreadshot_C",
    "Recipe_CartridgeChaos_Packaged_C",
    "Recipe_NobeliskNuke_C",
    "Recipe_Cartridge_C",
    "Recipe_Rebar_Explosive_C",
    "Recipe_NobeliskCluster_C",
    "Recipe_Nobelisk_C",

    "Recipe_FilterGasMask_C",
    "Recipe_FilterHazmat_C",
    
    "Recipe_Fireworks_01_C",
    "Recipe_Fireworks_02_C",
    "Recipe_Fireworks_03_C",

    # Pipe
    "Desc_Valve_C",  # no valves for now
    "Recipe_Valve_C",
    "Desc_Pipeline_NoIndicator_C",
    "Recipe_Pipeline_NoIndicator_C",
    "Desc_PipelineMK2_NoIndicator_C",
    "Recipe_PipelineMk2_NoIndicator_C",

    # Train Station
    "Desc_TrainDockingStation_C",
    "Desc_TrainDockingStationLiquid_C",
    "Desc_TrainPlatformEmpty_C",
    "Desc_TrainPlatformEmpty_02_C",
    # Vehicle
    "Desc_Truck_C",
    "Desc_Tractor_C",
    "Desc_Explorer_C",
    "Desc_CyberWagon_C",
}
SF_ACCEPTABLE_PRODUCTS = {
    "burner-mining-drill",
    "electric-mining-drill",
    "desc_minermk2_c",
    "desc_minermk3_c",
    "offshore-pump",
    "desc_quantumencoder_c",
    "desc_converter_c",
    "pumpjack",
    "desc_oilrefinery_c",
    "desc_foundrymk1_c",
    "desc_packager_c",
    "desc_manufacturermk1_c",
    "desc_assemblermk1_c",
    "desc_hadroncollider_c",
    "desc_blender_c",
    # "desc_frackingextractor_c",
    "desc_frackingsmasher_c",
    "desc_constructormk1_c",
    "desc_smeltermk1_c",
    "roboport",
    "flying-robot-frame",
    # Belts
    "sl-mk1-transport-belt",
    "transport-belt",
    "fast-transport-belt",
    "express-transport-belt",
    "sl-mk5-transport-belt",
    "sl-mk6-transport-belt",
    "sl-mk1-underground-belt",
    "underground-belt",
    "fast-underground-belt",
    "express-underground-belt",
    "sl-mk5-underground-belt",
    "sl-mk6-underground-belt",
    "sl-mk1-splitter",
    "sl-mk5-splitter",
    "sl-mk6-splitter",
    # Trains
    "rail",
    "rail-signal",
    "rail-chain-signal",
    "train-stop",
    "locomotive",
    "cargo-wagon",
    # Power
    "small-electric-pole",
    "medium-electric-pole",
    "substation",
    "big-electric-pole",
    "accumulator",
    "desc_generatorbiomass_automated_c",
    "desc_generatorcoal_c",
    "desc_generatorfuel_c",
    # Pipes
    "pipe",
    "pump",
    "desc_pipelinemk2_c",
    "desc_pipelinepumpmk2_c",
}

all_items = {}
all_fluids = {}
all_recipes = {}
all_subgroups = {}
assets_to_convert = {}

PRODUCT_TO_SUBGROUP = {
    # Iron
    "iron-plate": "sl-iron-smelting",
    "iron-stick":                   ("sl-iron-processing", "a"),
    "iron-gear-wheel":              ("sl-iron-processing", "b"),
    "desc_ironplate_c":             ("sl-iron-processing", "c"),
    "desc_ironplatereinforced_c":   ("sl-iron-processing", "d"),

    # Copper
    "copper-plate": "sl-copper-smelting",
    "copper-cable":         ("sl-copper-processing", "a"),
    "desc_cable_c":         ("sl-copper-processing", "b"),
    "desc_coppersheet_c":   ("sl-copper-processing", "c"),
    "desc_copperdust_c":    ("sl-copper-processing", "d"),

    # Concrete
    "concrete": "sl-concrete-smelting",

    # Steel
    "steel-plate": "sl-steel-smelting",
    "desc_steelpipe_c": "sl-steel-processing",
    "desc_steelplate_c": "sl-steel-processing",
    "desc_steelplatereinforced_c": "sl-steel-processing",

    # Quartz
    "desc_quartzcrystal_c": "sl-quartzcrystal-smelting",
    "desc_silica_c": "sl-silica-smelting",
    "desc_dissolvedsilica_c": "sl-silica-smelting",

    # Aluminium
    "desc_aluminasolution_c": "sl-aluminium-smelting",
    "desc_aluminumscrap_c": "sl-aluminium-smelting",
    "desc_aluminumingot_c": "sl-aluminium-smelting",
    "desc_aluminumplate_c": "sl-aluminium-processing",
    "desc_aluminumcasing_c": "sl-aluminium-processing",
    "desc_aluminumplatereinforced_c": "sl-aluminium-processing",
    "desc_gastank_c": "sl-aluminium-processing",

    # Caterium
    "desc_goldingot_c": "sl-caterium-smelting",
    "desc_highspeedwire_c": "sl-caterium-processing",

    # Misc Smelting
    "sulfuric-acid": "sl-misc-smelting",
    "desc_nitricacid_c": "sl-misc-smelting",
    "desc_samingot_c": "sl-misc-smelting",
    "desc_compactedcoal_c": "sl-misc-smelting",

    # Frames
    "desc_modularframe_c":           ("sl-frame-processing", "a"),
    "desc_modularframeheavy_c":      ("sl-frame-processing", "b"),
    "desc_modularframefused_c":      ("sl-frame-processing", "c"),
    "desc_pressureconversioncube_c": ("sl-frame-processing", "d"),

    # Motor
    "desc_rotor_c":          ("sl-motor-processing", "a"),
    "desc_stator_c":         ("sl-motor-processing", "b"),
    "engine-unit":           ("sl-motor-processing", "c"),
    "electric-engine-unit":  ("sl-motor-processing", "d"),

    # Circuits
    "electronic-circuit":             ("sl-circuit-processing", "a"),
    "advanced-circuit":               ("sl-circuit-processing", "b"),
    "desc_highspeedconnector_c":      ("sl-circuit-processing", "c"),
    "desc_circuitboardhighspeed_c":   ("sl-circuit-processing", "d"),
    "desc_modularframelightweight_c": ("sl-circuit-processing", "e"),
    "processing-unit":                ("sl-circuit-processing", "f"),
    "desc_temporalprocessor_c":       ("sl-circuit-processing", "g"),

    # Oil
    "plastic-bar":          ("sl-oil-processing", "a"),
    "desc_rubber_c":        ("sl-oil-processing", "b"),
    "heavy-oil":            ("sl-oil-processing", "c"),
    "desc_polymerresin_c":  ("sl-oil-processing", "d"),
    "desc_petroleumcoke_c": ("sl-oil-processing", "e"),
    "empty-barrel":         ("sl-oil-processing", "f"),

    # Fuel
    "desc_liquidfuel_c": ("sl-fuel", "a"),
    "solid-fuel": ("sl-fuel", "b"),
    "desc_liquidturbofuel_c": ("sl-fuel", "c"),
    "desc_turbofuel_c": ("sl-fuel", "d"),
    "desc_rocketfuel_c": ("sl-fuel", "e"),
    "rocket-fuel": ("sl-fuel", "f"),
    "desc_ionizedfuel_c": ("sl-fuel", "g"),
    "desc_packagedionizedfuel_c": ("sl-fuel", "h"),

    # Misc
    "desc_coolingsystem_c":             ("sl-misc-processing", "a"),
    "desc_electromagneticcontrolrod_c": ("sl-misc-processing", "b"),
    "battery":                          ("sl-misc-processing", "c"),
    "desc_crystaloscillator_c":         ("sl-misc-processing", "d"),
    "desc_quantumoscillator_c":         ("sl-misc-processing", "e"),

    # Nuclear
    "desc_uraniumcell_c":        ("sl-uranium-processing", "a"),
    "uranium-fuel-cell":         ("sl-uranium-processing", "b"),
    "desc_nonfissibleuranium_c": ("sl-plutonium-processing", "a"),
    "desc_plutoniumpellet_c":    ("sl-plutonium-processing", "b"),
    "desc_plutoniumcell_c":      ("sl-plutonium-processing", "c"),
    "desc_plutoniumfuelrod_c":   ("sl-plutonium-processing", "d"),
    "desc_ficsonium_c":           "sl-ficsonium-processing",
    "desc_ficsoniumfuelrod_c":    "sl-ficsonium-processing",

    # High Tech
    "desc_samfluctuator_c":     ("sl-high-tech", "a"),
    "desc_singularitycell_c":   ("sl-high-tech", "b"),
    "desc_ficsitemesh_c":       ("sl-high-tech", "c"),
    "desc_darkmatter_c":        ("sl-high-tech", "d"),
    "desc_diamond_c":           ("sl-high-tech", "e"),

    # Project Assembly
    "desc_spaceelevatorpart_1_c": ("sl-project-assembly", "a"),
    "desc_spaceelevatorpart_2_c": ("sl-project-assembly", "b"),
    "desc_spaceelevatorpart_3_c": ("sl-project-assembly", "c"),
    "desc_spaceelevatorpart_4_c": ("sl-project-assembly", "d"),
    "desc_spaceelevatorpart_5_c": ("sl-project-assembly", "e"),
    "desc_spaceelevatorpart_6_c": ("sl-project-assembly", "f"),
    "desc_spaceelevatorpart_7_c": ("sl-project-assembly", "g"),
    "desc_spaceelevatorpart_8_c": ("sl-project-assembly", "h"),
    "desc_spaceelevatorpart_9_c": ("sl-project-assembly", "i"),
    "desc_spaceelevatorpart_10_c": ("sl-project-assembly", "j"),
    "desc_spaceelevatorpart_11_c": ("sl-project-assembly", "k"),
    "desc_spaceelevatorpart_12_c": ("sl-project-assembly", "l"),

    # Military
    "desc_gunpowder_c": "sl-military",
    "desc_gunpowdermk2_c": "sl-military",

    # Alien
    "desc_genericbiomass_c": ("sl-biomass", "a"),
    "desc_biofuel_c":        ("sl-biomass", "b"),
    "desc_liquidbiofuel_c":  ("sl-biomass", "c"),
    "desc_aliendnacapsule_c": "sl-alien",
    "desc_alienprotein_c": "sl-alien",
    "desc_crystalshard_c": "sl-shard",
    "desc_alienpowerfuel_c": "sl-shard",
}
RECIPE_TO_SUBGROUP = {
    "recipe_fabric_c": "sl-alien",
    "recipe_alternate_coal_1_c": ("sl-biomass", "d"),
    "recipe_alternate_coal_2_c": ("sl-biomass", "e"),
    "recipe_alternate_polyesterfabric_c": ("sl-oil-processing", "f"),
}


def translate_item_name(name: str) -> str:
    if name in sf_item_to_fac_name:
        return sf_item_to_fac_name[name]
    else:
        return name.lower()


def wrap_array_pretty(data: list) -> str:
    return "{\n    " + ",\n    ".join(wrap(item, "    ") for item in data) + "\n}"


def _dict_key(key: str) -> str:
    if set(key).issubset(string.ascii_letters + "_"):
        return key
    else:
        return f'["{key}"]'


def wrap(data: typing.Any, indent: str = "") -> str:
    if isinstance(data, list | tuple):
        return "{" + ", ".join(wrap(item, indent) for item in data) + "}"

    if isinstance(data, dict):
        return (
            "{\n"
            + "\n".join(
                f"{indent}    {_dict_key(key)} = {wrap(value, f'{indent}    ')},"
                for key, value in data.items()
            )
            + f"\n{indent}}}"
        )

    if isinstance(data, bool):
        return "true" if data else "false"

    if data is None:
        return "nil"

    if isinstance(data, str) and not data.startswith("data.raw"):
        return f'"{data}"'

    return str(data)


def locale_wrap(data: str) -> str:
    return data.replace("\r\n", "\\n")


def decode_quote(s: str) -> str:
    assert s[0] == '"'
    return s[1:-1]


def create_mipmap(input_path: Path, output_path: Path, *, mimaps: int = 3) -> None:
    img = Image.open(input_path)
    if img.size != (64, 64):
        img = img.resize((64, 64))

    height = img.size[1]
    crop = img.crop((0, 0, height, height))

    result = Image.new(
        "RGBA", (sum(height // (2**mip) for mip in range(mimaps + 1)), height)
    )

    left = 0
    for mipmap in range(mimaps + 1):
        d = 2**mipmap
        smaller = crop.resize((height // d, height // d))

        result.paste(smaller, (left, 0))
        left += smaller.size[0]

    result.save(output_path)


def decode_item_list(entry: str) -> list[dict]:
    def split_ingredient(item: str) -> dict:
        raw_name, amount = item.split('",Amount=')
        name = raw_name.replace(
            "ItemClass=\"/Script/Engine.BlueprintGeneratedClass'", ""
        )[:-1].split(".")[-1]
        name = translate_item_name(name)
        return {
            "name": name,
            "amount": int(amount),
        }

    if entry:
        return [split_ingredient(raw) for raw in entry[2:-2].split("),(")]
    else:
        return []


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "satisfactory_path",
        type=Path,
        help="Path to where Satisfactory files are located",
    )
    parser.add_argument(
        "extracted_images",
        type=Path,
        help="Path to where Satisfactory images were extrcted, using FModel",
    )
    return parser


def process_item(entry: dict[str, str]) -> tuple[str, dict] | None:
    entry_name = entry["ClassName"]
    is_fluid = entry["mForm"] in {"RF_GAS", "RF_LIQUID"}
    entry_type = "fluid" if is_fluid else "item"

    if entry_name in SF_THINGS_TO_IGNORE:
        return None

    definition = {
        "type": entry_type,
    }
    if entry_name in sf_item_to_fac_name:
        entry_name = sf_item_to_fac_name[entry_name]
        definition["_update"] = True
    else:
        entry_name = entry_name.lower()
        definition["name"] = entry_name

    if entry_name not in KEEP_ORIGINAL_ICONS:
        definition["icon"] = (
            f"__satisfactory-like__/graphics/icons/generated/{entry_name}.png"
        )
        definition["icon_size"] = 64
        definition["icon_mipmaps"] = 4

        icon_name = entry["mSmallIcon"].replace("Texture2D /Game/", "")
        icon_name = icon_name[: icon_name.rfind(".")]
        assets_to_convert[icon_name] = f"graphics/icons/generated/{entry_name}.png"
    # subgroup = "raw-resource",
    # order = "d[stone]",

    energy_value = float(entry["mEnergyValue"])
    if energy_value > 0:
        if is_fluid:
            energy_value *= 1000/60
        definition["fuel_value"] = f"{energy_value}MJ"

    if entry_name in PRODUCT_TO_SUBGROUP:
        subgroup_details = PRODUCT_TO_SUBGROUP[entry_name]
        if isinstance(subgroup_details, str):
            definition["subgroup"] = subgroup_details
        else:
            definition["subgroup"], order_prefix = subgroup_details
            definition["order"] = f"{order_prefix}[{entry_name}]"

    if is_fluid:
        definition["auto_barrel"] = False
        definition["default_temperature"] = 15
        if entry["mForm"] == "RF_GAS":
            definition["gas_temperature"] = 0

        color = entry["mFluidColor"]
        b, g, r = COLOR_RE.match(color).group(1, 2, 3)
        definition["base_color"] = {
            "r": int(r) / 255,
            "g": int(g) / 255,
            "b": int(b) / 255,
        }
        definition["flow_color"] = {
            k: min(definition["base_color"][k] + 0.3, 1.0)
            for k in ("r", "g", "b")
        }

    if entry_name != "rail":
        definition["stack_size"] = STACK_SIZES[entry["mStackSize"]]
    
    (all_fluids if is_fluid else all_items)[entry_name] = definition

    output_locale[f"{entry_type}-name"][entry_name] = entry["mDisplayName"]
    output_locale[f"{entry_type}-description"][entry_name] = locale_wrap(
        entry["mDescription"]
    )

    return entry_name, definition


def item_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        process_item(entry)


def nuclear_fuel_processor(data: list[dict[str, str]]) -> None:
    for entry in data:

        defintion = process_item(entry)[1]
        defintion["fuel_category"] = "nuclear"
        
        # mAmountOfWaste!!
        # TODO: reduce the energy value by how much waste is generated and multiply recipes that generate by the same amount

        spent_fuel = entry["mSpentFuelClass"][:-1].split(".")[-1]
        if spent_fuel != "Non":
            defintion["burnt_result"] = translate_item_name(spent_fuel)


def biomass_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        defintion = process_item(entry)[1]
        defintion["fuel_category"] = "sl-biomass"


def locale_only_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        entry_name = entry["ClassName"].replace("Build_", "Desc_")
        entry_name = sf_item_to_fac_name.get(entry_name, entry_name).lower()
        for entry_type in ["entity", "item"]:
            output_locale[f"{entry_type}-name"][entry_name] = entry["mDisplayName"]
            output_locale[f"{entry_type}-description"][entry_name] = locale_wrap(
                entry["mDescription"]
            )


def building_processor(data: list[dict[str, str]]) -> None:
    interesting_categories = {
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Power/SC_Generators.SC_Generators_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Production/SC_Manufacturers.SC_Manufacturers_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Production/SC_Miners.SC_Miners_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Production/SC_OilProduction.SC_OilProduction_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Production/SC_Smelters.SC_Smelters_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_ConveyorBelts.SC_ConveyorBelts_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_ConveyLift.SC_ConveyLift_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_Trains.SC_Trains_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Power/SC_PowerPoles.SC_PowerPoles_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_Pipes.SC_Pipes_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_ConveyorAttachments.SC_ConveyorAttachments_C'",
        "/Script/Engine.BlueprintGeneratedClass'/Game/FactoryGame/Interface/UI/InGame/BuildMenu/BuildCategories/Sub_Transport/SC_Vehicles.SC_Vehicles_C'",
    }

    for entry in data:
        categories = entry["mSubCategories"][2:-2]
        if categories not in interesting_categories:
            continue

        process_item(entry)


def recipe_processor(data: list[dict[str, str]]) -> None:
    crafting_categories = {
        "/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkBenchComponent.BP_WorkBenchComponent_C": "handcraft",
        # '/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkshopComponent.BP_WorkshopComponent_C': "handcraft",
        "/Game/FactoryGame/Buildable/Factory/AssemblerMk1/Build_AssemblerMk1.Build_AssemblerMk1_C": "assembler",
        "/Game/FactoryGame/Buildable/Factory/AutomatedWorkBench/Build_AutomatedWorkBench.Build_AutomatedWorkBench_C": "handcraft",
        "/Game/FactoryGame/Buildable/Factory/Blender/Build_Blender.Build_Blender_C": "blender",
        "/Game/FactoryGame/Buildable/Factory/ConstructorMk1/Build_ConstructorMk1.Build_ConstructorMk1_C": "constructor",
        "/Game/FactoryGame/Buildable/Factory/Converter/Build_Converter.Build_Converter_C": "converter",
        "/Game/FactoryGame/Buildable/Factory/FoundryMk1/Build_FoundryMk1.Build_FoundryMk1_C": "foundry",
        "/Game/FactoryGame/Buildable/Factory/HadronCollider/Build_HadronCollider.Build_HadronCollider_C": "collider",
        "/Game/FactoryGame/Buildable/Factory/ManufacturerMk1/Build_ManufacturerMk1.Build_ManufacturerMk1_C": "manufacturer",
        "/Game/FactoryGame/Buildable/Factory/OilRefinery/Build_OilRefinery.Build_OilRefinery_C": "refinery",
        "/Game/FactoryGame/Buildable/Factory/Packager/Build_Packager.Build_Packager_C": "packager",
        "/Game/FactoryGame/Buildable/Factory/QuantumEncoder/Build_QuantumEncoder.Build_QuantumEncoder_C": "encoder",
        "/Game/FactoryGame/Buildable/Factory/SmelterMk1/Build_SmelterMk1.Build_SmelterMk1_C": "smelter",
        "/Script/FactoryGame.FGBuildableAutomatedWorkBench": "handcraft",
    }

    def get_category(produced_in: str) -> str | None:
        handcraft = False
        category = None

        for possibility in produced_in[1:-1].split(","):
            cat = crafting_categories.get(decode_quote(possibility))
            if cat == "handcraft":
                handcraft = True

            elif cat is not None:
                if category is not None:
                    print("TWO MACHINES FOR RECIPE")

                category = cat

            else:
                continue

        if category is None:
            if handcraft:
                category = "crafting"
            else:
                return None

        elif handcraft:
            category += "-handcraft"

        return category

    for entry in data:
        if not entry["mProducedIn"]:
            continue

        if entry["mRelevantEvents"]:
            continue

        entry_name = entry["ClassName"]
        if entry_name in SF_THINGS_TO_IGNORE:
            continue

        entry_name = entry_name.lower()

        category = get_category(entry["mProducedIn"])
        ingredients = decode_item_list(entry["mIngredients"])
        product = decode_item_list(entry["mProduct"])

        if category is None and len(product) == 1 and product[0]["name"] in SF_ACCEPTABLE_PRODUCTS:
            category = "crafting"

        if category is None:
            continue

        main_product = product[0]["name"]
        subgroup = f"sf-{main_product}"
        order_prefix = "r"
        order = main_product
        
        if category == "crafting":
            subgroup = "other"

        elif category == "packager":
            if entry["mDisplayName"].startswith("Packaged"):
                subgroup = "fill-barrel"
                order = ingredients[0]["name"]
            else:
                subgroup = "empty-barrel"
                order = main_product

        elif main_product in PRODUCT_TO_SUBGROUP or entry_name in RECIPE_TO_SUBGROUP:
            subgroup_details = RECIPE_TO_SUBGROUP[entry_name] if entry_name in RECIPE_TO_SUBGROUP else PRODUCT_TO_SUBGROUP[main_product]
            if isinstance(subgroup_details, str):
                subgroup = subgroup_details
            else:
                subgroup, order_prefix = subgroup_details

        else:
            parent_group = "other"
            if category == "converter":
                parent_group = "sl-converter"

            all_subgroups[subgroup] = {
                "type": "item-subgroup",
                "name": subgroup,
                "group": parent_group,
            }

        definition = {
            "type": "recipe",
            "name": entry_name,
            "ingredients": ingredients,
            "results": product,
            "main_product": "",
            "subgroup": subgroup,
            "order": f"{order_prefix}[{order}]" + ("b" if "Alternate" in entry["mDisplayName"] else "a"),
            "icon_size": 64,
            "icon_mipmaps": 4,
            "category": category,
            "always_show_made_in": True,
            "energy_required": float(entry["mManufactoringDuration"]),
        }
        if category == "crafting":
            definition["main_product"] = main_product
            definition.pop("icon_size")
            definition.pop("icon_mipmaps")
            definition.pop("subgroup")
            definition.pop("order")

        all_recipes[entry_name] = definition
        output_locale["recipe-name"][entry_name] = entry["mDisplayName"]


def resource_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        entry_name, definition = process_item(entry)
        for suffix_code, suffix_text in [
            ("", ""), ("-impure", " (Impure)"), ("-pure", " (Pure)")
        ]:
            output_locale["entity-name"][entry_name + suffix_code] = entry["mDisplayName"] + suffix_text
            output_locale["entity-description"][entry_name + suffix_code] = locale_wrap(
                entry["mDescription"]
            )


def equipment_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        entry_name = entry["ClassName"]
        if entry_name == "BP_ItemDescriptorPortableMiner_C":
            entry_name = translate_item_name(entry_name)
            entry_type = "item"

            definition = {
                "type": entry_type,
                "_update": True,
                "stack_size": STACK_SIZES[entry["mStackSize"]],
            }
            all_items[entry_name] = definition
            output_locale["entity-name"][entry_name] = entry["mDisplayName"]
            output_locale["item-name"][entry_name] = entry["mDisplayName"]
            output_locale["item-description"][entry_name] = locale_wrap(
                entry["mDescription"]
            )


_KNOWN_PROCESSORS = {
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorNuclearFuel'": nuclear_fuel_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorBiomass'": biomass_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGPowerShardDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorPowerBoosterFuel'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGVehicleDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGEquipmentDescriptor'": equipment_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGRecipe'": recipe_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGResourceDescriptor'": resource_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildingDescriptor'": building_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableManufacturer'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableManufacturerVariablePower'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableResourceExtractor'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableConveyorBelt'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableConveyorLift'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableGeneratorFuel'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableFrackingActivator'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildablePowerPole'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildablePowerStorage'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildablePipeline'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildablePipelinePump'": locale_only_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGBuildableRailroadTrack'": locale_only_processor,
}


def create_update_file(data_dict: dict, output_file: Path) -> None:
    edit_code = []
    extend_table = []

    for name, entry in data_dict.items():
        update = entry.pop("_update", False)
        if update:
            type_name = CUSTOM_ITEM_TYPE.get(name, entry.pop("type"))
            edit_code.extend(
                [
                    f'data.raw["{type_name}"]["{name}"].{key} = {wrap(value)}'
                    for key, value in entry.items()
                ]
            )
        else:
            extend_table.append(entry)

    edit_code.append("data:extend " + wrap_array_pretty(extend_table))
    output_file.write_text("\n".join(edit_code))


def create_files(extracted_images: Path) -> None:
    export_root = Path(__file__).parents[1]

    for source_name, target_name in assets_to_convert.items():
        new_image = export_root.joinpath(target_name)
        if not new_image.exists():
            print(f"Creating {target_name}")
            create_mipmap(extracted_images.joinpath(source_name + ".png"), new_image)

    create_update_file(
        all_items, export_root.joinpath("prototypes/generated-items.lua")
    )
    create_update_file(all_fluids, export_root.joinpath("prototypes/fluids.lua"))
    create_update_file(all_recipes, export_root.joinpath("prototypes/recipes.lua"))
    create_update_file(all_subgroups, export_root.joinpath("prototypes/subgroups.lua"))

    with export_root.joinpath("locale/en/generated.cfg").open("w", encoding="utf-8") as f:
        output_locale.write(f, space_around_delimiters=False)


def main():
    args = create_parser().parse_args()
    satisfactory_path: Path = args.satisfactory_path

    json_path = satisfactory_path.joinpath("CommunityResources/Docs/en-US.json")
    json_text = json_path.read_bytes().decode("utf-16-le")[1:]
    satisfactory_data = json.loads(json_text)

    output_locale["item-name"] = {}
    output_locale["item-description"] = {}
    output_locale["fluid-name"] = {}
    output_locale["fluid-description"] = {}
    output_locale["recipe-name"] = {}
    output_locale["entity-name"] = {}
    output_locale["entity-description"] = {}

    for entries in satisfactory_data:
        processor = _KNOWN_PROCESSORS.get(entries["NativeClass"])
        if processor is not None:
            processor(entries["Classes"])

    def add_item_or_fluid(array: list[dict], n) -> None:
        for entry in array:
            if entry["name"] in all_items:
                entry["type"] = "item"
            elif entry["name"] in all_fluids:
                entry["type"] = "fluid"
                entry["amount"] /= 1000/60
            else:
                raise ValueError(f"unknown item {entry['name']} ({n})")

    for recipe_name, recipe_data in all_recipes.items():
        add_item_or_fluid(recipe_data["ingredients"], recipe_name)
        add_item_or_fluid(recipe_data["results"], recipe_name)

        main_result = recipe_data["results"][0]
        result_type = main_result['type']
        if result_type == "item":
            result_type = CUSTOM_ITEM_TYPE.get(main_result['name'], result_type)
        
        if recipe_data["main_product"] == "":
            recipe_data["icon"] = (
                f'data.raw["{result_type}"]["{main_result['name']}"].icon'
            )

    create_files(args.extracted_images)


if __name__ == "__main__":
    main()
