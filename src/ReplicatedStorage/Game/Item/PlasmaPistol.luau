-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gun = require(script.Parent.Gun)
local PlasmaGun = require(ReplicatedStorage.Game.Item.PlasmaGun)
local t = {
	__ClassName = "PlasmaPistol"
}
t.__index = t
setmetatable(t, PlasmaGun)
function t.Init(p1)  end
function t.new(p1, p2, p3)
	local v1 = PlasmaGun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.SetupModel(p1)
	Gun.SetupModel(p1)
end
return t
