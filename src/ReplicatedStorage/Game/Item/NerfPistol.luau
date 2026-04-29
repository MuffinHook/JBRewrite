local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local NerfPistol = {
	__ClassName = "NerfPistol"
}
NerfPistol.__index = NerfPistol
setmetatable(NerfPistol, Gun)
function NerfPistol.new(gunInstance, character, config)
	local gun = Gun.new(gunInstance, character, config)
	setmetatable(gun, NerfPistol)
	gun.ApplySkin = false
	gun:Setup(config)
	return gun
end
function NerfPistol.SetupBulletEmitter(gun)
	Gun.SetupBulletEmitter(gun)
	gun.BulletEmitter.Color = Color3.fromRGB(253, 111, 24)
end
function NerfPistol.ShootSound(gun, isAlternate)
	if not isAlternate then
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_pistol_shot_04, {
			Pitch = 1
		})
		task.delay(0.1, function()
			Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_pistol_slide_fast_01, {
				Volume = 0.3,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
	end
end
function NerfPistol.ReloadDropAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_pistol_remove_mag_01)
end
function NerfPistol.ReloadRefillAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_pistol_insert_mag_01, {
		RollOffMaxDistance = 129
	})
	task.wait(0.4)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_pistol_slide_fast_01, {
		RollOffMaxDistance = 129
	})
	task.wait(0.1)
end
return NerfPistol
