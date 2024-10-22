local function make_belt_item(name, order, icon)
    return {
        type = "item",
        name = name,
        icons = {
            {
                icon = icon,
                icon_size = 64,
                icon_mipmaps = 4,
            }
        },
        subgroup = "belt",
        order = order,
        place_result = name,
        stack_size = 100
    }
end

data:extend {
    make_belt_item("sl-mk1-transport-belt", "a[transport-belt]-0[transport-belt]", "__satisfactory-like__/graphics/icons/transport-belt/transport-belt.png"),
    make_belt_item("sl-mk5-transport-belt", "a[transport-belt]-d[transport-belt]", "__Krastorio2Assets__/icons/entities/transport-belts/advanced-transport-belt/advanced-transport-belt.png"),
    make_belt_item("sl-mk6-transport-belt", "a[transport-belt]-e[transport-belt]", "__Krastorio2Assets__/icons/entities/transport-belts/superior-transport-belt/superior-transport-belt.png"),
    make_belt_item("sl-mk1-underground-belt", "b[underground-belt]-0[underground-belt]", "__satisfactory-like__/graphics/icons/underground-belt/underground-belt.png"),
    make_belt_item("sl-mk5-underground-belt", "b[underground-belt]-d[underground-belt]", "__Krastorio2Assets__/icons/entities/transport-belts/advanced-transport-belt/advanced-underground-belt.png"),
    make_belt_item("sl-mk6-underground-belt", "b[underground-belt]-e[underground-belt]", "__Krastorio2Assets__/icons/entities/transport-belts/superior-transport-belt/superior-underground-belt.png"),
    make_belt_item("sl-mk1-splitter", "c[splitter]-0[splitter]", "__satisfactory-like__/graphics/icons/splitter/splitter.png"),
    make_belt_item("sl-mk5-splitter", "c[splitter]-d[splitter]", "__Krastorio2Assets__/icons/entities/transport-belts/advanced-transport-belt/advanced-splitter.png"),
    make_belt_item("sl-mk6-splitter", "c[splitter]-e[splitter]", "__Krastorio2Assets__/icons/entities/transport-belts/superior-transport-belt/superior-splitter.png"),
}

adjust_to_icons(data.raw["item"]["burner-mining-drill"])

require("prototypes.generated-items")
data.raw["item"]["battery"].fuel_category = "sl-vehicle"
data.raw["item"]["solid-fuel"].fuel_category = "sl-vehicle"
data.raw["item"]["rocket-fuel"].fuel_category = "sl-vehicle"
data.raw["item"]["desc_packagedionizedfuel_c"].fuel_category = "sl-vehicle"
data.raw["item"]["desc_turbofuel_c"].fuel_category = "sl-vehicle"
data.raw["item"]["desc_packagedoilresidue_c"].fuel_category = "sl-vehicle"
data.raw["item"]["desc_packagedoil_c"].fuel_category = "sl-vehicle"
data.raw["item"]["coal"].fuel_category = "sl-coal"
data.raw["item"]["desc_compactedcoal_c"].fuel_category = "sl-coal"
data.raw["item"]["desc_petroleumcoke_c"].fuel_category = "sl-coal"

data.raw["item"]["coal"].dark_background_icon = nil

-- Power Shards
local shard = data.raw["module"]["desc_crystalshard_c"]
shard.tier = 1
shard.category = "speed"
shard.effect = {
    speed = { bonus = 0.5 },
    consumption = { bonus = 0.75 }
}

-- Packaged Fuel has Empty Canister as spent result
if settings["startup"]["sl-packaged-fuel-return-canister"].value then
    for _, name in pairs({
        "solid-fuel", "rocket-fuel", "desc_packagedionizedfuel_c", "desc_turbofuel_c", "desc_packagedoilresidue_c", "desc_packagedoil_c", "desc_packagedbiofuel_c", 
    }) do
        data.raw["item"][name].burnt_result = "barrel"
    end
end
