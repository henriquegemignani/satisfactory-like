local recycling_for = {}

local recycling_groups = {}

for name, recipe in pairs(data.raw["recipe"]) do
    if recipe.category == "crafting" and recipe.main_product and #recipe.main_product > 0 and recipe.results and #recipe.results == 1 then
        assert(not recycling_for[recipe.main_product])
        local target_item = data.raw["item"][recipe.main_product] or data.raw["rail-planner"][recipe.main_product] or data.raw["item-with-entity-data"][recipe.main_product]
        assert(target_item)

        local subgroup = recipe.subgroup or target_item.subgroup
        -- print(name, recipe.main_product, subgroup)
        if not recycling_groups[subgroup] then
            recycling_groups[subgroup] =  {
                type = "item-subgroup",
                name = subgroup .. "-recycle",
                group = "sl-recycle",
                order = data.raw["item-subgroup"][subgroup].order,
            }
            data:extend { recycling_groups[subgroup] }
        end

        local icons
        if recipe.icons or target_item.icons then
            icons = table.deepcopy(recipe.icons or target_item.icons)
        else
            icons = {{
                icon = recipe.icon or target_item.icon,
                icon_size = recipe.icon_size or target_item.icon_size,
                icon_mipmaps = recipe.icon_mipmaps or target_item.icon_mipmaps,
            }}
        end
        table.insert(icons, {
            icon = "__satisfactory-like__/graphics/icons/undo-x32.png",
            icon_size = 32,
            scale = 0.5,
            shift = {8, 8}
        })

        ---@type data.RecipePrototype
        local recycle = {
            type = "recipe",
            name = name .. "-recycle",

            ingredients = recipe.results,
            results = recipe.ingredients,

            energy_required = 0.5,
            category = "handcraft",
            subgroup = subgroup .. "-recycle",
            order = recipe.order or target_item.order,
            main_product = "",
            allow_decomposition = false,
            allow_as_intermediate = false,
            allow_intermediates = false,

            localised_name = {
                "recipe-name.sl-recycle",
                target_item.localised_name or {"?", {"item-name." .. recipe.main_product}, {"entity-name." .. recipe.main_product}}
            },
            icons = icons,
        }
        recycling_for[recipe.main_product] = recycle
        data:extend { recycle }
    end
end
