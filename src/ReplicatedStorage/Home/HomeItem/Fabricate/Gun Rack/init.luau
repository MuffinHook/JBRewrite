-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunShopUtils = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local GunRackConsts = require(script.GunRackConsts)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = p1._obj
	t2._maid = Maid.new()
	local function action(p1, p2)
		if p2 then
			t2._obj:FindFirstChild(GunRackConsts.INTERACT_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(p1)
		local v1 = t2:GetItemName()
		local v2 = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1]
		local v3 = v2 and v2:GetName()
		if not GunRackConsts.WHITELIST[v3] then
			v3 = nil
		end
		local v4 = not HomeItemSystem.isCustomizing()
		if v1 and (v2 and v1 == v3) then
			v4 = false
		end
		if v3 and v1 then
			p1.Duration = 0.5
			p1.Timed = true
		else
			p1.Timed = false
		end
		if v3 and v1 then
			p1.Name = ("Replace %s with %s"):format(GunShopUtils.getTranslatedTitleFromName(v1), GunShopUtils.getTranslatedTitleFromName(v3))
		elseif v1 then
			p1.Name = ("Grab %s"):format(GunShopUtils.getTranslatedTitleFromName(v1))
		elseif v3 then
			p1.Name = ("Mount %s"):format(GunShopUtils.getTranslatedTitleFromName(v3))
		else
			v4 = false
		end
		p1.Enabled = v4
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(t2._obj, "Prompt", function(p1, p2)
		CircleAction.Add({
			Part = p1,
			ValidRoot = t2._obj,
			Name = "Interact",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.5
		}, p1)
		p2:GiveTask(function()
			CircleAction.Remove(p1)
		end)
	end))
	return t2
end
function t.GetItemName(p1)
	return p1._obj:GetAttribute(GunRackConsts.ITEM_NAME_ATTR_NAME)
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return {
	setup = function(p1)
		local v1 = t.new(p1)
		p1._maid:GiveTask(v1)
		p1._gunRack = v1
	end
}
