local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local Uzi = {
	__ClassName = "Uzi"
}
Uzi.__index = Uzi
setmetatable(Uzi, Gun)
function Uzi.new(player, p2, p3)
	local gunInstance = Gun.new(player, p2, p3)
	setmetatable(gunInstance, Uzi)
	gunInstance:Setup(p3)
	return gunInstance
end
function Uzi.ShootSound(gun, isDryFire)
	if isDryFire then
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.dry_fire01, {
			Volume = 0.4,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	else
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function Uzi.ReloadDropAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
		RollOffMaxDistance = 129
	})
end
function Uzi.ReloadRefillAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
		RollOffMaxDistance = 129
	})
end
return Uzi
