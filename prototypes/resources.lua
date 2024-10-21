local noise = require("noise")
local resource_autoplace = require("__core__/lualib/resource-autoplace")

local fluids = {
    ["crude-oil"] = true, ["desc_nitrogengas_c"] = true
}

local function makeStages(name, asset_folder)
    asset_folder = asset_folder or "__satisfactory-like__/graphics/entity/"
    return {
        sheet = {
            filename = asset_folder .. name .. "/" .. name .. ".png",
            priority = "extra-high",
            size = 64,
            frame_count = 8,
            variation_count = 8,
            hr_version = {
                filename = asset_folder .. name .. "/hr-" .. name .. ".png",
                priority = "extra-high",
                size = 128,
                frame_count = 8,
                variation_count = 8,
                scale = 0.5
            }
        }
    }
end

--- @param definition data.ResourceEntityPrototype
--- @return data.ResourceEntityPrototype
local function make_resource(name, definition)
    definition.type = "resource"
    definition.name = name
    definition.flags = { "placeable-neutral" }
    definition.minable = {
        mining_time = 1,
        results = {
            {
                type = fluids[name] and "fluid" or "item",
                name = name,
                amount = 1,
            }
        }
    }
    definition.collision_box = definition.collision_box or { { -0.1, -0.1 }, { 0.1, 0.1 } }
    definition.selection_box = definition.selection_box or { { -0.5, -0.5 }, { 0.5, 0.5 } }

    return definition
end

data:extend {
    make_resource("desc_oregold_c", {
        stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 },
        stages = makeStages("titanium-ore"),
        map_color = { 0.65, 0.60, 0.41 },
    }),
    make_resource("desc_rawquartz_c", {
        stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 },
        stages = {
            sheet = {
              filename = "__Krastorio2Assets__/resources/rare-metals/rare-metals.png",
              priority = "extra-high",
              width = 64,
              height = 64,
              frame_count = 8,
              variation_count = 8,
              hr_version = {
                filename = "__Krastorio2Assets__/resources/rare-metals/hr-rare-metals.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                frame_count = 8,
                variation_count = 8,
                scale = 0.5,
              },
            },
          },
          stages_effect = {
            sheet = {
              filename = "__Krastorio2Assets__/resources/rare-metals/rare-metals-glow.png",
              priority = "extra-high",
              width = 64,
              height = 64,
              frame_count = 8,
              animation_speed = 3,
              variation_count = 8,
              draw_as_glow = true,
              hr_version = {
                filename = "__Krastorio2Assets__/resources/rare-metals/hr-rare-metals-glow.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                frame_count = 8,
                animation_speed = 3,
                variation_count = 8,
                scale = 0.5,
                draw_as_glow = true,
              },
            },
          },
          effect_animation_period = 5,
          effect_animation_period_deviation = 1,
          effect_darkness_multiplier = 5,
          min_effect_alpha = 0.2,
          max_effect_alpha = 0.3,
          map_color = { r = 0.6, g = 0.3, b = 1 },
          mining_visualisation_tint = { r = 0.258, g = 0.960, b = 0.529 },
    }),
    make_resource("desc_orebauxite_c", {
        stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 },
        stages = makeStages("zircon"),
        map_color = { 0.55, 0.47, 0.45 },
    }),
    make_resource("desc_nitrogengas_c", {
        stage_counts = { 0 },
        stages = {
          sheet = {
            filename = "__Krastorio2Assets__/resources/mineral-water.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 8,
            variation_count = 1,
          },
        },
        category = "sl-resource-well",

        infinite = true,
        highlight = true,
        minimum = 60000,
        normal = 300000,
        infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 0.7,
        tree_removal_max_distance = 32 * 32,
        collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

        map_color = { 0.35, 0.35, 0.35 },
        map_grid = false,
    }),
    make_resource("sulfur", {
        stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 },
        stages = makeStages("gold-ore"),
        map_color = { 0.89, 0.89, 0.26 },
    }),
    make_resource("desc_sam_c", {
        stage_counts = { 0 },
        stages = {
            sheet = {
              filename = "__Krastorio2Assets__/resources/imersite/imersite-rift.png",
              priority = "extra-high",
              width = 250,
              height = 250,
              frame_count = 6,
              variation_count = 1,
              scale = 0.8,
              hr_version = {
                filename = "__Krastorio2Assets__/resources/imersite/hr-imersite-rift.png",
                priority = "extra-high",
                width = 500,
                height = 500,
                frame_count = 6,
                variation_count = 1,
                scale = 0.4,
              },
            },
          },
          stages_effect = {
            sheets = {
              {
                filename = "__Krastorio2Assets__/resources/imersite/imersite-rift-glow.png",
                priority = "extra-high",
                width = 250,
                height = 250,
                frame_count = 6,
                variation_count = 1,
                draw_as_glow = true,
                scale = 0.8,
                hr_version = {
                  filename = "__Krastorio2Assets__/resources/imersite/hr-imersite-rift-glow.png",
                  priority = "extra-high",
                  width = 500,
                  height = 500,
                  frame_count = 6,
                  variation_count = 1,
                  scale = 0.4,
                  draw_as_glow = true,
                },
              },
            },
          },
          effect_animation_period = 5,
          effect_animation_period_deviation = 1,
          effect_darkness_multiplier = 3.5,
          min_effect_alpha = 0.2,
          max_effect_alpha = 0.3,
          map_color = { r = 1, g = 0.5, b = 1 },
    }),
}

-- -- Make uranium very rare
-- data.raw["resource"]["uranium-ore"].autoplace = resource_autoplace.resource_autoplace_settings {
--     name = "uranium-ore",
--     order = "c",
--     base_density = 0.1,
--     random_probability = 0.5,
--     base_spots_per_km2 = 0.4,
--     has_starting_area_placement = false,
--     random_spot_size_minimum = 0.25,
--     random_spot_size_maximum = 2,
-- }

data.raw["resource"]["iron-ore"].stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 }
data.raw["resource"]["stone"].stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 }
data.raw["resource"]["coal"].stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 }
data.raw["resource"]["copper-ore"].stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 }
data.raw["resource"]["uranium-ore"].stage_counts = { 120000, 110000, 80000, 70000, 1300, 400, 150, 80 }
data.raw["resource"]["uranium-ore"].minable.mining_time = 1

data.raw["resource"]["crude-oil"].minable.results[1].amount = 60
data.raw["resource"]["desc_nitrogengas_c"].minable.results[1].amount = 60

local ore_configurations = {
    -- 92100
    ["iron-ore"] = {
        impure = {
            has_starting_area_placement = true,
        },
        normal = {
            has_starting_area_placement = true,
        },
        pure = {
            has_starting_area_placement = true,
        },
    },
    -- 69300
    ["stone"] = {
        impure = {
            has_starting_area_placement = true,
        },
        normal = {
            has_starting_area_placement = true,
        },
        pure = {
            has_starting_area_placement = true,
        },
    },
    -- 42300
    ["coal"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 36900
    ["copper-ore"] = {
        impure = {
            has_starting_area_placement = true,
        },
        normal = {
            has_starting_area_placement = true,
        },
        pure = {
            has_starting_area_placement = true,
        },
    },
    -- 15000
    ["desc_oregold_c"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 13500
    ["desc_rawquartz_c"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 12600
    ["crude-oil"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 12300
    ["desc_orebauxite_c"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 12000
    ["desc_nitrogengas_c"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 10800
    ["sulfur"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 10200
    ["desc_sam_c"] = {
        impure = {},
        normal = {},
        pure = {},
    },
    -- 2100
    ["uranium-ore"] = {
        impure = {},
        normal = {},
    },
}

for name, details in pairs(ore_configurations) do
    for rarity, properties in pairs(details) do
        resource_autoplace.initialize_patch_set(name .. "-" .. rarity, properties.has_starting_area_placement)
    end
end


for name, details in pairs(ore_configurations) do
    local resource = data.raw.resource[name]
    resource.icons = data.raw[fluids[name] and "fluid" or "item"][name].icons
    resource.icon = nil
    resource.icon_size = nil

    resource.minable.required_fluid = nil
    resource.minable.fluid_amount = nil
    resource.highlight = true
    resource.infinite = true
    resource.minimum = 100000
    resource.normal = 100000
    resource.infinite_depletion_amount = 0
    resource.resource_patch_search_radius = 15
    resource.collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } }
    resource.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
    resource.map_grid = false
    resource.stages.sheet.scale = 2
    if resource.stages.sheet.hr_version then
        resource.stages.sheet.hr_version.scale = 1
    end
    resource.autoplace = nil

    for rarity, noise_rarity in pairs { impure = 50000, pure = 200000, normal = 100000 } do
        local properties = details[rarity]
        if properties then
            local rarity_resource
            if rarity ~= "normal" then
                rarity_resource = table.deepcopy(resource)
                rarity_resource.name = name .. "-" .. rarity
                data:extend { rarity_resource }
            else
                rarity_resource = resource
            end
            rarity_resource.autoplace = resource_autoplace.resource_autoplace_settings({
                name = rarity_resource.name,
                autoplace_control_name = name,
                order = "b",
                base_density = 5,
                richness_multiplier = 1,
                base_spots_per_km2 = 0.02,
                has_starting_area_placement = properties.has_starting_area_placement,
                random_spot_size_minimum = 0.01,
                random_spot_size_maximum = 0.1,
                regular_blob_amplitude_multiplier = 1,
                starting_rq_factor_multiplier = 0.05, -- Makes patches have only one entity
                regular_rq_factor_multiplier = 0.05,
                candidate_spot_count = 22,
            })
            rarity_resource.autoplace.richness_expression = noise.to_noise_expression(noise_rarity)
        end
    end
end

for _, resource in pairs {
    data.raw["resource"]["desc_sam_c"],
    data.raw["resource"]["desc_sam_c-impure"],
    data.raw["resource"]["desc_sam_c-pure"],
} do
    resource.stages.sheet.scale = 0.5
    resource.stages.sheet.hr_version.scale = 0.25
end