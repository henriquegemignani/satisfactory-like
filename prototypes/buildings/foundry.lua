return {
    name = "desc_foundrymk1_c",
    type = "assembling-machine",
    icon = "__satisfactory-like__/graphics/icons/arc-furnace.png",
    icon_size = 64,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "desc_foundrymk1_c" },
    max_health = 300,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = { { -2.1, -2.1 }, { 2.1, 2.1 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    crafting_categories = { 'foundry', 'foundry-handcraft', 'smelting' },
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 1,
        drain = "0.1MW",
    },
    energy_usage = "10MW",
    allowed_effects = nil,
    module_specification = nil,
    always_draw_idle_animation = true,
    idle_animation = {
        layers = {
            {
                filename = "__satisfactory-like__/graphics/entity/arc-furnace/arc-furnace-hr-shadow.png",
                size = { 600, 400 },
                shift = { 0, 0 },
                scale = 0.5,
                line_length = 1,
                frame_count = 1,
                repeat_count = 40,
                draw_as_shadow = true,
                animation_speed = 0.25,
            },
            {
                filename = "__satisfactory-like__/graphics/entity/arc-furnace/arc-furnace-hr-structure.png",
                size = { 320, 320 },
                shift = { 0, 0 },
                scale = 0.5,
                line_length = 1,
                frame_count = 1,
                repeat_count = 40,
                animation_speed = 0.25,
            },
        },
    },
    working_visualisations = {
        {
            fadeout = true,
            secondary_draw_order = 1,
            animation = {
                layers = {
                    {
                        filename =
                        "__satisfactory-like__/graphics/entity/arc-furnace/arc-furnace-hr-animation-emission-1.png",
                        size = { 320, 320 },
                        shift = { 0, 0 },
                        scale = 0.5,
                        line_length = 8,
                        lines_per_file = 8,
                        frame_count = 40,
                        draw_as_glow = true,
                        blend_mode = "additive",
                        animation_speed = 0.25,
                    },
                },
            },
        }
    },
    working_sound = {
        sound = { filename = "__base__/sound/electric-furnace.ogg", volume = 0.6 },
        apparent_volume = 0.3,
    },
}
