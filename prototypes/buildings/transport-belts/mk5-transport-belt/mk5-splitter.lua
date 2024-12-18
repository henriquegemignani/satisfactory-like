data:extend({
  {
    type = "splitter",
    name = "sl-mk5-splitter",
    localised_description = { "entity-description.splitter" },
    icons = {{
      icon = "__Krastorio2Assets__/icons/entities/advanced-splitter.png",
      icon_size = 64,
    }},
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "sl-mk5-splitter" },
    max_health = 250,
    -- corpse = "sl-mk5-splitter-remnant",
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
    },
    collision_box = { { -0.9, -0.4 }, { 0.9, 0.4 } },
    selection_box = { { -0.9, -0.5 }, { 0.9, 0.5 } },
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
    belt_animation_set = require("prototypes.buildings.transport-belts.mk5-transport-belt.animation-set"),
    fast_replaceable_group = "transport-belt",
    next_upgrade = "sl-mk6-splitter",
    speed = 0.125,
    animation_speed_coefficient = 28,
    structure = {
      north = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 160,
        height = 70,
        shift = util.by_pixel(7, 0),
        scale = 0.5,
      },
      east = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 84,
        shift = util.by_pixel(4, 13),
        scale = 0.5,
      },
      south = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 164,
        height = 64,
        shift = util.by_pixel(4, 0),
        scale = 0.5,
      },
      west = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 86,
        shift = util.by_pixel(6, 12),
        scale = 0.5,
      },
    },
    structure_patch = {
      north = util.empty_sprite(),
      east = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 104,
        shift = util.by_pixel(4, -20),
        scale = 0.5,
      },
      south = util.empty_sprite(),
      west = {
        filename = "__Krastorio2Assets__/buildings/advanced-splitter/advanced-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 96,
        shift = util.by_pixel(6, -18),
        scale = 0.5,
      },
    },
  },
})
