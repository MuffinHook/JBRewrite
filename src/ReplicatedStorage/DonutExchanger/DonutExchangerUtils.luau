-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	canInteract = function(player)
		if RunUtils.isStudio() then
			return true
		else
			return PlayerUtils.getTeamId(player) == Settings.EnumTeam.Prisoner
		end
	end
}
