-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CrewsSurfaceGuiDisplay = require(script.Parent.CrewsSurfaceGuiDisplay)
local PersistentCrewBattleConsts = require(script.Parent.PersistentCrewBattleConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(crewObject)
	local displayInstance = CrewsSurfaceGuiDisplay.new(crewObject, PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard)
	setmetatable(displayInstance, t)
	return displayInstance
end
return Binder.new(PersistentCrewBattleConsts.CREW_LEADERBOARD_TAG_NAME, t)
