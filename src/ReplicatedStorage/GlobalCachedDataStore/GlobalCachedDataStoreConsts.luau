local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	KEY_CHANGE_MESSAGING_SUBSCRIPTION_TOPIC = "GlobalDataStore",
	CACHE_INVALIDATION_TIME = 600,
	TIME_BETWEEN_FIRING_BATCH_OF_CHANGES = 5,
	DO_DEBUG_PRINTS = false
})
