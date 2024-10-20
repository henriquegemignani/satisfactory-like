---@type data.BurnerGeneratorPrototype
local biomass_generator = table.deepcopy(data.raw["burner-generator"]["burner-generator"])
biomass_generator.name = "desc_generatorbiomass_automated_c"
biomass_generator.fast_replaceable_group = nil
biomass_generator.next_upgrade = nil
biomass_generator.max_power_output = "30MW"
biomass_generator.burner.effectivity = 1
biomass_generator.burner.fuel_category = nil
biomass_generator.burner.fuel_categories = { "sl-biomass" }

data:extend { biomass_generator }

return biomass_generator