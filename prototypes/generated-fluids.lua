data.raw["fluid"]["heavy-oil"].icons = {{
    icon = "__satisfactory-like__/graphics/icons/generated/heavy-oil.png",
    icon_size = 64,
    icon_mipmaps = 4,
}}
data.raw["fluid"]["heavy-oil"].fuel_value = "6.666666666666668MJ"
data.raw["fluid"]["heavy-oil"].subgroup = "sl-oil-processing"
data.raw["fluid"]["heavy-oil"].order = "c[heavy-oil]"
data.raw["fluid"]["heavy-oil"].auto_barrel = false
data.raw["fluid"]["heavy-oil"].default_temperature = 15
data.raw["fluid"]["heavy-oil"].base_color = {
    r = 0.42745098039215684,
    g = 0.17647058823529413,
    b = 0.47058823529411764,
}
data.raw["fluid"]["heavy-oil"].flow_color = {
    r = 0.7274509803921568,
    g = 0.4764705882352941,
    b = 0.7705882352941176,
}
data.raw["fluid"]["heavy-oil"].stack_size = nil
data.raw["fluid"]["sulfuric-acid"].icons = {{
    icon = "__satisfactory-like__/graphics/icons/generated/sulfuric-acid.png",
    icon_size = 64,
    icon_mipmaps = 4,
}}
data.raw["fluid"]["sulfuric-acid"].subgroup = "sl-misc-smelting"
data.raw["fluid"]["sulfuric-acid"].auto_barrel = false
data.raw["fluid"]["sulfuric-acid"].default_temperature = 15
data.raw["fluid"]["sulfuric-acid"].base_color = {
    r = 1.0,
    g = 1.0,
    b = 0.0,
}
data.raw["fluid"]["sulfuric-acid"].flow_color = {
    r = 1.0,
    g = 1.0,
    b = 0.3,
}
data.raw["fluid"]["sulfuric-acid"].stack_size = nil
data.raw["fluid"]["water"].icons = {{
    icon = "__satisfactory-like__/graphics/icons/generated/water.png",
    icon_size = 64,
    icon_mipmaps = 4,
}}
data.raw["fluid"]["water"].auto_barrel = false
data.raw["fluid"]["water"].default_temperature = 15
data.raw["fluid"]["water"].base_color = {
    r = 0.47843137254901963,
    g = 0.6901960784313725,
    b = 0.8313725490196079,
}
data.raw["fluid"]["water"].flow_color = {
    r = 0.7784313725490196,
    g = 0.9901960784313726,
    b = 1.0,
}
data.raw["fluid"]["water"].stack_size = nil
data.raw["fluid"]["crude-oil"].icons = {{
    icon = "__satisfactory-like__/graphics/icons/generated/crude-oil.png",
    icon_size = 64,
    icon_mipmaps = 4,
}}
data.raw["fluid"]["crude-oil"].fuel_value = "5.333333333333334MJ"
data.raw["fluid"]["crude-oil"].auto_barrel = false
data.raw["fluid"]["crude-oil"].default_temperature = 15
data.raw["fluid"]["crude-oil"].base_color = {
    r = 0.09803921568627451,
    g = 0.0,
    b = 0.09803921568627451,
}
data.raw["fluid"]["crude-oil"].flow_color = {
    r = 0.3980392156862745,
    g = 0.3,
    b = 0.3980392156862745,
}
data.raw["fluid"]["crude-oil"].stack_size = nil
data:extend {
    {
        type = "fluid",
        name = "desc_liquidfuel_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_liquidfuel_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        fuel_value = "12.5MJ",
        subgroup = "sl-fuel",
        order = "a[desc_liquidfuel_c]",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.9215686274509803,
            g = 0.49019607843137253,
            b = 0.08235294117647059,
        },
        flow_color = {
            r = 1.0,
            g = 0.7901960784313725,
            b = 0.38235294117647056,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_rocketfuel_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_rocketfuel_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        fuel_value = "60.00000000000001MJ",
        subgroup = "sl-fuel",
        order = "e[desc_rocketfuel_c]",
        auto_barrel = false,
        default_temperature = 15,
        gas_temperature = 0,
        base_color = {
            r = 0.7411764705882353,
            g = 0.1450980392156863,
            b = 0.10196078431372549,
        },
        flow_color = {
            r = 1.0,
            g = 0.44509803921568625,
            b = 0.4019607843137255,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_nitricacid_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_nitricacid_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        subgroup = "sl-misc-smelting",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.8509803921568627,
            g = 0.8509803921568627,
            b = 0.6352941176470588,
        },
        flow_color = {
            r = 1.0,
            g = 1.0,
            b = 0.9352941176470588,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_liquidturbofuel_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_liquidturbofuel_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        fuel_value = "33.333333333333336MJ",
        subgroup = "sl-fuel",
        order = "c[desc_liquidturbofuel_c]",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.8313725490196079,
            g = 0.1607843137254902,
            b = 0.1803921568627451,
        },
        flow_color = {
            r = 1.0,
            g = 0.4607843137254902,
            b = 0.48039215686274506,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_ionizedfuel_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_ionizedfuel_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        fuel_value = "83.33333333333334MJ",
        subgroup = "sl-fuel",
        order = "g[desc_ionizedfuel_c]",
        auto_barrel = false,
        default_temperature = 15,
        gas_temperature = 0,
        base_color = {
            r = 0.8352941176470589,
            g = 0.37254901960784315,
            b = 0.10196078431372549,
        },
        flow_color = {
            r = 1.0,
            g = 0.6725490196078432,
            b = 0.4019607843137255,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_darkenergy_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_darkenergy_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        auto_barrel = false,
        default_temperature = 15,
        gas_temperature = 0,
        base_color = {
            r = 0.9921568627450981,
            g = 0.6862745098039216,
            b = 0.9764705882352941,
        },
        flow_color = {
            r = 1.0,
            g = 0.9862745098039216,
            b = 1.0,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_quantumenergy_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_quantumenergy_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        auto_barrel = false,
        default_temperature = 15,
        gas_temperature = 0,
        base_color = {
            r = 0.4627450980392157,
            g = 0.9607843137254902,
            b = 0.9098039215686274,
        },
        flow_color = {
            r = 0.7627450980392156,
            g = 1.0,
            b = 1.0,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_aluminasolution_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_aluminasolution_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        subgroup = "sl-aluminium-smelting",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.7568627450980392,
            g = 0.7568627450980392,
            b = 0.7568627450980392,
        },
        flow_color = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_dissolvedsilica_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_dissolvedsilica_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        subgroup = "sl-silica-smelting",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.8862745098039215,
            g = 0.7450980392156863,
            b = 0.9333333333333333,
        },
        flow_color = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_nitrogengas_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_nitrogengas_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        auto_barrel = false,
        default_temperature = 15,
        gas_temperature = 0,
        base_color = {
            r = 0.34901960784313724,
            g = 0.34901960784313724,
            b = 0.34901960784313724,
        },
        flow_color = {
            r = 0.6490196078431372,
            g = 0.6490196078431372,
            b = 0.6490196078431372,
        },
        stack_size = nil,
    },
    {
        type = "fluid",
        name = "desc_liquidbiofuel_c",
        icons = {{
            icon = "__satisfactory-like__/graphics/icons/generated/desc_liquidbiofuel_c.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }},
        fuel_value = "12.5MJ",
        subgroup = "sl-biomass",
        order = "c[desc_liquidbiofuel_c]",
        auto_barrel = false,
        default_temperature = 15,
        base_color = {
            r = 0.23137254901960785,
            g = 0.3254901960784314,
            b = 0.17254901960784313,
        },
        flow_color = {
            r = 0.5313725490196078,
            g = 0.6254901960784314,
            b = 0.4725490196078431,
        },
        stack_size = nil,
        fuel_category = "sl-biomass",
    }
}