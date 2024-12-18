
data.raw["assembling-machine"]["assembling-machine-1"].crafting_categories = {"smelting"}
data.raw["assembling-machine"]["assembling-machine-2"].crafting_categories = {"smelting"}
data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories = {"smelting"}
data.raw["recipe"]["uranium-processing"].category = "collider"

data.raw["roboport"]["roboport"].construction_radius = 250
data.raw["roboport"]["roboport"].logistics_radius = 100

-- Make vanilla modules not modules at all
-- But keep around because they're used in recipes
for name, definition in pairs (data.raw["module"]) do
    if name ~= "desc_crystalshard_c" then
        definition.type = "item"
        data.raw["module"][name] = nil
        data:extend{definition}
    end
end

for _, name in pairs {
    -- Belts
    "transport-belt",
    "fast-transport-belt",
    "express-transport-belt",
    "underground-belt",
    "fast-underground-belt",
    "express-underground-belt",
    -- "splitter",
    -- "fast-splitter",
    -- "express-splitter",

    -- Drills
    "offshore-pump",
    "pumpjack",
    "burner-mining-drill",
    "electric-mining-drill",

    -- Rails
    "rail",
    "locomotive",
    "rail-signal",
    "rail-chain-signal",
    "cargo-wagon",
    "train-stop",

    -- Has Satisfactory Recipe
    "iron-plate",
    "copper-plate",
    "steel-plate",
    "copper-cable",
    "iron-stick",
    "iron-gear-wheel",
    "barrel",
    "electronic-circuit",
    "advanced-circuit",
    "processing-unit",
    "engine-unit",
    "electric-engine-unit",
    "uranium-fuel-cell",
    "sulfur",
    "plastic-bar",
    "battery",
    "sulfuric-acid",
    "concrete",
    "rocket-fuel",
    "solid-fuel-from-light-oil",
    "solid-fuel-from-heavy-oil",
    "solid-fuel-from-petroleum-gas",
    "small-electric-pole",
    "medium-electric-pole",
    "big-electric-pole",
    "substation",
    "accumulator",
    "pipe",
    "pump",
    "explosives",
    "car",
    "tank",
    "flying-robot-frame",
    "roboport",

    -- Things to just Hide
    "boiler",
    "burner-inserter",
    "steam-engine",
    "solar-panel",
    "accumulator",
    "nuclear-reactor",
    "heat-pipe",
    "heat-exchanger",
    "steam-turbine",
    "rocket-silo",
    "satellite",
    "assembling-machine-1",
    "assembling-machine-2",
    "assembling-machine-3",
    "oil-refinery",
    "chemical-plant",
    "centrifuge",
    "lab",
    "kovarex-enrichment-process",
    "nuclear-fuel-reprocessing",
    -- "uranium-processing",
    "stone-furnace",
    "steel-furnace",
    "electric-furnace",
    "lubricant",
    "basic-oil-processing",
    "advanced-oil-processing",
    "coal-liquefaction",
    "heavy-oil-cracking",
    "light-oil-cracking",
    "nuclear-fuel",

    "beacon",
    "speed-module",
    "speed-module-2",
    "speed-module-3",
    "efficiency-module",
    "efficiency-module-2",
    "efficiency-module-3",
    "productivity-module",
    "productivity-module-2",
    "productivity-module-3",

} do
    if data.raw["recipe"][name].normal then
        data.raw["recipe"][name].normal.hidden = true
    end
    data.raw["recipe"][name].hidden = true
end

data.raw["fluid"]["light-oil"].auto_barrel = false
data.raw["fluid"]["lubricant"].auto_barrel = false
data.raw["fluid"]["petroleum-gas"].auto_barrel = false