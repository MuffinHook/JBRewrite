local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	FORCEFIELD_DISALLOWED_PART_TAG = "ForcefieldDisallowedPart",
	STARTING_HEALTH = 100,
	HEALTH_UPDATE_REMOTE_NAME = "ForcefieldHealthUpdate",
	DAMAGE_REMOTE_NAME = "ForcefieldDamage",
	RADIUS = 8
})