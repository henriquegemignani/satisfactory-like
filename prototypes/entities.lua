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


---Makes an item with the same name as given entity place it
---@param entity data.EntityPrototype
---@return data.ItemPrototype
local function associate_entity_with_item(entity)
    entity.minable.result = entity.name
    local item = data.raw["item"][entity.name]
    item.place_result = entity.name
    item.icon = entity.icon
    item.icon_size = entity.icon_size
    item.icon_mipmaps = entity.icon_mipmaps
    return item
end

require("prototypes.pipes")

-- Power

---@type data.EntityWithOwnerPrototype[]
PowerMachines = {
    require("prototypes.buildings.biomass-generator"),
    require("prototypes.buildings.coal-powered-generator"),
    require("prototypes.buildings.fuel-powered-generator"),
    require("prototypes.buildings.nuclear-power-plant"),
}

data.raw["item"]["desc_generatorbiomass_automated_c"].subgroup = "energy"
data.raw["item"]["desc_generatorbiomass_automated_c"].order = "d[biomass]"
data.raw["item"]["desc_generatorcoal_c"].subgroup = "energy"
data.raw["item"]["desc_generatorcoal_c"].order = "d[coal]"
data.raw["item"]["desc_generatorfuel_c"].subgroup = "energy"
data.raw["item"]["desc_generatorfuel_c"].order = "e[fuel]"
data.raw["item"]["desc_generatornuclear_c"].subgroup = "energy"
data.raw["item"]["desc_generatornuclear_c"].order = "f[nuclear]"

for _, generator in pairs(PowerMachines) do
    associate_entity_with_item(generator)
end

local accumulator = data.raw["accumulator"]["accumulator"]
accumulator.energy_source.input_flow_limit = "100MW"
accumulator.energy_source.output_flow_limit = "1TW" -- "unlimited"
accumulator.energy_source.buffer_capacity = "360GJ" -- 100 MW for 1 hour

-- Miners
require("prototypes.buildings.miner")
associate_entity_with_item(data.raw["mining-drill"]["desc_minermk2_c"])
associate_entity_with_item(data.raw["mining-drill"]["desc_minermk3_c"])
data.raw["item"]["desc_minermk2_c"].subgroup = data.raw["item"]["electric-mining-drill"].subgroup
data.raw["item"]["desc_minermk2_c"].order = data.raw["item"]["electric-mining-drill"].order .. "-mk2"
data.raw["item"]["desc_minermk3_c"].subgroup = data.raw["item"]["electric-mining-drill"].subgroup
data.raw["item"]["desc_minermk3_c"].order = data.raw["item"]["electric-mining-drill"].order .. "-mk3"

MinerMachines = {
    data.raw["mining-drill"]["electric-mining-drill"],
    data.raw["mining-drill"]["desc_minermk2_c"],
    data.raw["mining-drill"]["desc_minermk3_c"],
    data.raw["mining-drill"]["pumpjack"],
}

-- Util
require("prototypes.buildings.awesome-sink")
associate_entity_with_item(data.raw["furnace"]["desc_resourcesink_c"])

-- Production

---@type data.CraftingMachinePrototype[]
ProductionMachines = {
    -- smelter
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-1"],
        item = data.raw["item"]["desc_smeltermk1_c"],
        crafting_categories = { 'smelter', 'smelter-handcraft', 'smelting' },
        energy_usage = "4MW",
    },
    -- constructor
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-1"],
        item = data.raw["item"]["desc_constructormk1_c"],
        crafting_categories = { 'constructor', 'constructor-handcraft', 'crafting' },
        energy_usage = "4MW",
    },
    -- asembler
    create_assembler {
        base = data.raw["assembling-machine"]["assembling-machine-2"],
        item = data.raw["item"]["desc_assemblermk1_c"],
        crafting_categories = { 'assembler', 'assembler-handcraft', 'crafting' },
        energy_usage = "15MW",
    },
    -- foundry
    require("prototypes.buildings.foundry"),
    -- Manufacturer
    require("prototypes.buildings.manufacturer"),
    -- Refinery
    create_assembler {
        base = data.raw["assembling-machine"]["chemical-plant"],
        item = data.raw["item"]["desc_oilrefinery_c"],
        crafting_categories = { 'refinery', 'crafting-with-fluid' },
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
    require("prototypes.buildings.packager"),
    -- Particle Accelerator
    require("prototypes.buildings.particle-accelerator"),
    -- Converter
    require("prototypes.buildings.converter"),
    -- Quantum Encoder
    require("prototypes.buildings.quantum-encoder"),
}
data:extend(ProductionMachines)

-- make smelter look like electric furnace
copy_art_from(
    data.raw["assembling-machine"]["desc_smeltermk1_c"],
    data.raw["furnace"]["electric-furnace"]
)

for i, machine in pairs(ProductionMachines) do
    local item = associate_entity_with_item(machine)
    item.subgroup = "production-machine"
    item.order = string.format("f[%s]", string.char(string.byte("a") + i))
end

associate_entity_with_item(data.raw["pipe"]["desc_pipelinemk2_c"])
associate_entity_with_item(data.raw["pump"]["desc_pipelinepumpmk2_c"])

data.raw["item"]["desc_pipelinemk2_c"].subgroup = data.raw["item"]["pipe"].subgroup
data.raw["item"]["desc_pipelinemk2_c"].order = data.raw["item"]["pipe"].order .. "-mk2"
data.raw["item"]["desc_pipelinepumpmk2_c"].subgroup = data.raw["item"]["pump"].subgroup
data.raw["item"]["desc_pipelinepumpmk2_c"].order = data.raw["item"]["pump"].order .. "-mk2"

PumpEntities = {
    data.raw["pump"]["pump"],
    data.raw["pump"]["desc_pipelinepumpmk2_c"],
}
