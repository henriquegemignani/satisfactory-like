function speed_multipler()
  return settings["startup"]["sl-speed-multiplier"].value
end

---Converts base icon to icons style
function adjust_to_icons(proto)
  if not proto.icons then
    assert(proto.icon, "Prototype " .. proto.name .. " doesn't have an icon or icons")
    proto.icons = {{
      icon = proto.icon,
      icon_size = proto.icon_size,
      icon_mipmaps = proto.icon_mipmaps,
    }}
    proto.icon = nil
    proto.icon_size = nil
    proto.icon_mipmaps = nil
  end
end

require("prototypes.recipe-categories")
data:extend {
  {
    type = "resource-category",
    name = "sl-resource-well"
  },
  {
    type = "fuel-category",
    name = "sl-biomass"
  },
  {
    type = "fuel-category",
    name = "sl-vehicle"
  },
  {
    type = "fuel-category",
    name = "sl-coal"
  }
}
require("prototypes.item-groups")

require("prototypes.items")
require("prototypes.generated-fluids")
require("prototypes.autoplace-controls")

require("prototypes.buildings.transport-belt")
require("prototypes.recipes")
require("prototypes.resources")
require("prototypes.entities")
require("prototypes.map-resources")

require("base-patching")

require("prototypes.speed-multiplier")