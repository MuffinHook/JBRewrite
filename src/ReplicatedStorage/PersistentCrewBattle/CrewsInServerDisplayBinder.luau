local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CrewsSurfaceGuiDisplay = require(script.Parent.CrewsSurfaceGuiDisplay)
local PersistentCrewBattleConsts = require(script.Parent.PersistentCrewBattleConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 11 | Upvalues: CrewsSurfaceGuiDisplay (copy), PersistentCrewBattleConsts (copy), t (copy) ]]
	local v1 = CrewsSurfaceGuiDisplay.new(p1, PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer)
	setmetatable(v1, t)
	return v1
end
return Binder.new(PersistentCrewBattleConsts.CREWS_IN_SERVER_DISPLAY_TAG_NAME, t)