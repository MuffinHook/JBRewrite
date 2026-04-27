local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "ProximitySound",
	ENABLED_ATTR_NAME = "ProximitySoundEnabled",
	RADIUS_ATTR_NAME = "ProximitySoundRadius",
	ID_ATTR_NAME = "ProximitySoundId",
	MAX_VOLUME_ATTR_NAME = "ProximitySoundMaxVolume"
})
