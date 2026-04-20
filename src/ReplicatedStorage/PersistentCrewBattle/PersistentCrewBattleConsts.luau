-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
if RunUtils.getEnv() == RunConsts.QA_NAME then
elseif RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME then
end
local tbl = {
    CURR_CREW_BATTLE_SEASON = 20;
    CREW_BATTLE_SEASON_EXPORT_KEY = "CrewBattleSeasonNum";
    ROUND_ROBBERIES_DONE_ATTR_NAME = "RoundRobberiesDone";
}
if RunUtils.getEnv() == RunConsts.PROD_NAME then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
tbl.ROUND_START_COUNTDOWN_TIME = 1
tbl.BATTLE_END_COUNTDOWN_LENGTH = 10
tbl.ROUND_STARTS_AT_ATTR_NAME = "RoundStartsAt"
tbl.ROUND_MAX_TIME = 600
tbl.MAX_PLAYERS_PER_TEAM = 5
if RunUtils.getEnv() == RunConsts.PROD_NAME then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.