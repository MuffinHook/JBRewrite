local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1.3, 1.5, -1.5),
				ItemRotation = Vector3.new(0, 0, 0),
				NeckRotation = Vector3.new()
			}
		},
		Raise = {
			Springs = {
				ItemOffset = Vector3.new(1.3, 1.2, -1.5),
				ItemRotation = Vector3.new(-0.4, 0, 0),
				NeckRotation = Vector3.new(0.4, 0, 0)
			}
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.new(),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		explosion_large_02 = 2205008239,
		gun_pistol_dry_fire_01 = 2140551506
	},
	MagSize = 3,
	AmmoCurrent = 0,
	FireAuto = false,
	FireFreq = 10,
	ReloadTime = 2,
	Consumable = true,
	Price = 0,
	DoNotFillOnPurchase = true,
	ImageId = Settings.Images.SmokeGrenade,
	SortOrderPage = -1,
	CustomShootRemote = true,
	CustomReloadRemote = true,
	CustomDamageRemote = true
}