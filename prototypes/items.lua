local function make_belt_item(name, order, prototype)
    return {
        type = "item",
        name = name,
        icon = data.raw[prototype][name].icon,
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "belt",
        order = order,
        place_result = name,
        stack_size = 100
    }
end

data:extend {
    make_belt_item("sl-mk1-transport-belt", "a[transport-belt]-0[transport-belt]", "transport-belt"),
    make_belt_item("sl-mk5-transport-belt", "a[transport-belt]-d[transport-belt]", "transport-belt"),
    make_belt_item("sl-mk6-transport-belt", "a[transport-belt]-e[transport-belt]", "transport-belt"),
    make_belt_item("sl-mk1-underground-belt", "b[underground-belt]-0[underground-belt]", "underground-belt"),
    make_belt_item("sl-mk5-underground-belt", "b[underground-belt]-d[underground-belt]", "underground-belt"),
    make_belt_item("sl-mk6-underground-belt", "b[underground-belt]-e[underground-belt]", "underground-belt"),
    make_belt_item("sl-mk1-splitter", "c[splitter]-0[splitter]", "splitter"),
    make_belt_item("sl-mk5-splitter", "c[splitter]-d[splitter]", "splitter"),
    make_belt_item("sl-mk6-splitter", "c[splitter]-e[splitter]", "splitter"),
}

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