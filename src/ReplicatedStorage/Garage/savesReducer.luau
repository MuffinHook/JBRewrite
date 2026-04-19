-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:26
-- Luau version 6, Types version 3
-- Time taken: 0.004259 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GarageConsts_upvr = require(ReplicatedStorage_upvr.Garage.GarageConsts)
local module = {}
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local GarageUtils_upvr = require(ReplicatedStorage_upvr.Garage.GarageUtils)
function module.setSaveSlot(arg1, arg2) -- Line 10
    --[[ Upvalues[5]:
        [1]: GamepassSystem_upvr (readonly)
        [2]: GamepassUtils_upvr (readonly)
        [3]: GarageUtils_upvr (readonly)
        [4]: ReplicatedStorage_upvr (readonly)
        [5]: GarageConsts_upvr (readonly)
    ]]
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
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: GarageConsts_upvr (readonly)
    ]]
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
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: GarageConsts_upvr (readonly)
    ]]
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