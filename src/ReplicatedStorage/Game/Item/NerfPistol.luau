-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "NerfPistol"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1.ApplySkin = false
	v1:Setup(p3)
	return v1
end
function t.SetupBulletEmitter(p1)
	Gun.SetupBulletEmitter(p1)
	p1.BulletEmitter.Color = Color3.fromRGB(253, 111, 24)
end
function t.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_shot_04, {
			Pitch = 1
		})
		delay(0.1, function()
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_slide_fast_01, {
				Volume = 0.3,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
	end
end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_remove_mag_01)
end
function t.ReloadRefillAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_insert_mag_01, {
		RollOffMaxDistance = 129
	})
	wait(0.4)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_slide_fast_01, {
		RollOffMaxDistance = 129
	})
	wait(0.1)
end
return t
