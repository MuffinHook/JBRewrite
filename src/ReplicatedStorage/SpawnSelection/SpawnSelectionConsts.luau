local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	SPAWN_TAG_NAME = "SpawnSelectionSpawn",
	SPAWN_USE_PARACHUTE_ATTR_NAME = "SpawnSelectionUseParachute",
	SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME = "SpawnSelectionExclusiveTeamName",
	SPAWN_RADIUS_ATTR_NAME = "SpawnSelectionSpawnRadius",
	SPAWN_EXCLUSIVE_BOSS_ATTR_NAME = "SpawnSelectionExclusiveBoss",
	SPAWN_EXCLUSIVE_SWAT_ATTR_NAME = "SpawnSelectionExclusiveSWAT",
	SPAWN_EXCLUSIVE_VIP_ATTR_NAME = "SpawnSelectionExclusiveVIP",
	SPAWN_TIME_HOLDER_OBJ_NAME = "SpawnTimes",
	MAX_WAIT_TIME = 10,
	SPAWN_COOLDOWN_TIME = 90,
	ENEMY_CHECK_RADIUS = 300
})