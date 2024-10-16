local resource_autoplace = require("__core__/lualib/resource-autoplace")

resource_autoplace.initialize_patch_set("desc_oregold_c", false)
resource_autoplace.initialize_patch_set("desc_rawquartz_c", false)
resource_autoplace.initialize_patch_set("desc_orebauxite_c", false)
resource_autoplace.initialize_patch_set("desc_nitrogengas_c", false)
resource_autoplace.initialize_patch_set("sl-sulfur", false)
resource_autoplace.initialize_patch_set("desc_sam_c", false)

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

-- @return ResourceEntityPrototype
local function make_resource(name, definition)
    definition.type = "resource"
    definition.name = name
    definition.icon_size = 64
    definition.icon_mipmaps = 4
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
        stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
        stages = makeStages("titanium-ore"),
        autoplace = resource_autoplace.resource_autoplace_settings {
            name = "desc_oregold_c",
            order = "c",
            base_density = 0.9,
            base_spots_per_km2 = 1.25,
            has_starting_area_placement = false,
            random_spot_size_minimum = 2,
            random_spot_size_maximum = 4,
            regular_rq_factor_multiplier = 1
        },
        map_color = { 0.65, 0.60, 0.41 },
    }),
    -- make_resource("desc_rawquartz_c", {
    --     stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
    --     stages = makeStages(""),
    -- }),
    make_resource("desc_orebauxite_c", {
        stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
        stages = makeStages("zircon"),
        autoplace = resource_autoplace.resource_autoplace_settings {
            name = "desc_orebauxite_c",
            order = "c",
            base_density = 0.9,
            base_spots_per_km2 = 1.25,
            has_starting_area_placement = false,
            random_spot_size_minimum = 2,
            random_spot_size_maximum = 4,
            regular_rq_factor_multiplier = 1
        },
        map_color = { 0.55, 0.47, 0.45 },
    }),
    make_resource("desc_nitrogengas_c", {
        stage_counts = { 0 },
        stages = data.raw["resource"]["crude-oil"].stages,
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

        autoplace = resource_autoplace.resource_autoplace_settings {
            name = "desc_nitrogengas_c",
            order = "c",
            base_density = 4,
            base_spots_per_km2 = 1.6,
            random_probability = 1 / 24,
            random_spot_size_minimum = 1,
            random_spot_size_maximum = 1, -- don't randomize spot size
            additional_richness = 200000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
            has_starting_area_placement = false,
            regular_rq_factor_multiplier = 1,
            seed1 = 101,
        },
        map_color = { 0.35, 0.35, 0.35 },
        map_grid = false,
    }),
    make_resource("sulfur", {
        stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
        stages = makeStages("gold-ore"),
        autoplace = resource_autoplace.resource_autoplace_settings {
            name = "sulfur",
            order = "c",
            base_density = 0.9,
            base_spots_per_km2 = 1.25,
            has_starting_area_placement = false,
            random_spot_size_minimum = 2,
            random_spot_size_maximum = 4,
            regular_rq_factor_multiplier = 1
        },
        map_color = { 0.89, 0.89, 0.26 },
    }),
    -- make_resource("desc_sam_c", {
    --     stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
    --     stages = makeStages(""),
    --     autoplace = resource_autoplace.resource_autoplace_settings {
    --         name = "desc_sam_c",
    --         order = "c",
    --         base_density = 0.3,
    --         base_spots_per_km2 = 0.5,
    --         has_starting_area_placement = false,
    --         random_spot_size_minimum = 2,
    --         random_spot_size_maximum = 4,
    --         regular_rq_factor_multiplier = 1
    --     },
    -- map_color = {},
    -- }),
}

-- Make uranium very rare
data.raw["resource"]["uranium-ore"].autoplace = resource_autoplace.resource_autoplace_settings {
    name = "uranium-ore",
    order = "c",
    base_density = 0.1,
    random_probability = 0.5,
    base_spots_per_km2 = 0.4,
    has_starting_area_placement = false,
    random_spot_size_minimum = 0.25,
    random_spot_size_maximum = 2,
}


for _, name in pairs {
    "iron-ore",           -- 92100
    "stone",              -- 69300
    "coal",               -- 42300
    "copper-ore",         -- 36900
    "desc_oregold_c",     -- 15000
    -- "desc_rawquartz_c",   -- 13500
    "crude-oil",          -- 12600
    "desc_orebauxite_c",  -- 12300
    "desc_nitrogengas_c", -- 12000
    "sulfur",             -- 10800
    -- "desc_sam_c",         -- 10200
    "uranium-ore",        -- 2100
} do
    local resource = data.raw.resource[name]
    resource.icon = data.raw[fluids[name] and "fluid" or "item"][name].icon
    resource.minable.required_fluid = nil
    resource.minable.fluid_amount = nil

    -- resource.highlight = true
    -- resource.infinite = true
    -- resource.minimum = 100000
    -- resource.normal = 100000
    -- resource.infinite_depletion_amount = 0
    -- resource.resource_patch_search_radius = 12

    -- resource.collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } }
    -- resource.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
    -- resource.map_grid = false

    -- resource.autoplace = resource_autoplace.resource_autoplace_settings({
    --     name = name,
    --     order = "b",
    --     base_density = 4,
    --     richness_multiplier = 1,
    --     base_spots_per_km2 = 0.005,
    --     has_starting_area_placement = true,
    --     random_spot_size_minimum = 0.01,
    --     random_spot_size_maximum = 0.1,
    --     regular_blob_amplitude_multiplier = 1,
    --     richness_post_multiplier = 1.0,
    --     starting_rq_factor_multiplier = 0.1, -- Makes patches have only one entity
    --     regular_rq_factor_multiplier = 0.1,
    --     candidate_spot_count = 22,
    -- })
end
