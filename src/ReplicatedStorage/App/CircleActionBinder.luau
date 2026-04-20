local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleActionUtils_upvr = require(script.Parent.CircleActionUtils)
local UI_upvr = require(ReplicatedStorage.Module.UI)
function module_upvr.new(arg1) -- Line 12
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local OnPressedRemote_upvr = arg1:WaitForChild("OnPressedRemote")
    any_new_result1.maid:GiveTask(UI_upvr.CircleAction.Add({
        Name = "[### MISSING ###]";
        Timed = false;
        Dist = 0;
        Callback = function(arg1_3, arg2) -- Line 31, Named "pressCallback"
            OnPressedRemote_upvr:FireServer(arg2)
            return true
        end;
        Enabled = true;
        PreUpdateFun = function(arg1_2) -- Line 18, Named "preUpdateFun"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var7
            if arg1:GetAttribute("CircleActionDisabled") ~= true then
                var7 = false
            else
                var7 = true
            end
            arg1_2.Enabled = not var7
            var7 = arg1:GetAttribute("CircleActionDuration")
            arg1_2.Duration = var7 or 0
            var7 = arg1_2.Duration
            if 0.001 >= var7 then
            else
            end
            arg1_2.Timed = true
            var7 = arg1
            var7 = arg1:IsA("Model")
            if var7 then
                var7 = arg1
                arg1_2.ValidRoot = var7
            end
            arg1_2.Part = CircleActionUtils_upvr.getTagPart(var7)
            var7 = arg1:GetAttribute("CircleActionText")
            if not var7 then
                var7 = arg1
                var7 = var7.Name
            end
            arg1_2.Name = var7
            arg1_2.Dist = arg1:GetAttribute("CircleActionDist") or 10
        end;
        PreUpdatePeriod = 0.2;
    }, arg1))
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new("CircleAction", module_upvr)