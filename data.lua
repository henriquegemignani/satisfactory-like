function speed_multipler()
  return settings["startup"]["sl-speed-multiplier"].value
end

local crafting_categories = {
  'blender', 'collider', 'converter', 'encoder',
  'handcraft', 'packager', 'refinery',

  'smelter', 'smelter-handcraft',
  'constructor', 'constructor-handcraft',
  'assembler', 'assembler-handcraft',
  'foundry', 'foundry-handcraft',
  'manufacturer', 'manufacturer-handcraft',

  "sl-sinking",
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
  speed = { bonus = 0.5 },
  consumption = { bonus = 0.75 }
}
shard.tier = 1
data.raw["item"]["desc_crystalshard_c"] = nil
data:extend { shard }

local SplitterTiers = {
  {
    recipe = "recipe_conveyorattachmentsplitter_c",
    splitter = "sl-mk1-splitter",
    ingredients = {
      ["sl-mk1-transport-belt"] = 2,
      ["desc_ironplate_c"] = 2,
      ["desc_cable_c"] = 2,
    },
  },
  {
    recipe = "splitter",
    splitter = "splitter",
    ingredients = {
      ["transport-belt"] = 2,
      ["desc_ironplatereinforced_c"] = 2,
      ["desc_cable_c"] = 2,
    },
  },
  {
    recipe = "fast-splitter",
    splitter = "fast-splitter",
    ingredients = {
      ["fast-transport-belt"] = 2,
      ["desc_steelplate_c"] = 2,
      ["desc_rotor_c"] = 2,
      ["electronic-circuit"] = 1,
    },
  },
  {
    recipe = "express-splitter",
    splitter = "express-splitter",
    ingredients = {
      ["express-transport-belt"] = 2,
      ["desc_steelplatereinforced_c"] = 2,
      ["desc_rotor_c"] = 2,
      ["desc_circuitboardhighspeed_c"] = 1,
    },
  },
  {
    recipe = "recipe_conveyorattachmentsplittersmart_c",
    splitter = "sl-mk5-splitter",
    ingredients = {
      ["sl-mk5-transport-belt"] = 2,
      ["desc_aluminumplate_c"] = 2,
      ["engine-unit"] = 2,
      ["desc_circuitboardhighspeed_c"] = 1,
    },
  },
  {
    recipe = "recipe_conveyorattachmentsplitterprogrammable_c",
    splitter = "sl-mk6-splitter",
    ingredients = {
      ["sl-mk6-transport-belt"] = 2,
      ["desc_modularframeheavy_c"] = 1,
      ["advanced-circuit"] = 2,
      ["desc_circuitboardhighspeed_c"] = 5,
    },
  }
}

for _, tier in pairs(SplitterTiers) do
  local ingredients = {}
  for name, amount in pairs(tier.ingredients) do
    table.insert(ingredients, { type = "item", name = name, amount = amount})
  end
  local recipe = data.raw["recipe"][tier.recipe]
  recipe.ingredients = ingredients
  if recipe.result then
    recipe.main_product = recipe.result
    recipe.results = {
      { type = "item", name = recipe.result, amount = 1}
    }
    recipe.category = "crafting"
    recipe.result = nil
  end
end

data.raw["recipe"]["recipe_portableminer_c"].category = "handcraft"
data.raw["recipe"]["inserter"].ingredients = {
  {
    name = "iron-plate",
    amount = 1,
  },
  {
    name = "iron-gear-wheel",
    amount = 1,
  },
  {
    name = "copper-cable",
    amount = 2,
  }
}

require("base-patching")
require("prototypes.recycling")

require("prototypes.speed-multiplier")