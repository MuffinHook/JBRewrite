-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local HomeItemConsts = require(script.Parent.HomeItemConsts)
local HomeItemUtils = require(script.Parent.HomeItemUtils)
local HomeBinder = require(script.Parent.Parent.HomeBinder)
local Fabricate = script.Parent.Fabricate
local t = {}
t.__index = t
t.__ClassName = "HomeItem"
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	RxInstanceUtils.yieldForProperty(self, "PrimaryPart")
	t2._maid = Maid.new()
	t2._obj = self
	t2._placeRemote = self:WaitForChild(HomeItemConsts.PLACE_REMOTE_NAME)
	t2._deleteRemote = self:WaitForChild(HomeItemConsts.DELETE_REMOTE_NAME)
	t2._ownerIdValue = self:WaitForChild(HomeItemConsts.OWNER_ID_VALUE_NAME)
	t2._upDotValue = self:WaitForChild(HomeItemConsts.UP_DOT_VALUE_NAME)
	t2._isPlacedValue = self:WaitForChild(HomeItemConsts.IS_PLACED_VALUE_NAME)
	t2._isGhostValue = self:WaitForChild(HomeItemConsts.IS_GHOST_VALUE_NAME)
	t2._damageRemote = nil
	t2._isBeingDragged = false
	t2._offsetCF = CFrame.new(0, -self.PrimaryPart.Size.Y * 0.5, 0):Inverse()
	local v2 = Fabricate:FindFirstChild(t2._obj.Name)
	if v2 then
		require(v2).setup(t2)
	end
	return t2
end
function t.GetHome(self)
	return HomeBinder:Get(self._obj.Parent)
end
function t.GetOwner(self)
	return Players:GetPlayerByUserId(self._ownerIdValue.Value)
end
function t.GetObj(self)
	return self._obj
end
function t.TranslateCf(self, p2)
	return p2 * self._offsetCF
end
function t.UntranslateCf(self, p2)
	return p2 * self._offsetCF:Inverse()
end
function t.SetCFrame(self, p2)
	self._obj:SetPrimaryPartCFrame(p2)
end
function t.SetServerCFrame(self, p2)
	self._placeRemote:FireServer(p2)
end
function t.CacheSurfaces(self)
	local v1 = self:GetHome()
	assert(v1 ~= nil)
	self._cacheSurfaces = v1:GetSurfaces()
end
function t.ClearCacheSurfaces(self)
	self._cacheSurfaces = nil
end
function t.IsWithinBoundsCached(self, p2)
	return HomeItemUtils.isWithinBounds(self._obj.PrimaryPart, p2, self._cacheSurfaces)
end
function t.IsValidUpDot(self, p2)
	return math.abs(p2 - self._upDotValue.Value) < 0.1
end
function t.AttemptDelete(self)
	self._deleteRemote:FireServer()
end
function t.Damage(self)
	if not self._damageRemote then
		self._damageRemote = self._obj:FindFirstChild(HomeItemConsts.DAMAGE_REMOTE_NAME)
	end
	if self._damageRemote then
		self._damageRemote:FireServer()
		Audio.ObjectLocal(self._obj.PrimaryPart, 2837091387, {
			Volume = 1
		})
	end
end
function t.SetBeingDragged(self, p2)
	self._isBeingDragged = p2
end
function t.IsBeingDragged(self)
	return self._isBeingDragged
end
function t.GetGhosted(self)
	return self._isGhostValue.Value
end
function t.IsPlaced(self)
	return self._isPlacedValue.Value
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return t
