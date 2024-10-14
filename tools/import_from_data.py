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

all_items = {}
all_fluids = {}
all_recipes = {}
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

    if isinstance(data, str):
        return f'"{data}"'

    return str(data)


def decode_quote(s: str) -> str:
    assert s[0] == '"'
    return s[1:-1]


def create_mipmap(input_path: Path, output_path: Path) -> None:
    img = Image.open(input_path)
    if img.size == (256, 256):
        img = img.resize((64, 64))
    height = img.size[1]
    crop = img.crop((0, 0, height, height))

    left = height
    for mipmap in range(3):
        d = 2 ** (mipmap + 1)
        smaller = crop.resize((height // d, height // d))

        img.paste(smaller, (left, 0))
        left += smaller.size[0]

    img.save(output_path)



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
        definition["name"] = entry_name
        definition["icon"] = f"__satisfactory-like__/graphics/icons/{entry_name}.png"
        definition["size"] = 64
        definition["icon_mipmaps"] = 4

        icon_name = entry["mSmallIcon"].replace("Texture2D /Game/", "")
        icon_name = icon_name[:icon_name.rfind(".")]
        assets_to_convert[icon_name] = f"graphics/icons/{entry_name}.png"
        # subgroup = "raw-resource",
        # order = "d[stone]",

        if is_fluid:
            definition["default_temperature"] = 15
            
            if entry["mForm"] == "RF_GAS":
                definition["gas_temperature"] = 0
                color = entry["mGasColor"]
            else:
                color = entry["mFluidColor"]
            
            b, g, r = COLOR_RE.match(color).group(1, 2, 3)
            definition["base_color"] = definition["flow_color"] = {"r": int(r)/255, "g": int(g)/255, "b": int(b)/255}

    definition["stack_size"] = STACK_SIZES[entry["mStackSize"]]
    (all_fluids if is_fluid else all_items)[entry_name] = definition
    
    output_locale[f"{entry_type}-name"][entry_name] = entry["mDisplayName"]
    output_locale[f"{entry_type}-description"][entry_name] = entry["mDescription"]

    return entry_name, definition


def item_processor(data: list[dict[str, str]]) -> None:
    output_locale["item-name"] = {}
    output_locale["item-description"] = {}
    output_locale["fluid-name"] = {}
    output_locale["fluid-description"] = {}

    for entry in data:
        process_item(entry)


def recipe_processor(data: list[dict[str, str]]) -> None:
    crafting_categories = {
        '/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkBenchComponent.BP_WorkBenchComponent_C': "handcraft",
        '/Game/FactoryGame/Buildable/-Shared/WorkBench/BP_WorkshopComponent.BP_WorkshopComponent_C': "handcraft",
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

    for entry in data:
        if not entry["mProducedIn"]:
            continue

        handcraft = False
        category = None

        produced_in = set()
        for possibility in entry["mProducedIn"][1:-1].split(","):
            cat = crafting_categories.get(decode_quote(possibility))
            if cat == "handcraft":
                handcraft = True

            elif cat is not None:
                if category is not None:
                    print("TWO MACHINES FOR RECIPE")
                
                category = cat
                produced_in.add(cat)
            
        if category is None:
            if handcraft:
                category = "handcraft"
            else:
                # Build Gun
                continue

        elif handcraft:
            category += "-handcraft"

        # print(entry["mDisplayName"], category)


def resource_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        process_item(entry)


_KNOWN_PROCESSORS = {
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptor'": item_processor,
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
        print(f"Creating {target_name}")
        create_mipmap(
            extracted_images.joinpath(source_name + ".png"),
            export_root.joinpath(target_name)
        )

    create_update_file(all_items, export_root.joinpath("prototypes/items.lua"))
    create_update_file(all_fluids, export_root.joinpath("prototypes/fluids.lua"))


def main():
    args = create_parser().parse_args()
    satisfactory_path: Path = args.satisfactory_path

    json_path = satisfactory_path.joinpath("CommunityResources/Docs/en-US.json")
    json_text = json_path.read_bytes().decode("utf-16-le")[1:]
    satisfactory_data = json.loads(json_text)

    for entries in satisfactory_data:
        processor = _KNOWN_PROCESSORS.get(entries["NativeClass"])
        if processor is not None:
            processor(entries["Classes"])

    create_files(args.extracted_images)


if __name__ == "__main__":
    main()