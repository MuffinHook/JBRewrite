local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Signal = require(ReplicatedStorage.Std.Signal)
local WindowGroup = require(ReplicatedStorage.Module.Window.WindowGroup)
local GameModule = {
	OnTeamChanged = Signal.new(),
	Team = Settings.EnumTeam.Prisoner,
	Schedule = nil,
	bounty = 0,
	onBountyChanged = Signal.new(),
	removeDeathGui = nil,
	removeDeathLighting = nil
}
local centerWindowGroup = WindowGroup.new()
function GameModule.getCenterWindowGroup()
	return centerWindowGroup
end
return GameModule
