data:extend({
  {
    type = "transport-belt",
    name = "sl-mk5-transport-belt",
    icons = {{
      icon = "__Krastorio2Assets__/icons/entities/advanced-transport-belt.png",
      icon_size = 64,
    }},
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "sl-mk5-transport-belt" },
    max_health = 200,
    -- corpse = "sl-mk5-transport-belt-remnant",
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
    },
    collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    working_sound = {
      sound = {
        filename = "__base__/sound/transport-belt.ogg",
        volume = 0.32,
      },
      persistent = true,
    },
    animations = {
      filename = "__Krastorio2Assets__/buildings/advanced-transport-belt/advanced-transport-belt.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 32,
      direction_count = 12,
      scale = 0.5,
    },
    belt_animation_set = require("prototypes.buildings.transport-belts.mk5-transport-belt.animation-set"),
    fast_replaceable_group = "transport-belt",
    next_upgrade = "sl-mk6-transport-belt",
    related_underground_belt = "sl-mk5-underground-belt",
    speed = 0.125,
    animation_speed_coefficient = 32,
    connector_frame_sprites = transport_belt_connector_frame_sprites,
    circuit_wire_connection_points = circuit_connector_definitions["belt"].points,
    circuit_connector_sprites = circuit_connector_definitions["belt"].sprites,
    circuit_wire_max_distance = transport_belt_circuit_wire_max_distance,
  },
})
