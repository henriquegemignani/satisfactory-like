data.raw["fluid"]["steam"].max_temperature = 1000000

local generator_boiler = table.deepcopy(data.raw["boiler"]["boiler"])
generator_boiler.name = "desc_generatorcoal_c"
generator_boiler.energy_consumption = "75MW"
generator_boiler.energy_source.fuel_category = "sl-coal"
generator_boiler.target_temperature = 15 + 9000 * 1/0.75 * 75/1.8

local generator_engine = table.deepcopy(data.raw["generator"]["steam-engine"])
generator_engine.name = "desc_generatorcoal_c_engine"
generator_engine.minable.result = "desc_generatorcoal_c_engine"
generator_engine.fluid_usage_per_tick = 45/60/60
generator_engine.maximum_temperature = 500015
generator_engine.energy_source.usage_priority = "primary-output"

local generator_engine_item = table.deepcopy(data.raw["item"]["steam-engine"])
generator_engine_item.name = "desc_generatorcoal_c_engine"
generator_engine_item.place_result = "desc_generatorcoal_c_engine"

data:extend {
    generator_boiler,
    generator_engine,
    generator_engine_item,
}
