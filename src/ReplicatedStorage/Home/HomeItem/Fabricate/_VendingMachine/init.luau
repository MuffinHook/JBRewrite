-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:10
-- Luau version 6, Types version 3
-- Time taken: 0.002759 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local VendingMachineConsts_upvr = require(script.VendingMachineConsts)
local HomeItemSystem_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1, arg2) -- Line 12
    --[[ Upvalues[6]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: VendingMachineConsts_upvr (readonly)
        [4]: HomeItemSystem_upvr (readonly)
        [5]: RxInstanceUtils_upvr (readonly)
        [6]: CircleAction_upvr (readonly)
    ]]
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._obj = arg1._obj
    module_upvr_2._maid = Maid_upvr.new()
    local function action_upvr(arg1_2, arg2_2) -- Line 19, Named "action"
        --[[ Upvalues[2]:
            [1]: module_upvr_2 (readonly)
            [2]: VendingMachineConsts_upvr (copied, readonly)
        ]]
        if arg2_2 then
            module_upvr_2._obj:FindFirstChild(VendingMachineConsts_upvr.GRAB_REMOTE_NAME):FireServer()
            return true
        end
    end
    local function preUpdateFun_upvr(arg1_3) -- Line 26, Named "preUpdateFun"
        --[[ Upvalues[1]:
            [1]: HomeItemSystem_upvr (copied, readonly)
        ]]
        arg1_3.Enabled = not HomeItemSystem_upvr.isCustomizing()
    end
    module_upvr_2._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(module_upvr_2._obj, "Prompt", function(arg1_4, arg2_3) -- Line 29
        --[[ Upvalues[4]:
            [1]: arg2 (readonly)
            [2]: action_upvr (readonly)
            [3]: preUpdateFun_upvr (readonly)
            [4]: CircleAction_upvr (copied, readonly)
        ]]
        local tbl = {}
        tbl.Part = arg1_4
        tbl.Name = "Grab %s":format(arg2)
        tbl.Timed = false
        tbl.Dist = 10
        tbl.Callback = action_upvr
        tbl.PreUpdateFun = preUpdateFun_upvr
        tbl.PreUpdatePeriod = 0.1
        CircleAction_upvr.Add(tbl, arg1_4)
        arg2_3:GiveTask(function() -- Line 40
            --[[ Upvalues[2]:
                [1]: CircleAction_upvr (copied, readonly)
                [2]: arg1_4 (readonly)
            ]]
            CircleAction_upvr.Remove(arg1_4)
        end)
    end))
    return module_upvr_2
end
function module_upvr.Destroy(arg1) -- Line 47
    local _maid = arg1._maid
    local var13
    if _maid == nil then
        var13 = false
    else
        var13 = true
    end
    assert(var13)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr