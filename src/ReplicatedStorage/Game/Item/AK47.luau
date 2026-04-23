local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "AK47"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3) --[[ Line: 11 | Upvalues: Gun (copy), t (copy) ]]
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.ShootSound(p1, p2) --[[ Line: 18 | Upvalues: Audio (copy) ]]
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
function t.ReloadDropAmmoSound(p1) --[[ Line: 33 | Upvalues: Audio (copy) ]]
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1) --[[ Line: 38 | Upvalues: Audio (copy) ]]
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
		RollOffMaxDistance = 129
	})
end
return t