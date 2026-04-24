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
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	t2._maid = Maid.new()
	t2._obj = p1
	t2._placeRemote = p1:WaitForChild(HomeItemConsts.PLACE_REMOTE_NAME)
	t2._deleteRemote = p1:WaitForChild(HomeItemConsts.DELETE_REMOTE_NAME)
	t2._ownerIdValue = p1:WaitForChild(HomeItemConsts.OWNER_ID_VALUE_NAME)
	t2._upDotValue = p1:WaitForChild(HomeItemConsts.UP_DOT_VALUE_NAME)
	t2._isPlacedValue = p1:WaitForChild(HomeItemConsts.IS_PLACED_VALUE_NAME)
	t2._isGhostValue = p1:WaitForChild(HomeItemConsts.IS_GHOST_VALUE_NAME)
	t2._damageRemote = nil
	t2._isBeingDragged = false
	t2._offsetCF = CFrame.new(0, -p1.PrimaryPart.Size.Y * 0.5, 0):Inverse()
	local v2 = Fabricate:FindFirstChild(t2._obj.Name)
	if v2 then
		require(v2).setup(t2)
	end
	return t2
end
function t.GetHome(p1)
	return HomeBinder:Get(p1._obj.Parent)
end
function t.GetOwner(p1)
	return Players:GetPlayerByUserId(p1._ownerIdValue.Value)
end
function t.GetObj(p1)
	return p1._obj
end
function t.TranslateCf(p1, p2)
	return p2 * p1._offsetCF
end
function t.UntranslateCf(p1, p2)
	return p2 * p1._offsetCF:Inverse()
end
function t.SetCFrame(p1, p2)
	p1._obj:SetPrimaryPartCFrame(p2)
end
function t.SetServerCFrame(p1, p2)
	p1._placeRemote:FireServer(p2)
end
function t.CacheSurfaces(p1)
	local v1 = p1:GetHome()
	assert(v1 ~= nil)
	p1._cacheSurfaces = v1:GetSurfaces()
end
function t.ClearCacheSurfaces(p1)
	p1._cacheSurfaces = nil
end
function t.IsWithinBoundsCached(p1, p2)
	return HomeItemUtils.isWithinBounds(p1._obj.PrimaryPart, p2, p1._cacheSurfaces)
end
function t.IsValidUpDot(p1, p2)
	return math.abs(p2 - p1._upDotValue.Value) < 0.1
end
function t.AttemptDelete(p1)
	p1._deleteRemote:FireServer()
end
function t.Damage(p1)
	if not p1._damageRemote then
		p1._damageRemote = p1._obj:FindFirstChild(HomeItemConsts.DAMAGE_REMOTE_NAME)
	end
	if p1._damageRemote then
		p1._damageRemote:FireServer()
		Audio.ObjectLocal(p1._obj.PrimaryPart, 2837091387, {
			Volume = 1
		})
	end
end
function t.SetBeingDragged(p1, p2)
	p1._isBeingDragged = p2
end
function t.IsBeingDragged(p1)
	return p1._isBeingDragged
end
function t.GetGhosted(p1)
	return p1._isGhostValue.Value
end
function t.IsPlaced(p1)
	return p1._isPlacedValue.Value
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t
