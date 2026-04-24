-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local SurfaceUtils = require(script.Parent.SurfaceUtils)
local t = {}
t.__index = t
t.__ClassName = "Surface"
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	return t2
end
function t.GetPlacementPrism(p1)
	return SurfaceUtils.getPlacementPrism(p1._obj.CFrame, p1._obj.Size)
end
function t.GetStandingPrism(p1)
	return SurfaceUtils.getStandingPrism(p1._obj.CFrame, p1._obj.Size)
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t
