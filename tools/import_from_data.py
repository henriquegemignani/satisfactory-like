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

output_locale = configparser.ConfigParser()
sf_item_to_fac_name = {
    "Desc_Coal_C": "coal",
    "Desc_Wood_C": "wood",
    "Desc_Stone_C": "stone",
    "Desc_OreIron_C": "iron-ore",
    "Desc_OreCopper_C": "copper-ore",
    "Desc_IronPlate_C": "iron-plate",
    "Desc_IronRod_C": "iron-stick",
    "Desc_Water_C": "water",
    "Desc_Sulfur_C": "sulfur",
    "Desc_OreCopper_C": "copper-ore",
    "Desc_OreUranium_C": "uranium-ore",
    "Desc_LiquidOil_C": "crude-oil",
    "Desc_SulfuricAcid_C": "sulfuric-acid",
    "Desc_HeavyOilResidue_C": "heavy-oil",
    "ResourceSink_Battery_C": "battery",
    "Desc_Cement_C": "concrete",
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
    "Recipe_Alternate_AutomatedMiner_C",
    "Recipe_CartridgeChaos_C",
}

all_items = {}
all_fluids = {}
all_recipes = {}
all_subgroups = {}
assets_to_convert = {}

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
                f"{indent}    {_dict_key(key)} = {wrap(value, f'{indent}    ')}," for key, value in data.items()
            )
            + f"\n{indent}}}"
        )

    if isinstance(data, bool):
        return "true" if data else "false"

    if data is None:
        return "nil"

    if isinstance(data, str) and not data.startswith("data.raw."):
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

    result = Image.new("RGBA", (
        sum(height // (2 ** mip) for mip in range(mimaps + 1)),
        height
    ))

    left = 0
    for mipmap in range(mimaps + 1):
        d = 2 ** mipmap
        smaller = crop.resize((height // d, height // d))

        result.paste(smaller, (left, 0))
        left += smaller.size[0]

    result.save(output_path)



def decode_item_list(entry: str) -> list[dict]:
    def split_ingredient(item: str) -> dict:
        raw_name, amount = item.split('",Amount=')
        name = raw_name.replace("ItemClass=\"/Script/Engine.BlueprintGeneratedClass'", "")[:-1].split(".")[-1]
        if name in sf_item_to_fac_name:
            name = sf_item_to_fac_name[name]
        else:
            name = name.lower()
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
    parser.add_argument("satisfactory_path", type=Path, help="Path to where Satisfactory files are located")
    parser.add_argument("extracted_images", type=Path, help="Path to where Satisfactory images were extrcted, using FModel")
    return parser


def process_item(entry: dict[str, str]) -> tuple[str, dict]:
    entry_name = entry["ClassName"]
    is_fluid = entry["mForm"] != "RF_SOLID"
    entry_type = "fluid" if is_fluid else "item"
    
    definition = {
        "type": entry_type,
    }
    if entry_name in sf_item_to_fac_name:
        entry_name = sf_item_to_fac_name[entry_name]
        definition["_update"] = True
    else:
        entry_name = entry_name.lower()
        definition["name"] = entry_name

    definition["icon"] = f"__satisfactory-like__/graphics/icons/{entry_name}.png"
    definition["icon_size"] = 64
    definition["icon_mipmaps"] = 4

    icon_name = entry["mSmallIcon"].replace("Texture2D /Game/", "")
    icon_name = icon_name[:icon_name.rfind(".")]
    assets_to_convert[icon_name] = f"graphics/icons/{entry_name}.png"
    # subgroup = "raw-resource",
    # order = "d[stone]",

    if is_fluid:
        definition["auto_barrel"] = False
        definition["default_temperature"] = 15        
        if entry["mForm"] == "RF_GAS":
            definition["gas_temperature"] = 0

        color = entry["mFluidColor"]
        b, g, r = COLOR_RE.match(color).group(1, 2, 3)
        definition["base_color"] = definition["flow_color"] = {"r": int(r)/255, "g": int(g)/255, "b": int(b)/255}

    definition["stack_size"] = STACK_SIZES[entry["mStackSize"]]
    (all_fluids if is_fluid else all_items)[entry_name] = definition
    
    output_locale[f"{entry_type}-name"][entry_name] = entry["mDisplayName"]
    output_locale[f"{entry_type}-description"][entry_name] = locale_wrap(entry["mDescription"])

    return entry_name, definition


def item_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        process_item(entry)


def recipe_processor(data: list[dict[str, str]]) -> None:
    crafting_categories = {
        '/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkBenchComponent.BP_WorkBenchComponent_C': "handcraft",
        # '/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkshopComponent.BP_WorkshopComponent_C': "handcraft",
        '/Game/FactoryGame/Buildable/Factory/AssemblerMk1/Build_AssemblerMk1.Build_AssemblerMk1_C': "assembler",
        '/Game/FactoryGame/Buildable/Factory/AutomatedWorkBench/Build_AutomatedWorkBench.Build_AutomatedWorkBench_C': "handcraft",
        '/Game/FactoryGame/Buildable/Factory/Blender/Build_Blender.Build_Blender_C': "blender",
        '/Game/FactoryGame/Buildable/Factory/ConstructorMk1/Build_ConstructorMk1.Build_ConstructorMk1_C': "constructor",
        '/Game/FactoryGame/Buildable/Factory/Converter/Build_Converter.Build_Converter_C': "converter",
        '/Game/FactoryGame/Buildable/Factory/FoundryMk1/Build_FoundryMk1.Build_FoundryMk1_C': "foundry",
        '/Game/FactoryGame/Buildable/Factory/HadronCollider/Build_HadronCollider.Build_HadronCollider_C': "collider",
        '/Game/FactoryGame/Buildable/Factory/ManufacturerMk1/Build_ManufacturerMk1.Build_ManufacturerMk1_C': "manufacturer",
        '/Game/FactoryGame/Buildable/Factory/OilRefinery/Build_OilRefinery.Build_OilRefinery_C': "refinery",
        '/Game/FactoryGame/Buildable/Factory/Packager/Build_Packager.Build_Packager_C': "packager",
        '/Game/FactoryGame/Buildable/Factory/QuantumEncoder/Build_QuantumEncoder.Build_QuantumEncoder_C': "encoder",
        '/Game/FactoryGame/Buildable/Factory/SmelterMk1/Build_SmelterMk1.Build_SmelterMk1_C': "smelter",
        '/Script/FactoryGame.FGBuildableAutomatedWorkBench': "handcraft",
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
                # print(f"IGNORING {entry_name}")
                # Build Gun, Equipment
                return None
            
        if category is None:
            if handcraft:
                category = "handcraft"
            else:
                raise ValueError("Error")

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
        if category is None:
            continue

        ingredients = decode_item_list(entry["mIngredients"])
        product = decode_item_list(entry["mProduct"])

        main_product = product[0]["name"]
        subgroup = f"sf-{main_product}"

        if category == "packager":
            subgroup = "fill-barrel" if entry["mDisplayName"].startswith("Packaged") else "empty-barrel"
        else:
            all_subgroups[subgroup] = {"type": "item-subgroup", "name": subgroup, "group": "other"}

        definition = {
            "type": "recipe",
            "name": entry_name,
            "ingredients": ingredients,
            "results": product,
            "main_product": "",
            "subgroup": subgroup,
            "order": "b" if "Alternate" in entry["mDisplayName"] else "a",

            "icon_size": 64,
            "icon_mipmaps": 4,

            "category": category,
            "energy_required": float(entry["mManufactoringDuration"]),
        }

        all_recipes[entry_name] = definition
        output_locale["recipe-name"][entry_name] = entry["mDisplayName"]



def resource_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        entry_name, definition = process_item(entry)
        output_locale["entity-name"][entry_name] = entry["mDisplayName"]
        output_locale["entity-description"][entry_name] = locale_wrap(entry["mDescription"])


_KNOWN_PROCESSORS = {
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorNuclearFuel'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorBiomass'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGPowerShardDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptorPowerBoosterFuel'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGRecipe'": recipe_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGResourceDescriptor'": resource_processor,
}

def create_update_file(data_dict: dict, output_file: Path) -> None:
    edit_code = []
    extend_table = []

    for name, entry in data_dict.items():
        update = entry.pop("_update", False)
        if update:
            type_name = entry.pop("type")
            edit_code.extend([
                f'data.raw["{type_name}"]["{name}"].{key} = {wrap(value)}'
                for key, value in entry.items()
            ])
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

    create_update_file(all_items, export_root.joinpath("prototypes/items.lua"))
    create_update_file(all_fluids, export_root.joinpath("prototypes/fluids.lua"))
    create_update_file(all_recipes, export_root.joinpath("prototypes/recipes.lua"))
    create_update_file(all_subgroups, export_root.joinpath("prototypes/subgroups.lua"))
    
    with export_root.joinpath("locale/en/strings.cfg").open("w", encoding="utf-8") as f:
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
            else:
                raise ValueError(f"unknown item {entry['name']} ({n})")

    for recipe_name, recipe_data in all_recipes.items():
        add_item_or_fluid(recipe_data["ingredients"], recipe_name)
        add_item_or_fluid(recipe_data["results"], recipe_name)

        main_result = recipe_data["results"][0]
        recipe_data["icon"] = f"data.raw.{main_result['type']}[\"{main_result['name']}\"].icon"

    create_files(args.extracted_images)


if __name__ == "__main__":
    main()