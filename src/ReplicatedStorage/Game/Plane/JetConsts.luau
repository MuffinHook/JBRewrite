local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	MISSILE_COUNT_MAX = 10,
	MISSILE_COST_PER = 1000,
	SEEKING_LOCK_MIN_DURATION = 1.5,
	SEEKING_LOCK_TAG_NAME = "JetSeekingLock"
})
