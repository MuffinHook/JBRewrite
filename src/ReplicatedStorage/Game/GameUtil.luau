-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Signal = require(ReplicatedStorage.Std.Signal)
local WindowGroup = require(ReplicatedStorage.Module.Window.WindowGroup)
local t = {
	OnTeamChanged = Signal.new(),
	Team = Settings.EnumTeam.Prisoner,
	Schedule = nil,
	bounty = 0,
	onBountyChanged = Signal.new(),
	removeDeathGui = nil,
	removeDeathLighting = nil
}
local v1 = WindowGroup.new()
function t.getCenterWindowGroup()
	return v1
end
return t
