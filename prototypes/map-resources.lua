local sounds = require("__base__.prototypes.entity.sounds")

local function slug_autoplace_settings(multiplier, order_suffix, rectangle)
    local peak = {
        noise_layer = "rocks",
        noise_octaves_difference = -4,
        noise_persistence = 0.8
    }

    if rectangle ~= nil then
        local aux_center = (rectangle[2][1] + rectangle[1][1]) / 2
        local aux_range = math.abs(rectangle[2][1] - rectangle[1][1]) / 2
        local water_center = (rectangle[2][2] + rectangle[1][2]) / 2
        local water_range = math.abs(rectangle[2][2] - rectangle[1][2]) / 2

        peak["aux_optimal"] = aux_center
        peak["aux_range"] = aux_range
        peak["aux_max_range"] = water_range + 0.05

        peak["water_optimal"] = water_center
        peak["water_range"] = water_range
        peak["water_max_range"] = water_range + 0.05
    end

    return {
        order = "a[doodad]-a[slug]-" .. order_suffix,
        coverage = multiplier * 0.004,
        sharpness = 0.7,
        max_probability = multiplier * 0.5,
        peaks = { peak }
    }
end

-- desc_crystal_c: Blue Power Slug
-- desc_crystal_mk2_c: Yellow Power Slug
-- desc_crystal_mk3_c: Purple Power Slug

local function slug_resource(params)
    local color = params.color
    local result_item = params.result_item
    local icon = params.icon
    local asset = params.asset
    return {
        name = string.format("sl-%s-power-slug", color),
        type = "simple-entity",
        flags = { "placeable-neutral", "placeable-off-grid" },
        icons = {{
            icon = icon,
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        subgroup = "grass",
        order = string.format("b[decorative]-m[slug]-a[%s]", color),
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        collision_mask = {},
        minable = {
            mining_time = 4,
            results = { { name = result_item, amount = 1 } },
        },
        loot = {
            { item = result_item, probability = 1, count_min = 1, count_max = 1 }
        },
        map_color = { r = 129, g = 105, b = 78 },
        mined_sound = sounds.deconstruct_small(1.0),
        render_layer = "object",
        max_health = 2000,
        resistances = {
            {
                type = "fire",
                percent = 100
            }
        },
        autoplace = params.autoplace,
        pictures = {
            {
                filename = asset,
                width = 128,
                height = 128,
                scale = 1/4,
                hr_version = {
                    filename = asset,
                    width = 256,
                    height = 256,
                    scale = 1/8,
                }
            },
        }
    }
end

data:extend {
    slug_resource {
        color = "blue",
        result_item = "desc_crystal_c",
        icon = "__satisfactory-like__/graphics/icons/generated/desc_crystal_c.png",
        asset = "__satisfactory-like__/graphics/entity/generated/blue-slug.png",
        autoplace = slug_autoplace_settings(0.4, "c[medium]", {{0, 0}, {0.4, 0.2}}),
    },
    slug_resource {
        color = "yellow",
        result_item = "desc_crystal_mk2_c",
        icon = "__satisfactory-like__/graphics/icons/generated/desc_crystal_mk2_c.png",
        asset = "__satisfactory-like__/graphics/entity/generated/yellow-slug.png",
        autoplace = slug_autoplace_settings(0.25, "b[big]", {{0, 0.65}, {1, 1}}),
    },
    slug_resource {
        color = "blue",
        result_item = "desc_crystal_mk3_c",
        icon = "__satisfactory-like__/graphics/icons/generated/desc_crystal_mk3_c.png",
        asset = "__satisfactory-like__/graphics/entity/generated/purple-slug.png",
        autoplace = slug_autoplace_settings(0.125, "a[huge]", { { 0, 0.65 }, { 1, 1 } }),
    },
}
