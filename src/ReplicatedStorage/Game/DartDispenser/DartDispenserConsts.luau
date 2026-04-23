local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "DartDispenser",
	FIRE_REMOTE_NAME = "DartFire",
	DAMAGE_REMOTE_NAME = "DartDamage",
	DAMAGE = 55
})