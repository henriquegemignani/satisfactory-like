
local multiplier = speed_multipler()

-- Belts are already correct, since they need special handling

-- Power is changed by keep energy consumption the same, but fuel items have less energy
-- Water consumption would be increased, but we don't consume water at the moment
-- Fuel consumption still need to be increased
data.raw["generator"]["desc_generatorfuel_c"].fluid_usage_per_tick = data.raw["generator"]["desc_generatorfuel_c"].fluid_usage_per_tick * multiplier

local fuelCategoryToChange = {
    ["sl-biomass"] = true,
    ["sl-vehicle"] = true,
    ["sl-coal"] = true,
    ["nuclear"] = true,
}

for _, item in pairs(data.raw["item"]) do
    if item.fuel_category and fuelCategoryToChange[item.fuel_category] then
        print(item.name)
        local energy_suffix = item.fuel_value:sub(-2)
        local energy = tonumber(item.fuel_value:sub(1, -3)) / multiplier
        item.fuel_value = tostring(energy) .. energy_suffix
    end
end

-- Miners need to mine faster

for _, machine in pairs(MinerMachines) do
    machine.mining_speed = machine.mining_speed * multiplier
end

-- Machines need to work faster
for _, machine in pairs(ProductionMachines) do
    machine.crafting_speed = machine.crafting_speed * multiplier
end
-- TODO: make player craft faster?

-- Pumps need to be faster!
for _, machine in pairs(PumpEntities) do
    machine.pumping_speed = machine.pumping_speed * multiplier
end
data.raw["offshore-pump"]["offshore-pump"].pumping_speed = data.raw["offshore-pump"]["offshore-pump"].pumping_speed * multiplier