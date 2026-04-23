local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.4, 1.3, -2),
				ItemRotation = Vector3.new(0, 0.35, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.3, 1.5, -1.75),
				ItemRotation = Vector3.new(0.2, 0.5, 0),
				NeckRotation = Vector3.new(0.1, 0, -0.1)
			}
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		bullet_impact_bass = 2837091387
	},
	MagSize = 20,
	CamShakeMagnitude = 15,
	FireAuto = true,
	FireFreq = 13,
	ReloadTime = 1,
	Range = 200,
	Damage = 6,
	Price = 50000,
	ImageId = Settings.Images.PlasmaPistol,
	CustomDamageRemote = true
}