-- Reviewed by Claude
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
	MagSize = 4,
	CamShakeMagnitude = 80,
	FireAuto = false,
	FireFreq = 1.6666666666666667,
	BulletsPerShot = 15,
	BulletSpread = 0.2,
	ReloadTime = 1.5,
	Range = 50,
	Damage = 4,
	Price = 50000,
	ImageId = Settings.Images.PlasmaShotgun,
	CustomDamageRemote = true,
	EquipTime = 0.35
}
