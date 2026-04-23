local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.23, 1.4, -2),
				ItemRotation = Vector3.new(0, 0.4, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.2, 1.6, -1.7),
				ItemRotation = Vector3.new(0.2, 0.5, 0),
				NeckRotation = Vector3.new(0.1, 0, -0.3)
			}
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		shoot = 16663714645,
		reload_open = 4761340292,
		reload_close = 4761342002,
		bullet_insert = 4761342304,
		bullet_case = 4761342492,
		cylinder_spin = 4761343424
	},
	MagSize = 6,
	CamShakeMagnitude = 150,
	BulletSpeed = 800,
	FireAutoMobile = true,
	FireAuto = false,
	FireFreq = 2.5,
	GravityMultiplier = 2,
	ReloadTime = 0.7,
	Damage = 25,
	Price = 10000,
	ImageId = Settings.Images.Revolver,
	EquipTime = 0.4
}