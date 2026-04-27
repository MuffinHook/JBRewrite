local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "ProximityCamShake",
	ENABLED_ATTR_NAME = "ShakeEnabled",
	RADIUS_ATTR_NAME = "ShakeRadius",
	MAGNITUDE_ATTR_NAME = "ShakeMagnitude"
})
