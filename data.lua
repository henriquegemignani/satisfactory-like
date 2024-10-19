local crafting_categories = {
    'blender', 'collider', 'converter', 'encoder',
    'handcraft', 'packager', 'refinery',

    'smelter', 'smelter-handcraft',
    'constructor', 'constructor-handcraft',
    'assembler', 'assembler-handcraft',
    'foundry', 'foundry-handcraft',
    'manufacturer', 'manufacturer-handcraft',
}
for _, cat in pairs(crafting_categories) do
    data:extend {
        {
            type = "recipe-category",
            name = cat,
        }
    }
    if cat:find("handcraft") then
        table.insert(data.raw["character"]["character"].crafting_categories, cat)
    end
end

data:extend {
  {
    type = "resource-category",
    name = "sl-resource-well"
  },
  {
    type = "fuel-category",
    name = "sl-biomass"
  },
  {
    type = "fuel-category",
    name = "sl-vehicle"
  },
  {
    type = "fuel-category",
    name = "sl-coal"
  }
}
require("prototypes.buildings.transport-belt")
require("prototypes.item-groups")
require("prototypes.subgroups")
require("prototypes.items")
require("prototypes.fluids")
require("prototypes.recipes")
require("prototypes.autoplace-controls")
require("prototypes.resources")
require("prototypes.entities")

local shard = data.raw["item"]["desc_crystalshard_c"]
shard.type = "module"
---@cast shard data.ModulePrototype
shard.category = "speed"
shard.effect = {
  speed = {bonus = 0.5},
  consumption = {bonus = 0.75}
}
shard.tier = 1
data.raw["item"]["desc_crystalshard_c"] = nil
data:extend{shard}

require("base-patching")