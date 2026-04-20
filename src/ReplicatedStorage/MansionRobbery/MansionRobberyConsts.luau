-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local tbl = {
    TAG_NAME = "MansionRobbery";
    ROBBERY_REWARD = 13000;
    ROBBERY_STATUS_ATTR_NAME = "RobberyStatus";
    MAX_PLAYERS_IN_ELEVATOR = 3;
    NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME = "NumPlayersInElevator";
}
local var4 = "ElevatorCountdown"
tbl.ELEVATOR_COUNTDOWN_INSTANCE_NAME = var4
if RunUtils.isStudio() then
    var4 = 7
else
    var4 = 15
end
tbl.ELEVATOR_COUNTDOWN_TIME = var4
tbl.IS_ELEVATOR_MOVING_ATTR_NAME = "IsElevatorMoving"
tbl.BOSS_MODELS_FOLDER_NAME = "BossModels"
tbl.SHIELD_MODELS_FOLDER_NAME = "Shields"
if RunUtils.isStudio() then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
tbl.MAX_SHIELDS_UP = 3
tbl.MIN_SHIELD_UP_TIME = 0.5
tbl.MAX_SHIELD_UP_TIME = 6
tbl.SHIELD_COOLDOWN_TIME = 3
tbl.SHIELD_LAST_DOWN_TIME_ATTR_NAME = "ShieldLastDown"
tbl.IN_ROBBERY_FOLDER_NAME = "InRobberyFolder"
tbl.GUARDS_FOLDER_NAME = "GuardsFolder"
tbl.PROGRESSION_STATE_ATTR_NAME = "MansionRobberyProgressionState"
tbl.PROGRESSION_STATE = require(ReplicatedStorage.Std.Enumer)({"None", "WaitForEnter", "PlayersEnteredIntroCutscene", "WaitForDamage", "FirstGuards", "BossMovement", "RunAwayEndCutscene"})
tbl.LAST_PROGRESSION_BORN_AT_ATTR_NAME = "MansionRobberyLastProgressionBornAt"
if RunUtils.isStudio() then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.