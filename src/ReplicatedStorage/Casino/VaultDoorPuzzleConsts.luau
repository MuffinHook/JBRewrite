local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	NUM_BLINKS_ATTR_NAME = "NumBlinks",
	MIN_TIME_BETWEEN_BLINKS_ATTR_NAME = "MinTimeBetweenBlinks",
	MAX_TIME_BETWEEN_BLINKS_ATTR_NAME = "MaxTimeBetweenBlinks"
})