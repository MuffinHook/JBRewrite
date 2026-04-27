local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	INTERACT_REMOTE_NAME = "InteractRemote",
	ITEM_NAME_ATTR_NAME = "ItemName",
	WHITELIST = {
		Sword = true,
		Binoculars = true,
		Flashlight = true,
		Glider = true,
		AK47 = true,
		ForcefieldLauncher = true,
		Sniper = true,
		Flintlock = true,
		Rifle = true,
		RocketLauncher = true,
		Shotgun = true,
		Uzi = true,
		PlasmaPistol = true,
		PlasmaShotgun = true,
		Revolver = true,
		Pistol = true,
		SmokeGrenade = true,
		C4 = true,
		Grenade = true
	}
})
