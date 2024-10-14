
import argparse
import json
from pathlib import Path
import pprint


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("satisfactory_path", type=Path)
    return parser


def item_processor(data: list[dict[str, str]]) -> None:
    # pprint.pprint(data[0])
    pass



def recipe_processor(data: list[dict[str, str]]) -> None:
    for entry in data:
        if entry["mProducedIn"] == "(\"/Game/FactoryGame/Equipment/BuildGun/BP_BuildGun.BP_BuildGun_C\")":
            continue
        
        pprint.pprint(entry)
        return


_KNOWN_PROCESSORS = {
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGItemDescriptor'": item_processor,
    "/Script/CoreUObject.Class'/Script/FactoryGame.FGRecipe'": recipe_processor,
}


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


if __name__ == "__main__":
    main()