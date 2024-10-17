---Creates a new entity type
---@param params any
---@return data.EntityWithOwnerPrototype
local function create_entity(params)
    local item = params.item

    -- Not a duplicated entity?
    assert(not data.raw[params.base.type][params.item.name])

    ---@type data.EntityWithOwnerPrototype
    local result = table.deepcopy(params.base)
    result.name = params.item.name
    result.fast_replaceable_group = nil
    result.next_upgrade = nil
    result.minable.result = item.name
    return result
end

---Creates a new entity type
---@param params any
---@return data.CraftingMachinePrototype
local function create_assembler(params)
    local item = params.item

    ---@type data.CraftingMachinePrototype
    local result = create_entity(params)
    result.crafting_speed = 1
    result.crafting_categories = params.crafting_categories
    result.energy_usage = params.energy_usage
    result.allowed_effects = nil
    result.module_specification = nil
    return result
end

local function copy_art_from(target, source)
    local fields = {
        "collision_box",
        "selection_box",

        "icon",
        "icon_size",
        "icon_mipmaps",
        "corpse",
        "dying_explosion",
        "vehicle_impact_sound",
        "open_sound",
        "close_sound",
        "working_sound",
        "animation",
        "working_visualisations",
        "water_reflection",
        "alert_icon_shift",
    }

    for _, field in pairs(fields) do
        target[field] = source[field]
    end
end

local machines = {
    -- smelter
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-1"],
        item = data.raw["item"]["desc_smeltermk1_c"],
        crafting_categories = { 'smelter', 'smelter-handcraft', },
        energy_usage = "4MW",
    },
    -- constructor
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-1"],
        item = data.raw["item"]["desc_constructormk1_c"],
        crafting_categories = { 'constructor', 'constructor-handcraft', },
        energy_usage = "4MW",
    },
    -- asembler
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-2"],
        item = data.raw["item"]["desc_assemblermk1_c"],
        crafting_categories = { 'assembler', 'assembler-handcraft', },
        energy_usage = "15MW",
    },
    -- foundry
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-2"],
        item = data.raw["item"]["desc_foundrymk1_c"],
        crafting_categories = { 'foundry', 'foundry-handcraft', },
        energy_usage = "16MW",
    },
    -- Manufacturer
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-3"],
        item = data.raw["item"]["desc_manufacturermk1_c"],
        crafting_categories = { 'manufacturer', 'manufacturer-handcraft', },
        energy_usage = "55MW",
    },
    -- Refinery
    create_assembler {
        base = data.raw["assembling-machine"]["chemical-plant"],
        item = data.raw["item"]["desc_oilrefinery_c"],
        crafting_categories = { 'refinery', },
        energy_usage = "30MW",
    },
    -- Blender
    create_assembler {
        base = data.raw["assembling-machine"]["oil-refinery"],
        item = data.raw["item"]["desc_blender_c"],
        crafting_categories = { 'blender', },
        energy_usage = "75MW",
    },
    -- Packager
    create_assembler {
        base = data.raw["assembling-machine"]["chemical-plant"],
        item = data.raw["item"]["desc_packager_c"],
        crafting_categories = { 'packager', },
        energy_usage = "10MW",
    },
    -- Particle Accelerator
    require("prototypes.buildings.particle-accelerator"),
    -- Converter
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-2"],
        item = data.raw["item"]["desc_converter_c"],
        crafting_categories = { 'converter', },
        energy_usage = "200MW", -- TODO: make this varied
    },
    -- Quantum Encoder
    require("prototypes.buildings.quantum-encoder"),
    -- Biomass Generator
    create_entity {
        base = data.raw["burner-generator"]["burner-generator"],
        item = data.raw["item"]["desc_generatorbiomass_automated_c"],
    }
}

for _, machine in pairs(machines) do
    local item = data.raw["item"][machine.name]
    item.place_result = machine.name
    item.icon = machine.icon
    item.icon_size = machine.icon_size
    item.icon_mipmaps = machine.icon_mipmaps
end

data:extend(machines)

local biomass_generator = data.raw["burner-generator"]["desc_generatorbiomass_automated_c"]
biomass_generator.max_power_output = "30MW"
biomass_generator.burner.effectivity = 1
biomass_generator.burner.fuel_category = nil
biomass_generator.burner.fuel_categories = {"biomass"}

-- make smelter look like electric furnace
copy_art_from(
    data.raw["assembling-machine"]["desc_smeltermk1_c"],
    data.raw["furnace"]["electric-furnace"]
)
