data:extend({
  {
    type = "underground-belt",
    name = "sl-mk1-underground-belt",
    icons = {{
      icon = "__satisfactory-like__/graphics/icons/underground-belt/underground-belt.png",
      icon_size = 64,
    }},
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "sl-mk1-underground-belt" },
    max_health = 200,
    -- corpse = "sl-mk1-underground-belt-remnant",
    max_distance = 5,
    underground_sprite = {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5,
    },
    underground_remove_belts_sprite = {
      filename = "__core__/graphics/arrows/underground-lines-remove.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5,
    },
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
      {
        type = "impact",
        percent = 30,
      },
    },
    collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    belt_animation_set = require("prototypes.buildings.transport-belts.mk1-transport-belt.animation-set"),
    fast_replaceable_group = "transport-belt",
    next_upgrade = "underground-belt",
    speed = 0.125,
    animation_speed_coefficient = 28,
    structure = {
      direction_in = {
        sheet = {
          filename = "__satisfactory-like__/graphics/entity/underground-belt/underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192,
          scale = 0.5,
        },
      },
      direction_out = {
        sheet = {
          filename = "__satisfactory-like__/graphics/entity/underground-belt/underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          scale = 0.5,
        },
      },
      direction_in_side_loading = {
        sheet = {
          filename = "__satisfactory-like__/graphics/entity/underground-belt/underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192 * 3,
          scale = 0.5,
        },
      },
      direction_out_side_loading = {
        sheet = {
          filename = "__satisfactory-like__/graphics/entity/underground-belt/underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192 * 2,
          scale = 0.5,
        },
      },
      back_patch = data.raw["underground-belt"]["underground-belt"].structure.back_patch,
      front_patch = data.raw["underground-belt"]["underground-belt"].structure.front_patch,
    },
  },
})
