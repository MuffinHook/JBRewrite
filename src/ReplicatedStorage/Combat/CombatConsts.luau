local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	DAMAGE_MULTIPLIER_ATTR_NAME = "DamageMultiplier",
	ROOT_PART_HIT_RADIUS_ATTR_NAME = "HitRadius",
	DEFAULT_ROOT_PART_HIT_RADIUS = 3
})
