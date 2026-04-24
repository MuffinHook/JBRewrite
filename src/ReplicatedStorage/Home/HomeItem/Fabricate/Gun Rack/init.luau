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
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = self._obj
	t2._maid = Maid.new()
	local function action(self, p2)
		if p2 then
			t2._obj:FindFirstChild(GunRackConsts.INTERACT_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(self)
		local instance = t2:GetItemName()
		local localPlayer = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1]
		local var3 = localPlayer and localPlayer:GetName()
		if not GunRackConsts.WHITELIST[var3] then
			var3 = nil
		end
		local var4 = not HomeItemSystem.isCustomizing()
		if instance and (localPlayer and instance == var3) then
			var4 = false
		end
		if var3 and instance then
			self.Duration = 0.5
			self.Timed = true
		else
			self.Timed = false
		end
		if var3 and instance then
			self.Name = ("Replace %s with %s"):format(GunShopUtils.getTranslatedTitleFromName(instance), GunShopUtils.getTranslatedTitleFromName(var3))
		elseif instance then
			self.Name = ("Grab %s"):format(GunShopUtils.getTranslatedTitleFromName(instance))
		elseif var3 then
			self.Name = ("Mount %s"):format(GunShopUtils.getTranslatedTitleFromName(var3))
		else
			var4 = false
		end
		self.Enabled = var4
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(t2._obj, "Prompt", function(self, p2)
		CircleAction.Add({
			Part = self,
			ValidRoot = t2._obj,
			Name = "Interact",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.5
		}, self)
		p2:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	return t2
end
function t.GetItemName(self)
	return self._obj:GetAttribute(GunRackConsts.ITEM_NAME_ATTR_NAME)
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local instance = t.new(self)
		self._maid:GiveTask(instance)
		self._gunRack = instance
	end
}
