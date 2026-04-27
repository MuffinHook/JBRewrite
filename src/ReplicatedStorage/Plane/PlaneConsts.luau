local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "AirDrop",
	BORN_AT_ATTR_NAME = "AirDropBornAt",
	ORIGIN_ATTR_NAME = "AirDropOrigin",
	TARGET_ATTR_NAME = "AirDropTarget",
	SPEED_ATTR_NAME = "AirDropSpeed",
	DRIFT_WIDTH = 30
})
