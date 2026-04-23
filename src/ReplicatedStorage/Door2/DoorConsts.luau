local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Door2",
	INNER_MODEL_NAME = "InnerModel",
	OPEN_ATTR_NAME = "DoorOpen",
	PCT_OPEN_ATTR_NAME = "DoorPctOpen",
	DURATION_ATTR_NAME = "DoorDuration",
	MAX_ANGLE_ATTR_NAME = "DoorMaxAngle",
	SHOULD_SWING_ATTR_NAME = "DoorShouldSwing",
	EASING_DIRECTION_ATTR_NAME = "DoorEasingDirection",
	EASING_STYLE_ATTR_NAME = "DoorEasingStyle",
	FREEZE_SERVER_STATE_ATTR_NAME = "DoorFreezeServerState",
	SNAP_SERVER_STATE_ATTR_NAME = "DoorSnapServerState",
	SHOULD_WELD_ATTR_NAME = "DoorShouldWeld",
	MOTOR_OBJ_NAME = "DoorMotor",
	DOOR_PLAYER_REGION_VALUE_NAME = "DoorPlayerRegion"
})