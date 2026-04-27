local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Promise = require(ReplicatedStorage.Std.Promise)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local InventoryItemConsts = require(script.Parent.InventoryItemConsts)
local InventoryItemUtils = require(script.Parent.InventoryItemUtils)
local InventoryItemOwnerBinder = require(script.Parent.InventoryItemOwnerBinder)
local t = {}
t.__index = t
function t.new(itemObj)
	local instance = {}
	setmetatable(instance, t)
	instance.obj = itemObj
	instance._maid = Maid.new()
	instance.onAttemptSelect = Signal.new()
	instance._maid:GiveTask(instance.onAttemptSelect)
	instance.onAttemptDrop = Signal.new()
	instance._maid:GiveTask(instance.onAttemptDrop)
	instance._maid:GiveTask(function()
		InventoryItemUtils.setEquipped(instance.obj, false)
	end)
	instance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(itemObj, InventoryItemConsts.EQUIP_REMOTE_NAME, function(remote, maid)
		maid:GiveTask(remote.OnClientEvent:Connect(function()
			instance:AttemptSelect()
		end))
	end))
	local function update()
		local serverEquipped = itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
		if (itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < serverEquipped then
			itemObj:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, serverEquipped)
		end
	end
	instance._maid:GiveTask(itemObj:GetAttributeChangedSignal(InventoryItemConsts.EQUIPPED_ATTR_NAME):Connect(update))
	local serverEquipped = itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
	if (itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < serverEquipped then
		itemObj:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, serverEquipped)
	end
	instance._overriddenOwner = nil
	return instance
end
function t.GetName(self)
	return InventoryItemUtils.getName(self.obj)
end
function t.GetOwner(self)
	local ownerContainer = self.obj.Parent.Parent
	if ownerContainer then
		local boundOwner = InventoryItemOwnerBinder:Get(ownerContainer)
		if boundOwner then
			return boundOwner
		end
		if ownerContainer.Parent == game:GetService("Players") then
			return ownerContainer
		end
	end
end
function t.PromiseOwner(self)
	local ownerContainer = self.obj.Parent.Parent
	if ownerContainer then
		if ownerContainer.Parent == game:GetService("Players") then
			return Promise.resolve(ownerContainer)
		else
			return InventoryItemOwnerBinder:Promise(ownerContainer)
		end
	end
end
function t.GetAttr(self, ...)
	return InventoryItemUtils.getAttr(self.obj, ...)
end
function t.SetAttr(self, ...)
	InventoryItemUtils.setAttr(self.obj, ...)
end
function t.GetEquipped(self, ...)
	return InventoryItemUtils.getEquipped(self.obj, ...)
end
function t.SetEquipped(self, ...)
	InventoryItemUtils.setEquipped(self.obj, ...)
end
function t.GetEquippedSignal(self)
	return InventoryItemUtils.getEquippedSignal(self.obj)
end
function t.AttemptSetEquipped(self, equippedValue)
	assert(equippedValue ~= nil, "missing value")
	InventoryItemUtils.setEquipped(self.obj, equippedValue)
	self.obj:FindFirstChild(InventoryItemConsts.EQUIP_REMOTE_NAME):FireServer(equippedValue)
end
function t.AttemptSelect(self)
	self.onAttemptSelect:Fire()
end
function t.AttemptDrop(self)
	self.onAttemptDrop:Fire()
end
function t.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return t
