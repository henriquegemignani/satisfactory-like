local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local function furnacekpipepictures_a()
    return {
        north = {
            filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-k-pipe-N.png",
            priority = "extra-high",
            width = 35,
            height = 18,
            shift = util.by_pixel(2.5, 14),
            hr_version = {
                filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-k-pipe-N.png",
                priority = "extra-high",
                width = 71,
                height = 38,
                shift = util.by_pixel(2.25, 13.5),
                scale = 0.5,
            },
        },
        east = {
            filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-k-pipe-E-top.png",
            priority = "extra-high",
            width = 30, --20,
            height = 38,
            shift = util.by_pixel(-29, 1),
            hr_version = {
                filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-k-pipe-E-top.png",
                priority = "extra-high",
                width = 59, --42,
                height = 76,
                shift = util.by_pixel(-28.75, 1),
                scale = 0.5,
            },
        },
        south = {
            filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-k-pipe-S-right.png",
            priority = "extra-high",
            width = 44,
            height = 31,
            shift = util.by_pixel(0, -31.5),
            hr_version = {
                filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-k-pipe-S-right.png",
                priority = "extra-high",
                width = 88,
                height = 61,
                shift = util.by_pixel(0, -31.5),
                scale = 0.5,
            },
        },
        west = {
            filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-k-pipe-W-bottom.png",
            priority = "extra-high",
            width = 19,
            height = 37,
            shift = util.by_pixel(25.5, 1.5),
            hr_version = {
                filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-k-pipe-W-bottom.png",
                priority = "extra-high",
                width = 39,
                height = 73,
                shift = util.by_pixel(25.75, 1.25),
                scale = 0.5,
            },
        },
    }
end


-- data:extend {
--     {
--         type = "fluid",
--         name = "sl-coal-energy",
--         icons = { {
--             icon = "__satisfactory-like__/graphics/icons/energy.png",
--             icon_size = 32
--         } },
--         base_color = { 1, 1, 1 },
--         flow_color = { 1, 1, 1 },
--         auto_barrel = false,
--         default_temperature = 15,
--     },
--     {
--         type = "recipe-category",
--         name = "sl-coal-energy",
--     },
--     {
--         type = "recipe-category",
--         name = "sl-coal-sink",
--     }
-- }
-- data:extend {
--     {
--         type = "recipe",
--         name = "sl-burn-coal",
--         icons = data.raw.fluid["sl-coal-energy"].icons,
--         category = "sl-coal-energy",
--         hide_from_player_crafting = true,
--         hide_from_stats = true,
--         hidden = true,
--         energy_required = 4,
--         ingredients = { { type = "fluid", name = "water", amount = 3 } },
--         results = { { type = "fluid", name = "sl-coal-energy", amount = 10 } }
--     },
--     {
--         type = "recipe",
--         name = "sl-void-coal-energy",
--         icons = data.raw.fluid["sl-coal-energy"].icons,
--         category = "sl-coal-sink",
--         hide_from_player_crafting = true,
--         hide_from_stats = true,
--         hidden = true,
--         energy_required = 1,
--         ingredients = { { type = "fluid", name = "sl-coal-energy", amount = 150 } },
--         results = { { type = "fluid", name = "sl-coal-energy", amount = 1, probability = 0 } }
--     },
-- }

data:extend {
    {
        -- type = "furnace",
        type = "burner-generator",
        name = "desc_generatorcoal_c",
        icons = {{
            icon = "__Krastorio2Assets__/icons/entities/advanced-furnace.png",
            icon_size = 128,
            icon_mipmaps = 4,
        }},
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 1, result = "desc_generatorcoal_c" },
        max_health = 2000,
        collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
        selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },

        crafting_speed = 1,
        burner = {
            type = "burner",
            fuel_category = "sl-coal",
            effectivity = 1,
            emissions_per_minute = 30,
            fuel_inventory_size = 1,
            light_flicker = {
                color = { 0, 0, 0 },
                minimum_intensity = 0.6,
                maximum_intensity = 0.95
            },
            smoke = {
                {
                    name = "smoke",
                    north_position = util.by_pixel(-38, -47.5),
                    south_position = util.by_pixel(38.5, -32),
                    east_position = util.by_pixel(20, -70),
                    west_position = util.by_pixel(-19, -8.5),
                    frequency = 15,
                    starting_vertical_speed = 0.0,
                    starting_frame_deviation = 60
                }
            }
        },
        max_power_output = "75MW",
        energy_source = {
          type = "electric",
          usage_priority = "primary-output"
        },
        -- crafting_categories = { "sl-coal-energy" },
        -- source_inventory_size = 1,
        -- result_inventory_size = 1,

        -- fluid_boxes = {
        --     {
        --         production_type = "input",
        --         pipe_picture = furnacekpipepictures_a(),
        --         pipe_covers = pipecoverspictures(),
        --         base_area = 10,
        --         base_level = -1,
        --         pipe_connections = { { type = "input", position = { -1, -4 } } },
        --         secondary_draw_orders = { north = -1 },
        --     },
        --     {
        --         production_type = "output",
        --         base_area = 1,
        --         base_level = 1,
        --         height = 1,
        --         -- hide_connection_info = true,
        --         filter = "sl-coal-energy",
        --         pipe_connections = {
        --             { type = "output", position = { 1, -2 } },
        --         },
        --     },
        -- },

        animation = {
            layers = {
                {
                    filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace.png",
                    priority = "high",
                    width = 240,
                    height = 240,
                    shift = { 0, -0.1 },
                    frame_count = 1,
                    hr_version = {
                        filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace.png",
                        priority = "high",
                        width = 480,
                        height = 480,
                        shift = { 0, -0.1 },
                        frame_count = 1,
                        scale = 0.5,
                    },
                },
                {
                    filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-sh.png",
                    priority = "high",
                    scale = scale,
                    width = 83,
                    height = 240,
                    shift = { 3.1, -0.1 },
                    frame_count = 1,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-sh.png",
                        priority = "high",
                        width = 165,
                        height = 480,
                        shift = { 3.1, -0.1 },
                        frame_count = 1,
                        draw_as_shadow = true,
                        scale = 0.5,
                    },
                },
            },
        },
        working_visualisations = {
            {
                constant_speed = true,
                animation = {
                    filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-anim-light.png",
                    priority = "high",
                    width = 240,
                    height = 240,
                    shift = { 0, -0.1 },
                    frame_count = 28,
                    line_length = 4,
                    animation_speed = 0.8,
                    draw_as_light = true,
                    hr_version = {
                        filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-anim-light.png",
                        priority = "high",
                        width = 480,
                        height = 480,
                        shift = { 0, -0.1 },
                        frame_count = 28,
                        line_length = 4,
                        animation_speed = 0.8,
                        draw_as_light = true,
                        scale = 0.5,
                    },
                },
            },
            {
                constant_speed = true,
                animation = {
                    filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-anim-glow.png",
                    priority = "high",
                    width = 240,
                    height = 240,
                    shift = { 0, -0.1 },
                    frame_count = 28,
                    line_length = 4,
                    animation_speed = 0.8,
                    draw_as_glow = true,
                    fadeout = true,
                    blend_mode = "additive",
                    hr_version = {
                        filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-anim-glow.png",
                        priority = "high",
                        width = 480,
                        height = 480,
                        shift = { 0, -0.1 },
                        frame_count = 28,
                        line_length = 4,
                        animation_speed = 0.8,
                        draw_as_glow = true,
                        fadeout = true,
                        blend_mode = "additive",
                        scale = 0.5,
                    },
                },
            },
            {
                constant_speed = true,
                animation = {
                    filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-anim.png",
                    priority = "high",
                    width = 240,
                    height = 240,
                    shift = { 0, -0.1 },
                    frame_count = 28,
                    line_length = 4,
                    animation_speed = 0.8,
                    hr_version = {
                        filename = "__Krastorio2Assets__/entities/advanced-furnace/hr-advanced-furnace-anim.png",
                        priority = "high",
                        width = 480,
                        height = 480,
                        shift = { 0, -0.1 },
                        frame_count = 28,
                        line_length = 4,
                        animation_speed = 0.8,
                        scale = 0.5,
                    },
                },
            },
            {
                constant_speed = true,
                light = {
                    intensity = 0.65,
                    size = 4,
                    shift = { 1.29, 2 },
                    color = { r = 1, g = 0.35, b = 0.2 },
                },
            },
        },
        vehicle_impact_sound = sounds.generic_impact,
        working_sound = {
            filename = "__Krastorio2Assets__/sounds/buildings/advanced-furnace.ogg",
            volume = 0.50,
            aggregation = {
                max_count = 2,
                remove = false,
                count_already_playing = true,
            },
        },
        idle_sound = { filename = "__base__/sound/idle1.ogg" },
        dying_explosion = "big-explosion",
        resistances = {
            { type = "physical", percent = 50 },
            { type = "fire",     percent = 95 },
            { type = "impact",   percent = 80 },
        },
        damaged_trigger_effect = hit_effects.entity(),

        water_reflection = {
            pictures = {
                filename = "__Krastorio2Assets__/entities/advanced-furnace/advanced-furnace-reflection.png",
                priority = "extra-high",
                width = 80,
                height = 60,
                shift = util.by_pixel(0, 40),
                variation_count = 1,
                scale = 5,
            },
            rotate = false,
            orientation_to_variation = false,
        },

        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
    },
}


-- data.raw["fluid"]["steam"].max_temperature = 1000000

-- local generator_boiler = table.deepcopy(data.raw["boiler"]["boiler"])
-- generator_boiler.name = "desc_generatorcoal_c"
-- generator_boiler.energy_consumption = "75MW"
-- generator_boiler.energy_source.fuel_category = "sl-coal"
-- generator_boiler.target_temperature = 15 + 9000 * 1 / 0.75 * 75 / 1.8

-- local generator_engine = table.deepcopy(data.raw["generator"]["steam-engine"])
-- generator_engine.name = "desc_generatorcoal_c_engine"
-- generator_engine.minable.result = "desc_generatorcoal_c_engine"
-- generator_engine.fluid_usage_per_tick = 45 / 60 / 60
-- generator_engine.maximum_temperature = 500015
-- generator_engine.energy_source.usage_priority = "primary-output"

-- local generator_engine_item = table.deepcopy(data.raw["item"]["steam-engine"])
-- generator_engine_item.name = "desc_generatorcoal_c_engine"
-- generator_engine_item.place_result = "desc_generatorcoal_c_engine"

-- data:extend {
--     generator_boiler,
--     generator_engine,
--     generator_engine_item,
-- }

return data.raw["burner-generator"]["desc_generatorcoal_c"]