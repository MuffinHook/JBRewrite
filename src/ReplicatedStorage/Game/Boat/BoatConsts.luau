local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TIRES_POPPED_AT_ATTR_NAME = "VehicleTiresLastPop",
	TIRE_POP_DURATION = 15
})
