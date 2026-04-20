local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local VendingMachineConsts_upvr = require(script.VendingMachineConsts)
local HomeItemSystem_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1, arg2) -- Line 12
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._obj = arg1._obj
    module_upvr_2._maid = Maid_upvr.new()
    local function action_upvr(arg1_2, arg2_2) -- Line 19, Named "action"
        if arg2_2 then
            module_upvr_2._obj:FindFirstChild(VendingMachineConsts_upvr.GRAB_REMOTE_NAME):FireServer()
            return true
        end
    end
    local function preUpdateFun_upvr(arg1_3) -- Line 26, Named "preUpdateFun"
        arg1_3.Enabled = not HomeItemSystem_upvr.isCustomizing()
    end
    module_upvr_2._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(module_upvr_2._obj, "Prompt", function(arg1_4, arg2_3) -- Line 29
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