local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AirDropConsts_upvr = require(ReplicatedStorage.AirDrop.AirDropConsts)
local module = {
    getPlayerIsInAmbulanceStretcher = function(arg1) -- Line 8, Named "getPlayerIsInAmbulanceStretcher"
        assert(arg1, "No player passed")
        local SOME = arg1:FindFirstChild(AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME)
        if not SOME then
            return false
        end
        return SOME.Value
    end;
    setPlayerIsInAmbulanceStretcher = function(arg1, arg2) -- Line 16, Named "setPlayerIsInAmbulanceStretcher"
        local var5 = arg1
        assert(var5, "No player passed")
        if typeof(arg2) ~= "boolean" then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "Incorrect value type passed")
        if not arg1:FindFirstChild(AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME) then
            local BoolValue = Instance.new("BoolValue")
            BoolValue.Name = AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME
            BoolValue.Parent = arg1
        end
        BoolValue.Value = arg2
        return true
    end;
}
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local Players_upvr = game:GetService("Players")
function module.getGuardHealthDebuffMultiplier() -- Line 29
    if RunUtils_upvr.isVIPServer() then
        return 1
    end
    return (30 - math.min(#Players_upvr:GetPlayers(), 30)) / 60 + 0.5
end
return module