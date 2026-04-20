local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CartBinder_upvr = require(script.Parent.CartBinder)
local module = {}
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CartConsts_upvr = require(script.Parent.CartConsts)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module.init() -- Line 11
    CartBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 12
        local _obj_upvr = arg1._obj
        RxInstanceUtils_upvr.yieldForProperty(_obj_upvr, "PrimaryPart")
        local PrimaryPart_upvr = _obj_upvr.PrimaryPart
        CircleAction_upvr.Add({
            Part = PrimaryPart_upvr;
            ValidRoot = _obj_upvr;
            Name = "Sit";
            Timed = false;
            Dist = 16;
            PreUpdateFun = function(arg1_3) -- Line 23, Named "preUpdateFun"
                local var9
                if arg1:GetOccupant() ~= nil then
                    var9 = false
                else
                    var9 = true
                end
                arg1_3.Enabled = var9
            end;
            PreUpdatePeriod = 0.5;
            Callback = function(arg1_2, arg2) -- Line 16, Named "action"
                if arg2 then
                    _obj_upvr:FindFirstChild(CartConsts_upvr.ATTEMPT_SIT_REMOTE_NAME):FireServer()
                    return true
                end
            end;
        }, PrimaryPart_upvr)
        arg1._maid:GiveTask(function() -- Line 38
            CircleAction_upvr.Remove(PrimaryPart_upvr)
        end)
    end)
    CartBinder_upvr:Start()
end
function module.getCartForCharacter(arg1) -- Line 44
    assert(arg1:IsDescendantOf(workspace))
    for _, v in ipairs(CartBinder_upvr:GetAll()) do
        if v:GetOccupant() == arg1 then
            return v
        end
    end
end
return module