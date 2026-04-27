local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local SurfaceUtils = require(script.Parent.SurfaceUtils)
local t = {}
t.__index = t
t.__ClassName = "Surface"
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = self
	return t2
end
function t.GetPlacementPrism(self)
	return SurfaceUtils.getPlacementPrism(self._obj.CFrame, self._obj.Size)
end
function t.GetStandingPrism(self)
	return SurfaceUtils.getStandingPrism(self._obj.CFrame, self._obj.Size)
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return t
