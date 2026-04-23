local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gun = require(script.Parent.Gun)
local PlasmaGun = require(ReplicatedStorage.Game.Item.PlasmaGun)
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {
	__ClassName = "PlasmaShotgun"
}
t.__index = t
setmetatable(t, PlasmaGun)
function t.Init(p1) --[[ Line: 10 ]] end
function t.new(p1, p2, p3) --[[ Line: 11 | Upvalues: PlasmaGun (copy), t (copy) ]]
	local v1 = PlasmaGun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.SetupModel(p1) --[[ Line: 17 | Upvalues: Gun (copy) ]]
	Gun.SetupModel(p1)
end
function t.ShootSound(p1, p2) --[[ Line: 20 | Upvalues: Audio (copy) ]]
	if not p2 then
		Audio.ObjectLocal(p1.Tip, 17183453324, {
			Volume = 0.35,
			TimePosition = 0.05
		})
	end
end
return t