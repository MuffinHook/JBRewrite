local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DonutExchangerConsts_upvr = require(script.Parent.DonutExchangerConsts)
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1) -- Line 12
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.maid:GiveTask(CircleAction_upvr.Add({
        Name = "Talk";
        Timed = false;
        Dist = 10;
        Callback = function(arg1_2, arg2) -- Line 16, Named "action"
            if arg2 then
                any_new_result1_upvr.obj:FindFirstChild(DonutExchangerConsts_upvr.EXCHANGE_DONUT_REMOTE_NAME):FireServer()
            end
            return true
        end;
        Part = any_new_result1_upvr.obj.PrimaryPart;
        ValidRoot = any_new_result1_upvr.obj;
    }, any_new_result1_upvr.obj))
    return any_new_result1_upvr
end
return require(ReplicatedStorage.Std.Binder).new(DonutExchangerConsts_upvr.TAG_NAME, module_upvr)