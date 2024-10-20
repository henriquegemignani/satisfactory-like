-- TODO: can burn any liquid with fuel value, not just Fuel.
-- Maybe just not add fuel value to the ones we don't want to burn?

local hit_effects = require("__base__/prototypes/entity/hit-effects")
local animation = {
  layers = {
    {
      filename = "__Krastorio2Assets__/entities/gas-power-station/gas-power-station.png",
      width = 190,
      height = 190,
      frame_count = 32,
      line_length = 8,
      animation_speed = 1.2,
      shift = { 0, 0 },
      hr_version = {
        filename = "__Krastorio2Assets__/entities/gas-power-station/hr-gas-power-station.png",
        width = 380,
        height = 380,
        scale = 0.5,
        frame_count = 32,
        line_length = 8,
        animation_speed = 1.2,
        shift = { 0, 0 },
      },
    },
    {
      filename = "__Krastorio2Assets__/entities/pipe-patch/pipe-patch.png",
      width = 28,
      height = 25,
      frame_count = 1,
      repeat_count = 32,
      shift = { 0, 2.5 },
      hr_version = {
        filename = "__Krastorio2Assets__/entities/pipe-patch/hr-pipe-patch.png",
        width = 55,
        height = 50,
        frame_count = 1,
        repeat_count = 32,
        scale = 0.5,
        shift = { 0, 2.5 },
      },
    },

    {
      filename = "__Krastorio2Assets__/entities/gas-power-station/gas-power-station-sh.png",
      width = 190,
      height = 190,
      frame_count = 1,
      repeat_count = 32,
      animation_speed = 1.2,
      draw_as_shadow = true,
      shift = { 0, 0 },
      hr_version = {
        filename = "__Krastorio2Assets__/entities/gas-power-station/hr-gas-power-station-sh.png",
        width = 380,
        height = 380,
        scale = 0.5,
        frame_count = 1,
        repeat_count = 32,
        animation_speed = 1.2,
        draw_as_shadow = true,
        shift = { 0, 0 },
      },
    },
  },
}

local empty_sprite = {
  filename = "__Krastorio2Assets__/entities/empty.png",
  priority = "high",
  width = 1,
  height = 1,
  scale = 0.5,
  shift = { 0, 0 },
}

local kr_pipe_path = {
  north = empty_sprite,
  east = empty_sprite,
  south = {
    filename = "__Krastorio2Assets__/entities/pipe-patch/pipe-patch.png",
    priority = "high",
    width = 28,
    height = 25,
    shift = { 0.01, -0.58 },
    hr_version = {
      filename = "__Krastorio2Assets__/entities/pipe-patch/hr-pipe-patch.png",
      priority = "high",
      width = 55,
      height = 50,
      scale = 0.5,
      shift = { 0.01, -0.58 },
    },
  },
  west = empty_sprite,
}


data:extend({
  {
    type = "trivial-smoke",
    name = "gas-power-station-smoke",
    duration = 300,
    fade_in_duration = 0,
    fade_away_duration = 180,
    spread_duration = 400,
    start_scale = 0.17,
    end_scale = 1.15,
    color = { r = 0.25, g = 0.25, b = 0.25, a = 0.75 },
    cyclic = true,
    affected_by_wind = true,
    animation = {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = { -0.53125, -0.4375 },
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png", --"__Krastorio2Assets__/entities/gas-power-station/gas-power-station-smoke.png",
      flags = { "smoke" },
    },
  },
  {
    type = "generator",
    name = "desc_generatorfuel_c",
    icon = "__Krastorio2Assets__/icons/entities/gas-power-station.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 1, result = "desc_generatorfuel_c" },
    max_health = 750,
    -- corpse = "kr-medium-random-pipes-remnant",
    dying_explosion = "medium-explosion",
    fluid_usage_per_tick = 20 / 60,
    maximum_temperature = 25,
    burns_fluid = true,
    scale_fluid_usage = true,
    destroy_non_fuel_fluid = false,
    effectivity = 1,
    resistances = {
      { type = "physical", percent = 25 },
      { type = "fire", percent = 75 },
      { type = "impact", percent = 50 },
    },
    collision_box = { { -2.3, -2.3 }, { 2.3, 2.3 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    damaged_trigger_effect = hit_effects.entity(),

    fluid_box = {
      pipe_covers = pipecoverspictures(),
      pipe_picture = kr_pipe_path,
      off_when_no_fluid_recipe = false,
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_connections = {
        { type = "input-output", position = { 3, 0 } },
        { type = "input-output", position = { -3, 0 } },
        { type = "input-output", position = { 0, 3 } },
        { type = "input-output", position = { 0, -3 } },
      },
      production_type = "input-output",
      minimum_temperature = 25.0,
    },
    energy_source = {
      type = "electric",
      usage_priority = "secondary-output",
      emissions_per_minute = 30,
    },
    horizontal_animation = animation,
    vertical_animation = animation,
    smoke = {
      {
        name = "gas-power-station-smoke",
        north_position = util.by_pixel(47, -88),
        south_position = util.by_pixel(47, -88),
        east_position = util.by_pixel(47, -88),
        west_position = util.by_pixel(47, -88),
        frequency = 0.350,
        starting_vertical_speed = 0.05,
        slow_down_factor = 1,
        starting_frame_deviation = 60,
      },
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65,
    },
    working_sound = {
      sound = {
        variations = {
          {
            filename = "__Krastorio2Assets__/sounds/buildings/gas-power-station-1.ogg",
            volume = 0.8,
          },
          {
            filename = "__Krastorio2Assets__/sounds/buildings/gas-power-station-2.ogg",
            volume = 0.75,
          },
        },
        aggregation = {
          max_count = 3,
          remove = false,
          count_already_playing = true,
        },
      },
      match_speed_to_activity = true,
      max_sounds_per_type = 3,
      fade_in_ticks = 10,
      fade_out_ticks = 30,
    },

    water_reflection = {
      pictures = {
        filename = "__Krastorio2Assets__/entities/gas-power-station/gas-power-station-reflection.png",
        priority = "extra-high",
        width = 42,
        height = 38,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    },

    audible_distance_modifier = 5,
    min_perceived_performance = 0.25,
    performance_to_sound_speedup = 0.5,
    max_power_output = "250MW",
  },
})

return data.raw["generator"]["desc_generatorfuel_c"]