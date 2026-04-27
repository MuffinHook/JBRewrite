local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local RifleClass = {
	__ClassName = "Rifle"
}
RifleClass.__index = RifleClass
setmetatable(RifleClass, Gun)
function RifleClass.new(player, model, config)
	local newRifleInstance = Gun.new(player, model, config)
	setmetatable(newRifleInstance, RifleClass)
	newRifleInstance:Setup(config)
	return newRifleInstance
end
function RifleClass.ShootSound(rifle, isDryFire)
	if isDryFire then
		Audio.ObjectLocal(rifle.Tip, rifle.Config.Sound.gun_semi_auto_rifle_dry_fire_01, {
			Volume = 0.4,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	else
		Audio.ObjectLocal(rifle.Tip, rifle.Config.Sound.gun_semi_auto_rifle_shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function RifleClass.ReloadDropAmmoSound(rifle)
	Audio.ObjectLocal(rifle.Tip, rifle.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
		RollOffMaxDistance = 129
	})
end
function RifleClass.ReloadRefillAmmoSound(rifle)
	Audio.ObjectLocal(rifle.Tip, rifle.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
		RollOffMaxDistance = 129
	})
end
return RifleClass
