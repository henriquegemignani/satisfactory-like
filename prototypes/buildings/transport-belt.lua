require("prototypes.buildings.transport-belts.mk1-transport-belt.mk1-splitter")
require("prototypes.buildings.transport-belts.mk1-transport-belt.mk1-transport-belt")
require("prototypes.buildings.transport-belts.mk1-transport-belt.mk1-underground-belt")

require("prototypes.buildings.transport-belts.mk5-transport-belt.mk5-splitter")
require("prototypes.buildings.transport-belts.mk5-transport-belt.mk5-transport-belt")
require("prototypes.buildings.transport-belts.mk5-transport-belt.mk5-underground-belt")

require("prototypes.buildings.transport-belts.mk6-transport-belt.mk6-splitter")
require("prototypes.buildings.transport-belts.mk6-transport-belt.mk6-transport-belt")
require("prototypes.buildings.transport-belts.mk6-transport-belt.mk6-underground-belt")

BeltTiers = {
    {
        belt = "sl-mk1-transport-belt",
        splitter = "sl-mk1-splitter",
        underground = "sl-mk1-underground-belt",
        speed_multiplier = 1,
    },
    {
        belt = "transport-belt",
        splitter = "splitter",
        underground = "underground-belt",
        speed_multiplier = 2,
    },
    {
        belt = "fast-transport-belt",
        splitter = "fast-splitter",
        underground = "fast-underground-belt",
        speed_multiplier = 4.5,
    },
    {
        belt = "express-transport-belt",
        splitter = "express-splitter",
        underground = "express-underground-belt",
        speed_multiplier = 8,
    },
    {
        belt = "sl-mk5-transport-belt",
        splitter = "sl-mk5-splitter",
        underground = "sl-mk5-underground-belt",
        speed_multiplier = 13,
    },
    {
        belt = "sl-mk6-transport-belt",
        splitter = "sl-mk6-splitter",
        underground = "sl-mk6-underground-belt",
        speed_multiplier = 20,
    },
}

local baseSpeed = math.max(
    0.00390625, -- Factorio minimum
    speed_multipler() / 480
)

for _, tier in pairs(BeltTiers) do
    data.raw["transport-belt"][tier.belt].speed = baseSpeed * tier.speed_multiplier
    data.raw["splitter"][tier.splitter].speed = baseSpeed * tier.speed_multiplier
    data.raw["underground-belt"][tier.underground].speed = baseSpeed * tier.speed_multiplier
    data.raw["underground-belt"][tier.underground].max_distance = 10
end

for i = 1, #BeltTiers - 1 do
    data.raw["transport-belt"][BeltTiers[i].belt].next_upgrade = BeltTiers[i + 1].belt
    data.raw["splitter"][BeltTiers[i].splitter].next_upgrade = BeltTiers[i + 1].splitter
    data.raw["underground-belt"][BeltTiers[i].underground].next_upgrade = BeltTiers[i + 1].underground
end
