local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module.init() -- Line 8
    Binder_upvr.new("CommerceNode", function(arg1) -- Line 9
        local any_new_result1 = Maid_upvr.new()
        local tbl = {}
        tbl.Part = arg1
        tbl.Name = "Buy"
        tbl.NoRay = true
        tbl.Timed = false
        tbl.Dist = 12
        function tbl.Callback(arg1_2, arg2) -- Line 12, Named "action"
            if arg2 then
                local AttemptBuyRemote_2 = arg1:FindFirstChild("AttemptBuyRemote")
                if AttemptBuyRemote_2 then
                    AttemptBuyRemote_2:FireServer()
                end
            end
        end
        any_new_result1:GiveTask(CircleAction_upvr.Add(tbl, arg1))
        return any_new_result1
    end):Start()
end
return module