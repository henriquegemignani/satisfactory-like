local crafting_categories = {
    'blender', 'collider', 'converter', 'encoder',
    'handcraft', 'packager', 'refinery',
  
    'smelter', 'smelter-handcraft',
    'constructor', 'constructor-handcraft',
    'assembler', 'assembler-handcraft',
    'foundry', 'foundry-handcraft',
    'manufacturer', 'manufacturer-handcraft',
  
    "sl-sinking",
  }
  for _, cat in pairs(crafting_categories) do
    data:extend {
      {
        type = "recipe-category",
        name = cat,
      }
    }
    if cat:find("handcraft") then
      table.insert(data.raw["character"]["character"].crafting_categories, cat)
    end
  end