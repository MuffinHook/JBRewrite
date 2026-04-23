local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AirDropConsts = require(ReplicatedStorage.AirDrop.AirDropConsts)
local Players = game:GetService("Players")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
return {
	getPlayerIsInAmbulanceStretcher = function(p1) --[[ Name: getPlayerIsInAmbulanceStretcher | Line: 8 | Upvalues: AirDropConsts (copy) ]]
		assert(p1, "No player passed")
		local v1 = p1:FindFirstChild(AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME)
		if v1 then
			return v1.Value
		else
			return false
		end
	end,
	setPlayerIsInAmbulanceStretcher = function(p1, p2) --[[ Name: setPlayerIsInAmbulanceStretcher | Line: 16 | Upvalues: AirDropConsts (copy) ]]
		assert(p1, "No player passed")
		assert(typeof(p2) == "boolean", "Incorrect value type passed")
		local v2 = p1:FindFirstChild(AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME)
		if not v2 then
			local v3 = Instance.new("BoolValue")
			v3.Name = AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME
			v3.Parent = p1
			v2 = v3
		end
		v2.Value = p2
		return true
	end,
	getGuardHealthDebuffMultiplier = function() --[[ Name: getGuardHealthDebuffMultiplier | Line: 29 | Upvalues: RunUtils (copy), Players (copy) ]]
		if RunUtils.isVIPServer() then
			return 1
		else
			return (30 - math.min(#Players:GetPlayers(), 30)) / 60 + 0.5
		end
	end
}