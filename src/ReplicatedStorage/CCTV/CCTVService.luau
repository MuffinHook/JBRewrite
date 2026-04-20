local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    onRequestPrompt = require(ReplicatedStorage.Std.Signal).new();
}
local CameraBinder_upvr = require(script.Parent.CameraBinder)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.init() -- Line 12
    CameraBinder_upvr:Start()
    Binder_upvr.new("CCTVPrompt", function(arg1) -- Line 15
        local any_new_result1 = Maid_upvr.new()
        local tbl = {}
        tbl.Part = arg1
        tbl.Name = "Open Security Cameras"
        tbl.Timed = false
        tbl.Dist = 8
        function tbl.Callback(arg1_2, arg2) -- Line 17, Named "action"
            if arg2 then
                module_upvr.onRequestPrompt:Fire()
            end
            return true
        end
        CircleAction_upvr.Add(tbl, arg1)
        any_new_result1:GiveTask(function() -- Line 31
            CircleAction_upvr.Remove(arg1)
        end)
        return any_new_result1
    end):Start()
end
return module_upvr