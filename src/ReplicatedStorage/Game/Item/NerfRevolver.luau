-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "NerfRevolver"
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
	p1.BulletEmitter.Color = Color3.fromRGB(50, 255, 50)
end
function t.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.shoot, {
			Pitch = 1
		})
		delay(0.1, function()
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.bullet_case, {
				Volume = 0.4,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
	end
end
function t.ReloadDropAmmoVisual(p1)  end
function t.ReloadRefillAmmoVisual(p1)  end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.reload_open, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1)
	for i = 1, 4 do
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.bullet_insert, {
			RollOffMaxDistance = 129
		})
		wait(0.2)
	end
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.reload_close, {
		RollOffMaxDistance = 129
	})
	wait(0.2)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.cylinder_spin, {
		RollOffMaxDistance = 129
	})
end
return t
