local sounds = require("__base__.prototypes.entity.sounds")

data.raw["pipe"]["pipe"].fluid_box.volume = 50
data.raw["pipe"]["pipe"].next_upgrade = "desc_pipelinemk2_c"

local pump2 = table.deepcopy(data.raw["pump"]["pump"])
pump2.name = "desc_pipelinepumpmk2_c"
pump2.pumping_speed = 10                   -- 600/s
-- TODO: some visual difference
data.raw["pump"]["pump"].pumping_speed = 5 -- 300/s
data.raw["pump"]["pump"].next_upgrade = pump2.name


---@type data.PipePrototype
local pipe2 = {
    type = "pipe",
    name = "desc_pipelinemk2_c",
    icons = { {
        icon = "__Krastorio2Assets__/icons/entities/steel-pipe.png",
        icon_size = 64,
        icon_mipmaps = 4,
    } },
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.1, result = "desc_pipelinemk2_c" },

    max_health = 200,
    corpse = "pipe-remnants",
    resistances = {
        {
            type = "fire",
            percent = 90,
        },
        {
            type = "impact",
            percent = 50,
        },
    },
    fast_replaceable_group = "pipe",
    collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

    fluid_box = {
        volume = 100,
        pipe_connections = {
          { direction = defines.direction.north, position = { 0, 0 } },
          { direction = defines.direction.east, position = { 0, 0 } },
          { direction = defines.direction.south, position = { 0, 0 } },
          { direction = defines.direction.west, position = { 0, 0 } },
        },
        hide_connection_info = true,
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    horizontal_window_bounding_box = { { -0.25, -0.28125 }, { 0.25, 0.15625 } },
    vertical_window_bounding_box = { { -0.28125, -0.5 }, { 0.03125, 0.125 } },

    pictures = {
        straight_vertical_single = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-straight-vertical-single.png",
            priority = "extra-high",
            width = 160,
            height = 160,
            scale = 0.5,
        },
        straight_vertical = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-straight-vertical.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        straight_vertical_window = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-straight-vertical-window.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        straight_horizontal_window = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-straight-horizontal-window.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        straight_horizontal = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-straight-horizontal.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        corner_up_right = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-corner-up-right.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        corner_up_left = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-corner-up-left.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        corner_down_right = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-corner-down-right.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        corner_down_left = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-corner-down-left.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        t_up = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-t-up.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        t_down = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-t-down.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        t_right = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-t-right.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        t_left = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-t-left.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        cross = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-cross.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        ending_up = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-ending-up.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        ending_down = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-ending-down.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        ending_right = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-ending-right.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        ending_left = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-ending-left.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        straight_vertical_single_visualization = data.raw.pipe.pipe.pictures.straight_vertical_single_visualization,
        straight_vertical_visualization = data.raw.pipe.pipe.pictures.straight_vertical_visualization,
        straight_vertical_window_visualization = data.raw.pipe.pipe.pictures.straight_vertical_window_visualization,
        straight_horizontal_window_visualization = data.raw.pipe.pipe.pictures.straight_horizontal_window_visualization,
        straight_horizontal_visualization = data.raw.pipe.pipe.pictures.straight_horizontal_visualization,
        corner_up_right_visualization = data.raw.pipe.pipe.pictures.corner_up_right_visualization,
        corner_up_left_visualization = data.raw.pipe.pipe.pictures.corner_up_left_visualization,
        corner_down_right_visualization = data.raw.pipe.pipe.pictures.corner_down_right_visualization,
        corner_down_left_visualization = data.raw.pipe.pipe.pictures.corner_down_left_visualization,
        t_up_visualization = data.raw.pipe.pipe.pictures.t_up_visualization,
        t_down_visualization = data.raw.pipe.pipe.pictures.t_down_visualization,
        t_right_visualization = data.raw.pipe.pipe.pictures.t_right_visualization,
        t_left_visualization = data.raw.pipe.pipe.pictures.t_left_visualization,
        cross_visualization = data.raw.pipe.pipe.pictures.cross_visualization,
        ending_up_visualization = data.raw.pipe.pipe.pictures.ending_up_visualization,
        ending_down_visualization = data.raw.pipe.pipe.pictures.ending_down_visualization,
        ending_right_visualization = data.raw.pipe.pipe.pictures.ending_right_visualization,
        ending_left_visualization = data.raw.pipe.pipe.pictures.ending_left_visualization,
        straight_vertical_single_disabled_visualization = data.raw.pipe.pipe.pictures
        .straight_vertical_single_disabled_visualization,
        straight_vertical_disabled_visualization = data.raw.pipe.pipe.pictures.straight_vertical_disabled_visualization,
        straight_vertical_window_disabled_visualization = data.raw.pipe.pipe.pictures
        .straight_vertical_window_disabled_visualization,
        straight_horizontal_window_disabled_visualization = data.raw.pipe.pipe.pictures
        .straight_horizontal_window_disabled_visualization,
        straight_horizontal_disabled_visualization = data.raw.pipe.pipe.pictures
        .straight_horizontal_disabled_visualization,
        corner_up_right_disabled_visualization = data.raw.pipe.pipe.pictures.corner_up_right_disabled_visualization,
        corner_up_left_disabled_visualization = data.raw.pipe.pipe.pictures.corner_up_left_disabled_visualization,
        corner_down_right_disabled_visualization = data.raw.pipe.pipe.pictures.corner_down_right_disabled_visualization,
        corner_down_left_disabled_visualization = data.raw.pipe.pipe.pictures.corner_down_left_disabled_visualization,
        t_up_disabled_visualization = data.raw.pipe.pipe.pictures.t_up_disabled_visualization,
        t_down_disabled_visualization = data.raw.pipe.pipe.pictures.t_down_disabled_visualization,
        t_right_disabled_visualization = data.raw.pipe.pipe.pictures.t_right_disabled_visualization,
        t_left_disabled_visualization = data.raw.pipe.pipe.pictures.t_left_disabled_visualization,
        cross_disabled_visualization = data.raw.pipe.pipe.pictures.cross_disabled_visualization,
        ending_up_disabled_visualization = data.raw.pipe.pipe.pictures.ending_up_disabled_visualization,
        ending_down_disabled_visualization = data.raw.pipe.pipe.pictures.ending_down_disabled_visualization,
        ending_right_disabled_visualization = data.raw.pipe.pipe.pictures.ending_right_disabled_visualization,
        ending_left_disabled_visualization = data.raw.pipe.pipe.pictures.ending_left_disabled_visualization,
        horizontal_window_background = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-horizontal-window-background.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        vertical_window_background = {
            filename = "__Krastorio2Assets__/entities/steel-pipe/steel-pipe-vertical-window-background.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5,
        },
        fluid_background = {
            filename = "__base__/graphics/entity/pipe/fluid-background.png",
            priority = "extra-high",
            width = 64,
            height = 40,
            scale = 0.5,
        },
        low_temperature_flow = {
            filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
            priority = "extra-high",
            width = 160,
            height = 18,
        },
        middle_temperature_flow = {
            filename = "__base__/graphics/entity/pipe/fluid-flow-medium-temperature.png",
            priority = "extra-high",
            width = 160,
            height = 18,
        },
        high_temperature_flow = {
            filename = "__base__/graphics/entity/pipe/fluid-flow-high-temperature.png",
            priority = "extra-high",
            width = 160,
            height = 18,
        },
        gas_flow = {
            filename = "__base__/graphics/entity/pipe/steam.png",
            priority = "extra-high",
            line_length = 10,
            width = 48,
            height = 30,
            frame_count = 60,
            axially_symmetrical = false,
            direction_count = 1,
        },
    },
    working_sound = sounds.pipe,
}

data:extend({
    pipe2,
    pump2,
})
