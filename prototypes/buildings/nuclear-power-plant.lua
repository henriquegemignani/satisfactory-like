local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend {
    {
        type = "burner-generator",
        name = "desc_generatornuclear_c",
        icon = "__base__/graphics/icons/nuclear-reactor.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 1, result = "desc_generatornuclear_c" },
        max_health = 2000,

        collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},

        crafting_speed = 1,
        burner =  {
          type = "burner",
          fuel_category = "nuclear",
          effectivity = 1,
          fuel_inventory_size = 1,
          burnt_inventory_size = 1,
          light_flicker =
          {
            color = {0,0,0},
            minimum_intensity = 0.7,
            maximum_intensity = 0.95
          }
        },
        max_power_output = "2500MW",
        energy_source = {
          type = "electric",
          usage_priority = "primary-output"
        },
        animation = {
            layers = {
              {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor.png",
                width = 154,
                height = 158,
                shift = util.by_pixel(-6, -6),
                hr_version =
                {
                  filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor.png",
                  width = 302,
                  height = 318,
                  scale = 0.5,
                  shift = util.by_pixel(-5, -7)
                }
              },
              {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-shadow.png",
                width = 263,
                height = 162,
                shift = { 1.625 , 0 },
                draw_as_shadow = true,
                hr_version =
                {
                  filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-shadow.png",
                  width = 525,
                  height = 323,
                  scale = 0.5,
                  shift = { 1.625, 0 },
                  draw_as_shadow = true
                }
              }
            }
        },
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
          sound =
          {
            {
              filename = "__base__/sound/nuclear-reactor-1.ogg",
              volume = 0.55
            },
            {
              filename = "__base__/sound/nuclear-reactor-2.ogg",
              volume = 0.55
            }
          },
          --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
          max_sounds_per_type = 3,
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        idle_sound = { filename = "__base__/sound/idle1.ogg" },
        dying_explosion = "big-explosion",
        resistances = {
            { type = "physical", percent = 50 },
            { type = "fire",     percent = 95 },
            { type = "impact",   percent = 80 },
        },
        damaged_trigger_effect = hit_effects.entity(),

        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
    },
}