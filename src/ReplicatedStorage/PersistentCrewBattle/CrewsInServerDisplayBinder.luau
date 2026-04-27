local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CrewsSurfaceGuiDisplay = require(script.Parent.CrewsSurfaceGuiDisplay)
local PersistentCrewBattleConsts = require(script.Parent.PersistentCrewBattleConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(crewObject)
	local displayInstance = CrewsSurfaceGuiDisplay.new(crewObject, PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer)
	setmetatable(displayInstance, t)
	return displayInstance
end
return Binder.new(PersistentCrewBattleConsts.CREWS_IN_SERVER_DISPLAY_TAG_NAME, t)
