local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "MilitaryTurret",
	TURRET_DAMAGE = 6,
	FIRE_RATE = 0.1,
	MAG_SIZE = 50,
	RELOAD_TIME = 2.5
})