-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AirDropConsts = require(ReplicatedStorage.AirDrop.AirDropConsts)
local Players = game:GetService("Players")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
return {
	getPlayerIsInAmbulanceStretcher = function(player)
		assert(player, "No player passed")
		local stretcherValue = player:FindFirstChild(AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME)
		if stretcherValue then
			return stretcherValue.Value
		else
			return false
		end
	end,
	setPlayerIsInAmbulanceStretcher = function(player, isInStretcher)
		assert(player, "No player passed")
		assert(typeof(isInStretcher) == "boolean", "Incorrect value type passed")
		local stretcherValue = player:FindFirstChild(AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME)
		if not stretcherValue then
			local newStretcherValue = Instance.new("BoolValue")
			newStretcherValue.Name = AirDropConsts.IN_AMBULANCE_STRETCHER_OBJ_NAME
			newStretcherValue.Parent = player
			stretcherValue = newStretcherValue
		end
		stretcherValue.Value = isInStretcher
		return true
	end,
	getGuardHealthDebuffMultiplier = function()
		if RunUtils.isVIPServer() then
			return 1
		else
			return (30 - math.min(#Players:GetPlayers(), 30)) / 60 + 0.5
		end
	end
}
