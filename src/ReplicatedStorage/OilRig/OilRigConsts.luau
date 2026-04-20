local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local module = {
    TAG_NAME = "OilRig";
    MIN_TIME_BETWEEN_ROBBERIES = 420;
    TIMEOUT_PERIOD = 300;
    LAST_CLOSED_TIME_ATTR_NAME = "LastClosedTime";
    LAST_STARTED_TIME_ATTR_NAME = "LastStartedTime";
    PROGRESSION_STATE = require(ReplicatedStorage.Std.Enumer)({"None", "SpawnFloor1Guards", "Floor1GuardsDefeated", "Floor1StaircaseUnlocked", "Floor2GuardsActive", "BlowUp"});
    FLOOR_1_TIMEOUT = 90;
    PROGRESSION_STATE_ATTR_NAME = "OilRigProgressionState";
    LAST_PROGRESSION_BORN_AT_ATTR_NAME = "OilRigLastProgressionBornAt";
    DISABLE_AUTO_OPEN_ATTR_NAME = "OilRigDisableAutoOpen";
    PLAYERS_IN_ROBBERY_FOLDER_NAME = "PlayersInRobberyFolder";
    BOUNDING_BOX_NAME = "OilRigBoundingBox";
}
local var5 = 100
module.TNT_PLACEMENT_CASH_REWARD = var5
if RunUtils.isStudio() then
    var5 = 0.5
else
    var5 = 1.5
end
module.TNT_PLACEMENT_TIMING = var5
var5 = 0.5
module.NPC_WALK_SPEED_DEBUFF = var5
var5 = 0.5
module.NPC_HEALTH_DEBUFF = var5
var5 = 1.75
module.NPC_BULLET_SPREAD_MULTIPLIER = var5
var5 = "GuardsFolder"
module.GUARDS_FOLDER_NAME = var5
var5 = "NPCSpawns"
module.NPC_SPAWNS_FOLDER_NAME = var5
var5 = "LeverRoom"
module.FLOOR_1_GUARD_SPAWN_LOCATION_NAME = var5
var5 = "NPCSpawn_NPCWaiting"
module.FLOOR_2_GUARD_IN_ROOM_SPAWN_LOCATION_NAME = var5
if RunUtils.isStudio() then
    var5 = 1
else
    var5 = 4
end
module.FLOOR_1_NUM_GUARDS = var5
var5 = 5
module.FLOOR_1_GUARD_SPAWN_COOLDOWN = var5
var5 = "Floor1GuardRoomDoor"
module.FLOOR_1_GUARD_ROOM_DOOR_NAME = var5
var5 = "GuardRoomBlock"
module.FLOOR_1_GUARD_ROOM_BLOCK_NAME = var5
var5 = "OilRigTNT"
module.TNT_MODEL_TAG_NAME = var5
var5 = 6
module.COMMAND_FLOW_PUZZLE_SIZE = var5
var5 = 30
module.COMMAND_FLOW_PUZZLE_TIMEOUT = var5
var5 = 2
module.TWO_PLAYER_ROOM_LEVER_ALLOWED_TIME_DIFFERENCE = var5
var5 = 0.5
module.LEVER_HOLD_E_DURATION = var5
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)