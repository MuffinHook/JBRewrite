local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunShopUtils = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local GunRackConsts = require(script.GunRackConsts)
local GunRack = {}
GunRack.__index = GunRack
function GunRack.new(self)
	local gunRackInstance = {}
	setmetatable(gunRackInstance, GunRack)
	gunRackInstance._obj = self._obj
	gunRackInstance._maid = Maid.new()
	local function action(self, isPressed)
		if isPressed then
			gunRackInstance._obj:FindFirstChild(GunRackConsts.INTERACT_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(self)
		local instance = gunRackInstance:GetItemName()
		local localPlayer = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1]
		local equippedGunName = localPlayer and localPlayer:GetName()
		if not GunRackConsts.WHITELIST[equippedGunName] then
			equippedGunName = nil
		end
		local isActionEnabled = not HomeItemSystem.isCustomizing()
		if instance and (localPlayer and instance == equippedGunName) then
			isActionEnabled = false
		end
		if equippedGunName and instance then
			self.Duration = 0.5
			self.Timed = true
		else
			self.Timed = false
		end
		if equippedGunName and instance then
			self.Name = ("Replace %s with %s"):format(GunShopUtils.getTranslatedTitleFromName(instance), GunShopUtils.getTranslatedTitleFromName(equippedGunName))
		elseif instance then
			self.Name = ("Grab %s"):format(GunShopUtils.getTranslatedTitleFromName(instance))
		elseif equippedGunName then
			self.Name = ("Mount %s"):format(GunShopUtils.getTranslatedTitleFromName(equippedGunName))
		else
			isActionEnabled = false
		end
		self.Enabled = isActionEnabled
	end
	gunRackInstance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(gunRackInstance._obj, "Prompt", function(self, maid)
		CircleAction.Add({
			Part = self,
			ValidRoot = gunRackInstance._obj,
			Name = "Interact",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.5
		}, self)
		maid:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	return gunRackInstance
end
function GunRack.GetItemName(self)
	return self._obj:GetAttribute(GunRackConsts.ITEM_NAME_ATTR_NAME)
end
function GunRack.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local instance = GunRack.new(self)
		self._maid:GiveTask(instance)
		self._gunRack = instance
	end
}
