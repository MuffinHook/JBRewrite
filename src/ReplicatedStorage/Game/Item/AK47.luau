local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local AK47Class = {
	__ClassName = "AK47"
}
AK47Class.__index = AK47Class
setmetatable(AK47Class, Gun)
function AK47Class.new(p1, p2, p3)
	local gunInstance = Gun.new(p1, p2, p3)
	setmetatable(gunInstance, AK47Class)
	gunInstance:Setup(p3)
	return gunInstance
end
function AK47Class.ShootSound(gun, isDryFire)
	if isDryFire then
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_dry_fire_01, {
			Volume = 0.4,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	else
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function AK47Class.ReloadDropAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
		RollOffMaxDistance = 129
	})
end
function AK47Class.ReloadRefillAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
		RollOffMaxDistance = 129
	})
end
return AK47Class
