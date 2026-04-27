local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.8, 1.4, -0.8),
				ItemRotation = Vector3.new(0, math.pi / 4, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.8, 1.4, -0.8),
				ItemRotation = Vector3.new(0, math.pi / 4, 0),
				NeckRotation = Vector3.new(0, 0, 0)
			}
		},
		LeftElbowAngle = 0,
		RightElbowAngle = 0,
		LeftWristRotation = CFrame.new(),
		RightWristRotation = CFrame.new()
	},
	Sound = {
		weapon_cannon_shot_04 = 2205008075,
		gun_pistol_dry_fire_01 = 2140551506
	},
	MagSize = 10,
	AmmoCurrent = 0,
	FireAuto = false
}
t.FireFreq = if RunUtils.isStudio() then 3 else 0.4
t.ReloadTime = 1.5
t.RocketSpeed = 200
t.Damage = 70
t.Radius = 20
t.Price = 40000
t.ImageId = Settings.Images.RocketLauncher
t.CustomShootRemote = true
t.CustomDamageRemote = true
t.EquipTime = 1
t.EquipTimeForced = true
return t
