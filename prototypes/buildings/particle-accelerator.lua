local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")


local pipe_picture = {
  north = util.empty_sprite(),
  east = util.empty_sprite(),
  south = {
    filename = "__Krastorio2Assets__/buildings/pipe-patch/pipe-patch.png",
    priority = "high",
    width = 55,
    height = 50,
    scale = 0.5,
    shift = { 0.01, -0.58 },
  },
  west = util.empty_sprite(),
}

return {
  type = "assembling-machine",
  name = "desc_hadroncollider_c",

  icons = { {
    icon = "__Krastorio2Assets__/icons/entities/matter-plant.png",
    icon_size = 128,
    icon_mipmaps = 4,
  } },
  flags = { "placeable-neutral", "placeable-player", "player-creation" },
  minable = { mining_time = 1, result = "desc_hadroncollider_c" },

  fast_replaceable_group = "assembling-machine",
  crafting_categories = { "collider" },
  crafting_speed = 1.0,
  ingredient_count = 6,
  module_slots = nil,
  allowed_effects = nil,
  energy_usage = "500MW", -- TODO: make this varied
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = { pollution = 50 },
  },

  collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
  selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },

  max_health = 2000,
  -- corpse = "kr-medium-random-pipes-remnant",
  -- dying_explosion = "medium-matter-explosion",
  damaged_trigger_effect = hit_effects.entity(),
  resistances = {
    { type = "physical", percent = 50 },
    { type = "fire",     percent = 70 },
    { type = "impact",   percent = 70 },
  },


  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
      filename = "__Krastorio2Assets__/sounds/buildings/matter-plant.ogg",
      volume = 0.60,
    },
    idle_sound = { filename = "__base__/sound/idle1.ogg" },
    apparent_volume = 0.75,
  },

  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = pipe_picture,
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { 0, -3 } } },
    },
    {
      production_type = "output",
      pipe_picture = pipe_picture,
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { { flow_direction = "output", direction = defines.direction.west, position = { -3, 0 } } },
    },
    {
      production_type = "output",
      pipe_picture = pipe_picture,
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { { flow_direction = "output", direction = defines.direction.east, position = { 3, 0 } } },
    },
    {
      production_type = "output",
      pipe_picture = pipe_picture,
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { 0, 3 } } },
    },
  },

  graphics_set = {
    animation = {
      layers = {
        {
          filename = "__Krastorio2Assets__/buildings/matter-plant/matter-plant.png",
          priority = "high",
          width = 462,
          height = 500,
          frame_count = 1,
          shift = { -0.1, -0.2 },
          scale = 0.5,
        },
        {
          filename = "__Krastorio2Assets__/buildings/matter-plant/matter-plant-sh.png",
          priority = "high",
          width = 504,
          height = 444,
          frame_count = 1,
          draw_as_shadow = true,
          shift = { 0.23, 0.24 },
          scale = 0.5,
        },
      },
    },
    working_visualisations = {
      {
        draw_as_light = true,
        blend_mode = "additive-soft",
        animation = {
          filename = "__Krastorio2Assets__/buildings/matter-plant/matter-plant-working-light.png",
          priority = "high",
          width = 462,
          height = 500,
          frame_count = 30,
          line_length = 6,
          shift = { -0.1, -0.2 },
          scale = 0.5,
          animation_speed = 0.75,
        },
      },
      {
        draw_as_glow = true,
        blend_mode = "additive-soft",
        synced_fadeout = true,
        animation = {
          filename = "__Krastorio2Assets__/buildings/matter-plant/matter-plant-working-glow.png",
          priority = "high",
          width = 462,
          height = 500,
          frame_count = 30,
          line_length = 6,
          shift = { -0.1, -0.2 },
          scale = 0.5,
          animation_speed = 0.75,
        },
      },
      {
        animation = {
          filename = "__Krastorio2Assets__/buildings/matter-plant/matter-plant-working.png",
          width = 462,
          height = 500,
          frame_count = 30,
          line_length = 6,
          shift = { -0.1, -0.2 },
          scale = 0.5,
          animation_speed = 0.75,
        },
      },
    },
  },
  icon_draw_specification = { scale = 2, shift = { 0, -0.3 } },
  icons_positioning = { { inventory_index = defines.inventory.assembling_machine_modules, shift = { 0, 1.25 } } },
}
