local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GarageConsts_upvr = require(ReplicatedStorage_upvr.Garage.GarageConsts)
local module = {}
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local GarageUtils_upvr = require(ReplicatedStorage_upvr.Garage.GarageUtils)
function module.setSaveSlot(arg1, arg2) -- Line 10
    assert(arg2.name, "missing slot name")
    assert(arg2.equipped, "missing slot equipped")
    local module_3 = {}
    for i, v in pairs(arg1) do
        module_3[i] = v
    end
    local name = arg2.name
    if GarageUtils_upvr.getIsSaveSlotValid(tonumber(name:match("%d+")), GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.VIP)) then
        module_3[name] = arg2.equipped
    end
    local SOME_2 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr.SLOT_SAVE_REMOTE_NAME)
    if SOME_2 then
        SOME_2:FireServer(name)
    end
    return module_3
end
function module.deleteSaveSlot(arg1, arg2) -- Line 30
    assert(arg2.name, "missing slot name")
    local module_2 = {}
    for i_2, v_2 in pairs(arg1) do
        module_2[i_2] = v_2
    end
    module_2[arg2.name] = nil
    local SOME_3 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr.SLOT_DELETE_REMOTE_NAME)
    if SOME_3 then
        i_2 = arg2.name
        SOME_3:FireServer(i_2)
    end
    return module_2
end
function module.loadSaveSlot(arg1, arg2) -- Line 43
    assert(arg2.name, "missing slot name")
    local SOME = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr.SLOT_LOAD_REMOTE_NAME)
    if SOME then
        SOME:FireServer(arg2.name)
    end
    return arg1
end
function module.setSavesRaw(arg1, arg2) -- Line 51
    local var27
    if arg2.saves == nil then
        var27 = false
    else
        var27 = true
    end
    assert(var27, "missing saves table")
    return arg2.saves
end
return require(ReplicatedStorage_upvr.Rodux).createReducer({}, module)