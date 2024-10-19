for name, item in pairs(data.raw["item"]) do
    ---@type data.RecipePrototype
    local void_recipe = {
        type = "recipe",
        name = "sl-void-" .. name,
        category = "sl-sinking",

        icon = item.icon,
        icon_size = item.icon_size,
        icon_mipmaps = item.icon_mipmaps,
        icons = item.icons,
        subgroup = "sl-void",

        ingredients = {
            {
                name = name,
                amount = 1,
            }
        },
        results = {},
        energy_required = 0.01,
        hidden = true,
        hide_from_stats = true,
    }
    data:extend { void_recipe }
end
