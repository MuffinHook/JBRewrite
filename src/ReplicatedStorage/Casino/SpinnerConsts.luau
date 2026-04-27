local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Spinner",
	ENABLED_ATTR_NAME = "SpinnerEnabled",
	ACCEL_ATTR_NAME = "SpinnerAccel",
	DRAG_PCT_ATTR_NAME = "SpinnerDragPct"
})