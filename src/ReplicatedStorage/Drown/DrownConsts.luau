-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	DROWN_PERCENT_ATTR_NAME = "DrownPercent",
	BUFFER_TIME = 8,
	DAMAGE_PER_TICK_AFTER_BUFFER = 10,
	DAMAGE_TICK_TIME = 1
})
