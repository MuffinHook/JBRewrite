local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "SmokeGrenade",
	CREATOR_ID_VALUE_NAME = "CreatorId",
	THROWN_VALUE_NAME = "Thrown",
	THROWN_REMOTE_NAME = "ThrownRemote",
	EXPLODE_REMOTE_NAME = "ExplodeRemote",
	MAX_LIFETIME = 120,
	BLAST_RADIUS = 64,
	FX_DURATION = 15,
	FX_BLUR_SIZE = 100,
	FX_COLOR = Color3.fromRGB(250, 255, 100)
})
