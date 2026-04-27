local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	LAST_VEHICLE_SPAWNED_AT_VALUE_NAME = "LastVehicleSpawnedAt"
})
