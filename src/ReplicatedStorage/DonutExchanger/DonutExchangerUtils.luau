local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	canInteract = function(p1) --[[ Name: canInteract | Line: 7 | Upvalues: RunUtils (copy), PlayerUtils (copy), Settings (copy) ]]
		if RunUtils.isStudio() then
			return true
		else
			return PlayerUtils.getTeamId(p1) == Settings.EnumTeam.Prisoner
		end
	end
}