local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	CART_TAG_NAME = "TombCart",
	GEM_TAG_NAME = "TombGem",
	WOOD_TAG_NAME = "TombWood",
	GEM_COLLECT_REMOTE_NAME = "TombGemCollect",
	SPIKE_TAG_NAME = "TombSpike",
	MUSIC_ENABLED_VALUE_NAME = "TombMusic",
	MUSIC_TRACK_VALUE_NAME = "TombTrackAorB",
	STATUS_CHANGED_AT_ATTR_NAME = "TombRobberyStatusChangedAt",
	BRANCH_SWITCH_TAG_NAME = "TombBranchSwitch",
	BRANCH_SWITCH_REMOTE_NAME = "TombBranchSwitch",
	COOLDOWN_PERIOD = 420,
	TIMEOUT_PERIOD = 450
})