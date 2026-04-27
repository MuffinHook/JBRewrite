local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	MAX_HEALTH = 3,
	DISABLED_DURATION = 15,
	SPOT_DURATION = 120
})