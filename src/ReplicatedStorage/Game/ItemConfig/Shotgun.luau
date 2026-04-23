local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.6, 1, -1.2),
				ItemRotation = Vector3.new(-0.15, 0.9, 0),
				NeckRotation = Vector3.new(0, 0, 0),
				PumpOffset = Vector3.new(0, 0, 0),
				PumpDamp = 0.9,
				PumpFreq = 20
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.4, 1.3, -1.6),
				ItemRotation = Vector3.new(0.15, 1, 0),
				NeckRotation = Vector3.new(0, 0, -0.55)
			}
		},
		LeftWristRotation = CFrame.Angles(0, 2.199114857512855, 0),
		RightWristRotation = CFrame.new(),
		LeftElbowAngle = 0.7853981633974483,
		RightElbowAngle = 0
	},
	Sound = {
		gun_shotgun_cock_01 = 2123411077,
		gun_shotgun_shot_01 = 2123415004,
		gun_shotgun_dry_fire_01 = 2123411460
	},
	MagSize = 5,
	CamShakeMagnitude = 80,
	BulletSpeed = 950,
	FireAuto = false,
	FireAutoMobile = true,
	FireFreq = 1.6666666666666667,
	IgnoreVerifyFireFreq = true,
	BulletsPerShot = 20,
	BulletSpread = 0.15,
	LeftArmRelative = "Pump",
	ReloadTime = 1.7200000000000002,
	LocalReloadOffset = 1.6,
	Damage = 3,
	Price = 0,
	ImageId = Settings.Images.Shotgun,
	EquipTime = 0.35
}