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
function t.new(param1)
	local local1 = CrewsSurfaceGuiDisplay.new(param1, PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard)
	setmetatable(local1, t)
	return local1
end
return Binder.new(PersistentCrewBattleConsts.CREW_LEADERBOARD_TAG_NAME, t)
