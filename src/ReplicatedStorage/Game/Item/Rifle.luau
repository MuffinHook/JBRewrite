-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "Rifle"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.ShootSound(p1, p2)
	if p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_dry_fire_01, {
			Volume = 0.4,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	else
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
		RollOffMaxDistance = 129
	})
end
return t
