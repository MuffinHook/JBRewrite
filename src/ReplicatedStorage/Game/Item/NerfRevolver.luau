local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local NerfRevolver = {
	__ClassName = "NerfRevolver"
}
NerfRevolver.__index = NerfRevolver
setmetatable(NerfRevolver, Gun)
function NerfRevolver.new(owner, gunConfig, configData)
	local revolver = Gun.new(owner, gunConfig, configData)
	setmetatable(revolver, NerfRevolver)
	revolver.ApplySkin = false
	revolver:Setup(configData)
	return revolver
end
function NerfRevolver.SetupBulletEmitter(gun)
	Gun.SetupBulletEmitter(gun)
	gun.BulletEmitter.Color = Color3.fromRGB(50, 255, 50)
end
function NerfRevolver.ShootSound(gun, isLocalShot)
	if not isLocalShot then
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.shoot, {
			Pitch = 1
		})
		task.delay(0.1, function()
			Audio.ObjectLocal(gun.Tip, gun.Config.Sound.bullet_case, {
				Volume = 0.4,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
	end
end
function NerfRevolver.ReloadDropAmmoVisual(gun)  end
function NerfRevolver.ReloadRefillAmmoVisual(gun)  end
function NerfRevolver.ReloadDropAmmoSound(gun)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.reload_open, {
		RollOffMaxDistance = 129
	})
end
function NerfRevolver.ReloadRefillAmmoSound(gun)
	for i = 1, 4 do
		Audio.ObjectLocal(gun.Tip, gun.Config.Sound.bullet_insert, {
			RollOffMaxDistance = 129
		})
		task.wait(0.2)
	end
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.reload_close, {
		RollOffMaxDistance = 129
	})
	task.wait(0.2)
	Audio.ObjectLocal(gun.Tip, gun.Config.Sound.cylinder_spin, {
		RollOffMaxDistance = 129
	})
end
return NerfRevolver
