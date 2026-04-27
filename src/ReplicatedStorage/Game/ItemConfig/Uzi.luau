local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.6, 1, -1.6),
				ItemRotation = Vector3.new(-0.15, 0.6, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.4, 1.3, -1.9),
				ItemRotation = Vector3.new(0.15, 0.7, 0),
				NeckRotation = Vector3.new(0, 0, -0.4)
			}
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		dry_fire01 = 2911957199,
		shot_01 = 16652902493,
		gun_semi_auto_rifle_magazine_load_01 = 2121005623,
		gun_semi_auto_rifle_magazine_unload_01 = 2121005857
	},
	MagSize = 15,
	CamShakeMagnitude = 15,
	BulletSpeed = 1000,
	FireAuto = true,
	FireFreq = 13,
	ReloadTime = 1.2,
	Damage = 7,
	Price = 25000,
	ImageId = Settings.Images.Uzi
}
