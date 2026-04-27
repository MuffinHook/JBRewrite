local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local InventoryItemBinder = require(script.Parent.InventoryItemBinder)
local InventoryItemUtils = require(script.Parent.InventoryItemUtils)
local InventoryItemOwnerBinder = require(script.Parent.InventoryItemOwnerBinder)
local InventoryItemSystem = {
	onInventoryItemEquipped = Signal.new(),
	onInventoryItemUnequipped = Signal.new(),
	_equipConditions = {},
	_unequipConditions = {}
}
function InventoryItemSystem.init()
	local function handleInventoryItemAdded(self)
		local previousEquippedStatus = nil
		local function handleEquipped()
			local hasOwner = self:GetOwner() and true or false
			local currentEquippedStatus = InventoryItemUtils.getEquipped(self.obj)
			if hasOwner then
				if currentEquippedStatus == previousEquippedStatus then
					return
				end
				previousEquippedStatus = currentEquippedStatus
				if currentEquippedStatus then
					InventoryItemSystem.onInventoryItemEquipped:Fire(self)
				else
					InventoryItemSystem.onInventoryItemUnequipped:Fire(self)
				end
			end
		end
		handleEquipped()
		self._maid:GiveTask(InventoryItemUtils.getEquippedSignal(self.obj):Connect(handleEquipped))
		if not self:GetOwner() then
			self._maid:GivePromise(self:PromiseOwner():andThen(handleEquipped))
		end
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleInventoryItemAdded)
	local function handleInventoryItemRemoved(self)
		if InventoryItemUtils.getEquipped(self.obj) then
			InventoryItemSystem.onInventoryItemUnequipped:Fire(self)
		end
	end
	InventoryItemBinder:GetClassRemovingSignal():Connect(handleInventoryItemRemoved)
	InventoryItemBinder:GetClassAddedSignal():Connect(function(self)
		self._maid:GiveTask(self.onAttemptSelect:Connect(function()
			local isCurrentlyEquipped = InventoryItemUtils.getEquipped(self.obj)
			if InventoryItemSystem.unequipAll() and not isCurrentlyEquipped then
				InventoryItemSystem.toggleEquip(self)
			end
		end))
	end)
	InventoryItemBinder:Start()
	InventoryItemOwnerBinder:Start()
	InventoryItemSystem.addUnequipCondition(function(self)
		return not InventoryItemUtils.getLocked(self.obj)
	end)
	UserInputService.InputBegan:Connect(function(self, inputData)
		if not inputData and (self.UserInputType == Enum.UserInputType.Keyboard and self.KeyCode == Enum.KeyCode.Backspace) then
			for i, v in ipairs((InventoryItemSystem.getEquippedFor(Players.LocalPlayer))) do
				v:AttemptDrop()
			end
		end
	end)
end
function InventoryItemSystem.addEquipCondition(self)
	table.insert(InventoryItemSystem._equipConditions, self)
end
function InventoryItemSystem.addUnequipCondition(self)
	table.insert(InventoryItemSystem._unequipConditions, self)
end
function InventoryItemSystem.unequipAll()
	for i, v in ipairs((InventoryItemSystem.getInventoryItemsFor(Players.LocalPlayer))) do
		if InventoryItemUtils.getEquipped(v.obj) then
			for i2, v2 in ipairs(InventoryItemSystem._unequipConditions) do
				if not v2(v) then
					return false
				end
			end
			v:AttemptSetEquipped(false)
		end
	end
	return true
end
function InventoryItemSystem.toggleEquip(self)
	if InventoryItemUtils.getEquipped(self.obj) then
		for i, v in ipairs(InventoryItemSystem._unequipConditions) do
			if not v(self) then
				return
			end
		end
		self:AttemptSetEquipped(false)
	else
		for i, v in ipairs(InventoryItemSystem._equipConditions) do
			if not v(self) then
				return
			end
		end
		self:AttemptSetEquipped(true)
	end
	return true
end
function InventoryItemSystem.getInventoryItemsFor(self)
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(inventoryItem)
		return inventoryItem:GetOwner() == self
	end)
end
function InventoryItemSystem.getInventoryItemsOfInventoryValue(self)
	return BinderUtils.getChildren(InventoryItemBinder, self)
end
function InventoryItemSystem.getEquipped()
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(self)
		return InventoryItemUtils.getEquipped(self.obj)
	end)
end
function InventoryItemSystem.getEquippedFor(self)
	return TableUtils.filter(InventoryItemSystem.getEquipped(), function(inventoryItem)
		return inventoryItem:GetOwner() == self
	end)
end
function InventoryItemSystem.playerHasItem(self, itemName)
	for i, v in ipairs(InventoryItemSystem.getInventoryItemsFor(self)) do
		if v:GetName() == itemName then
			return true
		end
	end
	return false
end
return InventoryItemSystem
