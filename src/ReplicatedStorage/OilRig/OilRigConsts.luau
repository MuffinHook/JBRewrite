-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local requireValidIndexAndFreeze = require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze
local t = {
	TAG_NAME = "OilRig",
	MIN_TIME_BETWEEN_ROBBERIES = 420,
	TIMEOUT_PERIOD = 300,
	LAST_CLOSED_TIME_ATTR_NAME = "LastClosedTime",
	LAST_STARTED_TIME_ATTR_NAME = "LastStartedTime",
	PROGRESSION_STATE = Enumer({ "None", "SpawnFloor1Guards", "Floor1GuardsDefeated", "Floor1StaircaseUnlocked", "Floor2GuardsActive", "BlowUp" }),
	FLOOR_1_TIMEOUT = 90,
	PROGRESSION_STATE_ATTR_NAME = "OilRigProgressionState",
	LAST_PROGRESSION_BORN_AT_ATTR_NAME = "OilRigLastProgressionBornAt",
	DISABLE_AUTO_OPEN_ATTR_NAME = "OilRigDisableAutoOpen",
	PLAYERS_IN_ROBBERY_FOLDER_NAME = "PlayersInRobberyFolder",
	BOUNDING_BOX_NAME = "OilRigBoundingBox",
	TNT_PLACEMENT_CASH_REWARD = 100
}
t.TNT_PLACEMENT_TIMING = if RunUtils.isStudio() then 0.5 else 1.5
t.NPC_WALK_SPEED_DEBUFF = 0.5
t.NPC_HEALTH_DEBUFF = 0.5
t.NPC_BULLET_SPREAD_MULTIPLIER = 1.75
t.GUARDS_FOLDER_NAME = "GuardsFolder"
t.NPC_SPAWNS_FOLDER_NAME = "NPCSpawns"
t.FLOOR_1_GUARD_SPAWN_LOCATION_NAME = "LeverRoom"
t.FLOOR_2_GUARD_IN_ROOM_SPAWN_LOCATION_NAME = "NPCSpawn_NPCWaiting"
t.FLOOR_1_NUM_GUARDS = if RunUtils.isStudio() then 1 else 4
t.FLOOR_1_GUARD_SPAWN_COOLDOWN = 5
t.FLOOR_1_GUARD_ROOM_DOOR_NAME = "Floor1GuardRoomDoor"
t.FLOOR_1_GUARD_ROOM_BLOCK_NAME = "GuardRoomBlock"
t.TNT_MODEL_TAG_NAME = "OilRigTNT"
t.COMMAND_FLOW_PUZZLE_SIZE = 6
t.COMMAND_FLOW_PUZZLE_TIMEOUT = 30
t.TWO_PLAYER_ROOM_LEVER_ALLOWED_TIME_DIFFERENCE = 2
t.LEVER_HOLD_E_DURATION = 0.5
return requireValidIndexAndFreeze(t)
