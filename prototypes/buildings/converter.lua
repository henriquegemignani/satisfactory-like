local sounds = require("__base__.prototypes.entity.sounds")

local original_graphic_size = 8
local structure_size = 5
local shift_y = 0.75
local scale = structure_size / original_graphic_size

local pipe_patch = data.raw["assembling-machine"]["assembling-machine-3"].fluid_boxes[1].pipe_picture

-- local pipe_patch = {
--     north = util.empty_sprite(),
--     east = util.empty_sprite(),
--     south = {
--         filename = "__Krastorio2Assets__/entities/pipe-patch/pipe-patch.png",
--         priority = "high",
--         width = 28,
--         height = 25,
--         shift = { 0.01, -0.58 },
--         hr_version = {
--             filename = "__Krastorio2Assets__/entities/pipe-patch/hr-pipe-patch.png",
--             priority = "high",
--             width = 55,
--             height = 50,
--             scale = 0.5,
--             shift = { 0.01, -0.58 },
--         },
--     },
--     west = util.empty_sprite(),
-- }


return {
    type = "assembling-machine",
    name = "desc_converter_c",
    icon = "__space-exploration-graphics__/graphics/icons/nexus.png",
    icon_size = 64,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "desc_converter_c" },
    max_health = 500,
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = { { structure_size / -2 + 0.3, structure_size / -2 + 0.3 }, { structure_size / 2 - 0.3, structure_size / 2 - 0.3 } },
    selection_box = { { -structure_size / 2, -structure_size / 2 }, { structure_size / 2, structure_size / 2 } },
    display_box = { { -structure_size / 2, -structure_size / 2 - 2 }, { structure_size / 2, structure_size / 2 } },
    resistances = {
        { type = "physical", percent = 50 },
        { type = "fire",     percent = 70 },
        { type = "impact",   percent = 70 },
    },

    -- 1.1
    fluid_boxes = {
        -- Outputs
        {
            production_type = "output",
            pipe_picture = pipe_patch,
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = 1,
            pipe_connections = { { type = "output", position = { structure_size / -2 - 0.5, 0 } } },
        },
        {
            production_type = "output",
            pipe_picture = pipe_patch,
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = 1,
            pipe_connections = { { type = "output", position = { structure_size / 2 + 0.5, 0 } } },
        },
        {
            production_type = "output",
            pipe_picture = pipe_patch,
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = 1,
            pipe_connections = { { type = "output", position = { 0, structure_size / 2 + 0.5 } } },
        },
        off_when_no_fluid_recipe = true,
    },

    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
        apparent_volume = 1,
        sound = {
            filename = "__base__/sound/lab.ogg",
            volume = 0.7
        }
    },
    animation = {
        layers = {
            {
                filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-base.png",
                width = 467 / 2,
                height = 290 / 2,
                line_length = 1,
                frame_count = 1,
                repeat_count = 64,
                animation_speed = 1,
                shift = { 0 / 32, 18.5 / 32 + shift_y },
                scale = scale,
                hr_version = {
                    filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-base.png",
                    width = 467,
                    height = 290,
                    line_length = 1,
                    frame_count = 1,
                    repeat_count = 64,
                    animation_speed = 1,
                    shift = { 0 / 32, 18.5 / 32 + shift_y },
                    scale = 0.5 * scale,
                },
            },
            {
                height = 448 / 2,
                width = 402 / 2,
                frame_count = 64,
                animation_speed = 1,
                shift = { 1 / 32, -35 / 32 + shift_y },
                scale = structure_size / original_graphic_size,
                stripes =
                {
                    {
                        filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-1.png",
                        width_in_frames = 4,
                        height_in_frames = 4,
                    },
                    {
                        filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-2.png",
                        width_in_frames = 4,
                        height_in_frames = 4,
                    },
                    {
                        filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-3.png",
                        width_in_frames = 4,
                        height_in_frames = 4,
                    },
                    {
                        filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-4.png",
                        width_in_frames = 4,
                        height_in_frames = 4,
                    },
                },
                hr_version = {
                    height = 448,
                    width = 402,
                    frame_count = 64,
                    animation_speed = 1,
                    shift = { 1 / 32, -35 / 32 + shift_y },
                    scale = 0.5 * structure_size / original_graphic_size,
                    stripes =
                    {
                        {
                            filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-1.png",
                            width_in_frames = 4,
                            height_in_frames = 4,
                        },
                        {
                            filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-2.png",
                            width_in_frames = 4,
                            height_in_frames = 4,
                        },
                        {
                            filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-3.png",
                            width_in_frames = 4,
                            height_in_frames = 4,
                        },
                        {
                            filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-4.png",
                            width_in_frames = 4,
                            height_in_frames = 4,
                        },
                    },
                },
            },
            {
                draw_as_shadow = true,
                filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-shadow.png",
                width = 599 / 2,
                height = 345 / 2,
                line_length = 1,
                frame_count = 1,
                repeat_count = 64,
                animation_speed = 1,
                shift = { 1.40625, 0.34375 + shift_y },
                scale = structure_size / original_graphic_size,
                hr_version = {
                    draw_as_shadow = true,
                    filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-shadow.png",
                    width = 599,
                    height = 345,
                    line_length = 1,
                    frame_count = 1,
                    repeat_count = 64,
                    animation_speed = 1,
                    shift = { 1.40625, 0.34375 + shift_y },
                    scale = 0.5 * structure_size / original_graphic_size,
                },
            }
        }
    },
    idle_animation = {
        layers = {
            {
                filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-inactive.png",
                frame_count = 1,
                height = 541 / 2,
                width = 467 / 2,
                repeat_count = 64,
                shift = { 0 / 32, -12 / 32 + shift_y * scale },
                scale = structure_size / original_graphic_size,
                hr_version = {
                    filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-inactive.png",
                    frame_count = 1,
                    height = 541,
                    width = 467,
                    repeat_count = 64,
                    shift = { 0 / 32, -12 / 32 + shift_y * scale },
                    scale = 0.5 * structure_size / original_graphic_size,
                },
            },
            {
                draw_as_shadow = true,
                filename = "__space-exploration-graphics-3__/graphics/entity/nexus/sr/nexus-shadow.png",
                frame_count = 1,
                width = 599 / 2,
                height = 345 / 2,
                repeat_count = 64,
                shift = { 1.40625, 0.34375 + shift_y * scale },
                scale = structure_size / original_graphic_size,
                hr_version = {
                    draw_as_shadow = true,
                    filename = "__space-exploration-graphics-3__/graphics/entity/nexus/hr/nexus-shadow.png",
                    frame_count = 1,
                    width = 599,
                    height = 345,
                    repeat_count = 64,
                    shift = { 1.40625, 0.34375 + shift_y * scale },
                    scale = 0.5 * structure_size / original_graphic_size,
                },
            }
        }
    },
    crafting_categories = { 'converter', },
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 50,
    },
    energy_usage = "200MW", -- TODO: make this varied
    module_specification = nil,
    allowed_effects = nil,
    working_visualisations = {
        {
            effect = "uranium-glow", -- changes alpha based on energy source light intensity
            light = { intensity = 0.5, size = 8, shift = { 0.0, 0.0 }, color = { r = 1, g = 0.9, b = 0.5 } }
        },
    },
}
