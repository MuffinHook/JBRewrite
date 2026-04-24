-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TIRE_HEALTH_ATTR_NAME = "VehicleTireHealth",
	TIRE_MAX_HEALTH_ATTR_NAME = "MaxVehicleTireHealth",
	ITEM_DAMAGE_ON_VEHICLE_OVERRIDES = {
		Flintlock = 20,
		Sniper = 40,
		Shotgun = 15,
		Turret = 15,
		Rifle = 9,
		CarTurret = 10
	}
})
