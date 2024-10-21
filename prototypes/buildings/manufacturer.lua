local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

return {
  type = "assembling-machine",
  name = "desc_manufacturermk1_c",
  icons = {{
    icon = "__Krastorio2Assets__/icons/entities/advanced-assembling-machine.png",
    icon_size = 64,
  }},
  flags = { "placeable-neutral", "placeable-player", "player-creation" },
  minable = { mining_time = 1, result = "desc_manufacturermk1_c" },
  max_health = 800,
  dying_explosion = "big-explosion",
  resistances = {
    { type = "physical", percent = 50 },
    { type = "fire",     percent = 95 },
    { type = "impact",   percent = 80 },
  },
  collision_box = { { -2.25, -2.25 }, { 2.25, 2.25 } },
  selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
  damaged_trigger_effect = hit_effects.entity(),

  crafting_speed = 1,
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = 5,
  },
  crafting_categories = {
    'manufacturer', 'manufacturer-handcraft', 'crafting'
  },
  energy_usage = "55MW",
  module_specification = nil,
  allowed_effects = nil,

  animation = {
    layers = {
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine.png",
        priority = "high",
        width = 160,
        height = 160,
        frame_count = 1,
        repeat_count = 32,
        animation_speed = 0.25,
        shift = { 0, 0 },
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine.png",
          priority = "high",
          width = 320,
          height = 320,
          frame_count = 1,
          repeat_count = 32,
          animation_speed = 0.25,
          shift = { 0, 0 },
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-w1.png",
        priority = "high",
        width = 64,
        height = 72,
        shift = { -1.02, 0.29 },
        frame_count = 32,
        line_length = 8,
        animation_speed = 0.1,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-w1.png",
          priority = "high",
          width = 128,
          height = 144,
          shift = { -1.02, 0.29 },
          frame_count = 32,
          line_length = 8,
          animation_speed = 0.1,
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-steam.png",
        priority = "high",
        width = 40,
        height = 40,
        shift = { -1.2, -2.1 },
        frame_count = 32,
        line_length = 8,
        animation_speed = 1.5,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-steam.png",
          priority = "high",
          width = 80,
          height = 81,
          shift = { -1.2, -2.1 },
          frame_count = 32,
          line_length = 8,
          animation_speed = 1.5,
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-sh.png",
        priority = "high",
        width = 173,
        height = 151,
        shift = { 0.32, 0.12 },
        frame_count = 1,
        repeat_count = 32,
        animation_speed = 0.1,
        draw_as_shadow = true,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-sh.png",
          priority = "high",
          width = 346,
          height = 302,
          shift = { 0.32, 0.12 },
          frame_count = 1,
          repeat_count = 32,
          animation_speed = 0.1,
          draw_as_shadow = true,
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-w2.png",
        priority = "high",
        width = 19,
        height = 13,
        frame_count = 8,
        line_length = 4,
        repeat_count = 4,
        animation_speed = 0.1,
        shift = { 0.17, -1.445 },
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-w2.png",
          priority = "high",
          width = 37,
          height = 25,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.17, -1.445 },
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-w3.png",
        priority = "high",
        width = 12,
        height = 9,
        frame_count = 8,
        line_length = 4,
        repeat_count = 4,
        animation_speed = 0.1,
        shift = { 0.93, -2.05 },
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.93, -2.05 },
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-w3.png",
        priority = "high",
        width = 12,
        height = 9,
        frame_count = 8,
        line_length = 4,
        repeat_count = 4,
        animation_speed = 0.1,
        shift = { 0.868, -0.082 },
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.868, -0.082 },
          scale = 0.5,
        },
      },
      {
        filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-w3.png",
        priority = "high",
        width = 12,
        height = 9,
        frame_count = 8,
        line_length = 4,
        repeat_count = 4,
        animation_speed = 0.1,
        shift = { 0.868, 0.552 },
        hr_version = {
          filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/hr-advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.868, 0.552 },
          scale = 0.5,
        },
      },
    },
  },
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
      {
        filename = "__Krastorio2Assets__/sounds/buildings/advanced-assembling-machine.ogg",
        volume = 0.5,
      },
    },
    idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
    apparent_volume = 1.5,
    max_sounds_per_type = 3,
    fade_in_ticks = 10,
    fade_out_ticks = 30,
  },
  idle_sound = { filename = "__base__/sound/idle1.ogg" },

  water_reflection = {
    pictures = {
      filename = "__Krastorio2Assets__/entities/advanced-assembling-machine/advanced-assembling-machine-reflection.png",
      priority = "extra-high",
      width = 70,
      height = 50,
      shift = util.by_pixel(0, 40),
      variation_count = 1,
      scale = 5,
    },
    rotate = false,
    orientation_to_variation = false,
  },
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
}
