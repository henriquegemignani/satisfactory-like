
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
    "empty-barrel",
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
    "effectivity-module",
    "effectivity-module-2",
    "effectivity-module-3",
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