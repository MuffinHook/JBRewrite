local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.6, 1.5, -1.8),
				ItemRotation = Vector3.new(-0.15, 0.9, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.4, 1.7, -1.7),
				ItemRotation = Vector3.new(0.15, 1, 0),
				NeckRotation = Vector3.new(0, 0, -0.4)
			},
			FOV = 10
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		shoot = 16652898664,
		scope = 4761314135,
		cock = 4761314769,
		mag_in = 4761315290,
		mag_out = 4761315536
	},
	MagSize = 1,
	CamShakeMagnitude = 80,
	BulletSpeed = 5000,
	FireAuto = false,
	FireFreq = 1,
	ReloadTime = 1.3,
	MobileMouseHeightScalar = 0.5,
	MaxDamageDist = 3072,
	EquipTime = 0.5,
	DamageFun = function(p1) --[[ Name: DamageFun | Line: 48 ]]
		local v1 = math.clamp(p1 / 500, 0, 1)
		return (1 - v1) * 22 + v1 * 80
	end,
	Price = 50000,
	ImageId = Settings.Images.Sniper
}