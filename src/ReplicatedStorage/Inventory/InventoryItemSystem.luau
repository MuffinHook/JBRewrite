-- Reviewed by Claude
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local InventoryItemBinder = require(script.Parent.InventoryItemBinder)
local InventoryItemUtils = require(script.Parent.InventoryItemUtils)
local InventoryItemOwnerBinder = require(script.Parent.InventoryItemOwnerBinder)
local t = {
	onInventoryItemEquipped = Signal.new(),
	onInventoryItemUnequipped = Signal.new(),
	_equipConditions = {},
	_unequipConditions = {}
}
function t.init()
	local function handleInventoryItemAdded(self)
		local v1 = nil
		local function handleEquipped()
			local var12 = self:GetOwner() and true or false
			local v2 = InventoryItemUtils.getEquipped(self.obj)
			if var12 then
				if v2 == v1 then
					return
				end
				v1 = v2
				if v2 then
					t.onInventoryItemEquipped:Fire(self)
				else
					t.onInventoryItemUnequipped:Fire(self)
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
			t.onInventoryItemUnequipped:Fire(self)
		end
	end
	InventoryItemBinder:GetClassRemovingSignal():Connect(handleInventoryItemRemoved)
	InventoryItemBinder:GetClassAddedSignal():Connect(function(self)
		self._maid:GiveTask(self.onAttemptSelect:Connect(function()
			local v1 = InventoryItemUtils.getEquipped(self.obj)
			if t.unequipAll() and not v1 then
				t.toggleEquip(self)
			end
		end))
	end)
	InventoryItemBinder:Start()
	InventoryItemOwnerBinder:Start()
	t.addUnequipCondition(function(self)
		return not InventoryItemUtils.getLocked(self.obj)
	end)
	UserInputService.InputBegan:Connect(function(self, p2)
		if not p2 and (self.UserInputType == Enum.UserInputType.Keyboard and self.KeyCode == Enum.KeyCode.Backspace) then
			for i, v in ipairs((t.getEquippedFor(Players.LocalPlayer))) do
				v:AttemptDrop()
			end
		end
	end)
end
function t.addEquipCondition(self)
	table.insert(t._equipConditions, self)
end
function t.addUnequipCondition(self)
	table.insert(t._unequipConditions, self)
end
function t.unequipAll()
	for i, v in ipairs((t.getInventoryItemsFor(Players.LocalPlayer))) do
		if InventoryItemUtils.getEquipped(v.obj) then
			for i2, v2 in ipairs(t._unequipConditions) do
				if not v2(v) then
					return false
				end
			end
			v:AttemptSetEquipped(false)
		end
	end
	return true
end
function t.toggleEquip(self)
	if InventoryItemUtils.getEquipped(self.obj) then
		for i, v in ipairs(t._unequipConditions) do
			if not v(self) then
				return
			end
		end
		self:AttemptSetEquipped(false)
	else
		for i, v in ipairs(t._equipConditions) do
			if not v(self) then
				return
			end
		end
		self:AttemptSetEquipped(true)
	end
	return true
end
function t.getInventoryItemsFor(self)
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(p12)
		return p12:GetOwner() == self
	end)
end
function t.getInventoryItemsOfInventoryValue(self)
	return BinderUtils.getChildren(InventoryItemBinder, self)
end
function t.getEquipped()
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(self)
		return InventoryItemUtils.getEquipped(self.obj)
	end)
end
function t.getEquippedFor(self)
	return TableUtils.filter(t.getEquipped(), function(p12)
		return p12:GetOwner() == self
	end)
end
function t.playerHasItem(self, p2)
	for i, v in ipairs(t.getInventoryItemsFor(self)) do
		if v:GetName() == p2 then
			return true
		end
	end
	return false
end
return t
