-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "C4",
	CREATOR_ID_VALUE_NAME = "CreatorId",
	STUCK_VALUE_NAME = "Stuck",
	DETONATED_VALUE_NAME = "Detonated",
	TEMP_WELD_NAME = "TempWeld",
	PERM_WELD_NAME = "PermWeld",
	STICK_REMOTE_NAME = "StickRemote",
	DETONATE_REMOTE_NAME = "DetonateRemote",
	EXPLODE_REMOTE_NAME = "ExplodeRemote",
	PLAY_EXPLOSION_REMOTE_NAME = "PlayExplosionRemote",
	MAX_LIFETIME = 120,
	BLAST_RADIUS = 16,
	MAX_DAMAGE = 20
})
