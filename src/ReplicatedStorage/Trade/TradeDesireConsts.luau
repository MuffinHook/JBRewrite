local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	MAX_TEXT_LENGTH = 64,
	RAINBOW_ANIMATION_CYCLE_TIME = 5
})
