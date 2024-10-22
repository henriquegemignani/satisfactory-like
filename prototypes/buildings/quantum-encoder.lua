-- Based on Krastorio's Quantum Computer
-- https://github.com/raiguard/Krastorio2/blob/7ffb9575a9cd4b297c0053ba0a20c8cfea8be928/prototypes/buildings/quantum-computer.lua

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local pipe_pictures = {
  north = {
    filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-k-pipe-N.png",
    priority = "extra-high",
    width = 78,
    height = 71,
    shift = util.by_pixel(4.25, 23),
    scale = 0.5,
  },
  east = {
    filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-k-pipe-E.png",
    priority = "extra-high",
    width = 42,
    height = 76,
    shift = util.by_pixel(-24.5, 1),
    scale = 0.5,
  },
  south = {
    filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-k-pipe-S.png",
    priority = "extra-high",
    width = 88,
    height = 61,
    shift = util.by_pixel(0, -31.25),
    scale = 0.5,
  },
  west = {
    filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-k-pipe-W.png",
    priority = "extra-high",
    width = 39,
    height = 73,
    shift = util.by_pixel(25.75, 1.25),
    scale = 0.5,
  },
}

return {
  type = "assembling-machine",
  name = "desc_quantumencoder_c",

  icons = {{
    icon = "__Krastorio2Assets__/icons/entities/quantum-computer.png",
    icon_size = 64,
    icon_mipmaps = 4,
  }},
  flags = { "placeable-neutral", "placeable-player", "player-creation" },

  minable = { mining_time = 1, result = "desc_quantumencoder_c" },

  collision_box = { { -2.8, -2.8 }, { 2.8, 2.8 } },
  selection_box = { { -2.95, -2.95 }, { 2.95, 2.95 } },

  crafting_categories = { "encoder" },
  crafting_speed = 1,
  energy_usage = "1000MW", -- FIXME

  module_slots = 0,
  allowed_effects = nil,
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = pipe_pictures,
      pipe_covers = pipecoverspictures(),
  
      volume = 1000,
      pipe_connections = {
        { flow_direction = "input", direction = defines.direction.north, position = { -0.5, -2.5 } },
      },

      secondary_draw_orders = { north = -1 },
    },
    {
      production_type = "output",
      pipe_picture = pipe_pictures,
      pipe_covers = pipecoverspictures(),

      volume = 1000,
      pipe_connections = {
        { flow_direction = "output", direction = defines.direction.south, position = { 0.5, 2.5 } },
      },

      secondary_draw_orders = { north = -1 },
    },
  },
  fluid_boxes_off_when_no_fluid_recipe = true,
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = { pollution = 5 },
    -- emissions_per_minute = { pollution = 5 },
  },
  max_health = 1000,
  -- corpse = "kr-medium-random-pipes-remnant", -- FIXME
  dying_explosion = "medium-explosion",
  damaged_trigger_effect = hit_effects.entity(),
  resistances = {
    { type = "physical", percent = 50 },
    { type = "fire",     percent = 70 },
    { type = "impact",   percent = 70 },
  },
  open_sound = { filename = "__Krastorio2Assets__/sounds/buildings/open.ogg", volume = 1 },
  close_sound = { filename = "__Krastorio2Assets__/sounds/buildings/close.ogg", volume = 1 },
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
      filename = "__Krastorio2Assets__/sounds/buildings/quantum-computer.ogg",
      volume = 0.75,
    },
    idle_sound = { filename = "__base__/sound/idle1.ogg" },
    apparent_volume = 1.5,
  },

  graphics_set = {
    animation = {
      layers = {
        {
          filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer.png",
          priority = "high",
          width = 400,
          height = 420,
          shift = { 0, -0.2 },
          frame_count = 48,
          line_length = 8,
          animation_speed = 0.25,
          scale = 0.5,
        },
        {
          filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-sh.png",
          priority = "medium",
          width = 402,
          height = 362,
          shift = { 0.19, 0.315 },
          frame_count = 1,
          repeat_count = 48,
          draw_as_shadow = true,
          animation_speed = 0.25,
          scale = 0.5,
        },
      },
    },
    working_visualisations = {
      {
        draw_as_light = true,
        animation = {
          filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-light.png",
          priority = "extra-high",
          width = 400,
          height = 420,
          shift = { 0, -0.2 },
          frame_count = 48,
          line_length = 8,
          animation_speed = 0.25,
          scale = 0.5,
        },
      },
      {
        draw_as_glow = true,
        blend_mode = "additive-soft",
        animation = {
          filename = "__Krastorio2Assets__/entities/quantum-computer/quantum-computer-glow.png",
          priority = "extra-high",
          width = 400,
          height = 420,
          shift = { 0, -0.2 },
          frame_count = 48,
          line_length = 8,
          animation_speed = 0.25,
          scale = 0.5,
        },
      },
      {
        light = {
          intensity = 0.85,
          size = 5,
          shift = { 0.0, 0.0 },
          color = { r = 0.35, g = 0.75, b = 1 },
        },
      },
    },
  },
}
