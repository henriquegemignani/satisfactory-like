data:extend({
  {
    type = "underground-belt",
    name = "sl-mk6-underground-belt",
    icons = {{
      icon = "__Krastorio2Assets__/icons/entities/superior-underground-belt.png",
      icon_size = 64,
    }},
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "sl-mk6-underground-belt" },
    max_health = 200,
    -- corpse = "sl-mk6-underground-belt-remnant",
    max_distance = 40,
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
    belt_animation_set = require("prototypes.buildings.transport-belts.mk6-transport-belt.animation-set"),
    fast_replaceable_group = "transport-belt",
    speed = 0.1875,
    animation_speed_coefficient = 30,
    structure = {
      direction_in = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192,
          scale = 0.5,
        },
      },
      direction_out = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          scale = 0.5,
        },
      },
      direction_in_side_loading = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192 * 3,
          scale = 0.5,
        },
      },
      direction_out_side_loading = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192 * 2,
          scale = 0.5,
        },
      },
      back_patch = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure-back-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          scale = 0.5,
        },
      },
      front_patch = {
        sheet = {
          filename = "__Krastorio2Assets__/buildings/superior-underground-belt/superior-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          scale = 0.5,
        },
      },
    },
  },
})
