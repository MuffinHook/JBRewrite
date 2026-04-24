-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	WORLD_TAG_NAME = "Destructible",
	PREFAB_FOLDER_NAME = "DestructiblePrefab",
	SPAWN_FOLDER_NAME = "DestructibleSpawn",
	SPAWN_TAG_NAME = "DestructibleSpawn",
	BROADCAST_COLLIDE_REMOTE_NAME = "DestructibleCollisionBroadcast",
	INSTANCE_VALUE_NAME = "DestructibleInstance",
	DESTRUCTIBLE_COLLISION_GROUP_NAME = "DestructibleCollisionGroup",
	DURATION = 8,
	MAX_DIST_TO_LOAD = 1280,
	MAX_DIST_TO_LOAD_ATTR_NAME = "MaxDistToLoad"
})
