data:extend {
    -- Mod config (Setting order "aNUMBER")
    {
      type = "int-setting",
      name = "sl-speed-multiplier",
      setting_type = "startup",
      default_value = 2,
      allowed_values = { 1, 2, 4 },
      order = "a1",
    },
    {
      type = "bool-setting",
      name = "sl-train-fuel",
      setting_type = "startup",
      default_value = false,
      order = "a2",
    },
}