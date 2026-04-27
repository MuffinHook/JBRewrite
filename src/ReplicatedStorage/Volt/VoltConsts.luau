local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "VoltBike",
	ENGINE_SOUND_NAME = "EngineSound"
})
