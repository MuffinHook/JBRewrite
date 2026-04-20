local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1, arg2) -- Line 11
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local tbl = {
        Attachment = arg2.promptAttachment;
    }
    tbl.ValidRoot = arg1
    tbl.Name = "Break"
    tbl.NoRay = true
    tbl.Timed = true
    tbl.Duration = 0.5
    tbl.Dist = 8
    function tbl.Callback(arg1_2, arg2_2) -- Line 15, Named "action"
        if arg2_2 then
            arg1:FindFirstChild("CutRemote"):FireServer()
            return true
        end
    end
    function tbl.PreUpdateFun(arg1_3) -- Line 22, Named "preUpdateFun"
        local var6
        if arg1:GetAttribute("IsCut") ~= false then
            var6 = false
        else
            var6 = true
        end
        arg1_3.Enabled = var6
    end
    tbl.PreUpdatePeriod = 0.5
    CircleAction_upvr.Add(tbl, arg1)
    any_new_result1.maid:GiveTask(function() -- Line 38
        CircleAction_upvr.Remove(arg1)
    end)
    return any_new_result1
end
return require(ReplicatedStorage.ManifestBinder).new("CuttableGlass", {
    holeAttachment = "Hole";
    promptAttachment = "Prompt";
}, module_upvr)