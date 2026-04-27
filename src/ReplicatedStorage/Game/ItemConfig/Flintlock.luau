local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1, 1.4, -2),
				ItemRotation = Vector3.new(0, -0.1, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(1, 1.4, -2.7),
				ItemRotation = Vector3.new(0.2, -0.4, 0),
				NeckRotation = Vector3.new()
			}
		},
		RightElbowAngle = 0,
		RightWristRotation = CFrame.new()
	},
	Sound = {
		flintlock_shoot = 16652899011,
		flintlock_reload_open = 4801841525,
		flintlock_reload_close = 4801841881,
		flintlock_hammer = 4801842101
	},
	MagSize = 1,
	CamShakeMagnitude = 150,
	BulletSpeed = 900,
	FireAutoMobile = true,
	FireAuto = false,
	FireFreq = 4,
	ReloadTime = 4,
	DamageFun = function(distance)
		if distance <= 20 then
			return 40
		elseif distance >= 100 then
			return 20
		else
			return 40 + -20 * ((distance - 20) / 80)
		end
	end,
	Price = 10000,
	ImageId = Settings.Images.Flintlock,
	EquipTime = 0.5
}
