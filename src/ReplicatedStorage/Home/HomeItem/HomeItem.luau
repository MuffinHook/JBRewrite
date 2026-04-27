local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local HomeItemConsts = require(script.Parent.HomeItemConsts)
local HomeItemUtils = require(script.Parent.HomeItemUtils)
local HomeBinder = require(script.Parent.Parent.HomeBinder)
local Fabricate = script.Parent.Fabricate
local HomeItem = {}
HomeItem.__index = HomeItem
HomeItem.__ClassName = "HomeItem"
function HomeItem.new(self)
	local instance = {}
	setmetatable(instance, HomeItem)
	RxInstanceUtils.yieldForProperty(self, "PrimaryPart")
	instance._maid = Maid.new()
	instance._obj = self
	instance._placeRemote = self:WaitForChild(HomeItemConsts.PLACE_REMOTE_NAME)
	instance._deleteRemote = self:WaitForChild(HomeItemConsts.DELETE_REMOTE_NAME)
	instance._ownerIdValue = self:WaitForChild(HomeItemConsts.OWNER_ID_VALUE_NAME)
	instance._upDotValue = self:WaitForChild(HomeItemConsts.UP_DOT_VALUE_NAME)
	instance._isPlacedValue = self:WaitForChild(HomeItemConsts.IS_PLACED_VALUE_NAME)
	instance._isGhostValue = self:WaitForChild(HomeItemConsts.IS_GHOST_VALUE_NAME)
	instance._damageRemote = nil
	instance._isBeingDragged = false
	instance._offsetCF = CFrame.new(0, -self.PrimaryPart.Size.Y * 0.5, 0):Inverse()
	local fabricateModule = Fabricate:FindFirstChild(instance._obj.Name)
	if fabricateModule then
		require(fabricateModule).setup(instance)
	end
	return instance
end
function HomeItem.GetHome(self)
	return HomeBinder:Get(self._obj.Parent)
end
function HomeItem.GetOwner(self)
	return Players:GetPlayerByUserId(self._ownerIdValue.Value)
end
function HomeItem.GetObj(self)
	return self._obj
end
function HomeItem.TranslateCf(self, cframe)
	return cframe * self._offsetCF
end
function HomeItem.UntranslateCf(self, cframe)
	return cframe * self._offsetCF:Inverse()
end
function HomeItem.SetCFrame(self, cframe)
	self._obj:SetPrimaryPartCFrame(cframe)
end
function HomeItem.SetServerCFrame(self, cframe)
	self._placeRemote:FireServer(cframe)
end
function HomeItem.CacheSurfaces(self)
	local home = self:GetHome()
	assert(home ~= nil)
	self._cacheSurfaces = home:GetSurfaces()
end
function HomeItem.ClearCacheSurfaces(self)
	self._cacheSurfaces = nil
end
function HomeItem.IsWithinBoundsCached(self, cframe)
	return HomeItemUtils.isWithinBounds(self._obj.PrimaryPart, cframe, self._cacheSurfaces)
end
function HomeItem.IsValidUpDot(self, upDot)
	return math.abs(upDot - self._upDotValue.Value) < 0.1
end
function HomeItem.AttemptDelete(self)
	self._deleteRemote:FireServer()
end
function HomeItem.Damage(self)
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
function HomeItem.SetBeingDragged(self, isDragged)
	self._isBeingDragged = isDragged
end
function HomeItem.IsBeingDragged(self)
	return self._isBeingDragged
end
function HomeItem.GetGhosted(self)
	return self._isGhostValue.Value
end
function HomeItem.IsPlaced(self)
	return self._isPlacedValue.Value
end
function HomeItem.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return HomeItem
