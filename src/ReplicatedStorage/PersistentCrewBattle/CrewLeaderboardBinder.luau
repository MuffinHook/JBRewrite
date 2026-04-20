local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts_upvr = require(script.Parent.PersistentCrewBattleConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, require(ReplicatedStorage.Std.BaseObject))
local CrewsSurfaceGuiDisplay_upvr = require(script.Parent.CrewsSurfaceGuiDisplay)
function module_upvr.new(arg1) -- Line 11
    local any_new_result1 = CrewsSurfaceGuiDisplay_upvr.new(arg1, PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(PersistentCrewBattleConsts_upvr.CREW_LEADERBOARD_TAG_NAME, module_upvr)