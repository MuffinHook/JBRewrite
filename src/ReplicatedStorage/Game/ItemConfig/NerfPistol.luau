-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.2, 1.3, -1.4),
				ItemRotation = Vector3.new(0, 0.35, 0),
				NeckRotation = Vector3.new()
			}
		},
		Scope = {
			Springs = {
				ItemOffset = Vector3.new(0.1, 1.5, -1.5),
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
		gun_pistol_shot_04 = 6924804083,
		gun_pistol_slide_fast_01 = 2140552275,
		gun_pistol_insert_mag_01 = 6924804347,
		gun_pistol_remove_mag_01 = 2140552990
	},
	MagSize = 8,
	CamShakeMagnitude = 10,
	BulletSpeed = 1000,
	FireAutoMobile = true,
	FireAuto = false,
	FireFreq = 5,
	ReloadTime = 1,
	Damage = 15,
	Price = 1000,
	SortOrderPage = -1,
	ImageId = Settings.Images.NerfPistol,
	ShopHidden = true
}
