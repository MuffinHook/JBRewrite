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
	local function handleInventoryItemAdded(p1)
		local v1 = nil
		local function handleEquipped()
			local v12 = p1:GetOwner() and true or false
			local v2 = InventoryItemUtils.getEquipped(p1.obj)
			if v12 then
				if v2 == v1 then
					return
				end
				v1 = v2
				if v2 then
					t.onInventoryItemEquipped:Fire(p1)
				else
					t.onInventoryItemUnequipped:Fire(p1)
				end
			end
		end
		handleEquipped()
		p1._maid:GiveTask(InventoryItemUtils.getEquippedSignal(p1.obj):Connect(handleEquipped))
		if not p1:GetOwner() then
			p1._maid:GivePromise(p1:PromiseOwner():andThen(handleEquipped))
		end
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleInventoryItemAdded)
	local function handleInventoryItemRemoved(p1)
		if InventoryItemUtils.getEquipped(p1.obj) then
			t.onInventoryItemUnequipped:Fire(p1)
		end
	end
	InventoryItemBinder:GetClassRemovingSignal():Connect(handleInventoryItemRemoved)
	InventoryItemBinder:GetClassAddedSignal():Connect(function(p1)
		p1._maid:GiveTask(p1.onAttemptSelect:Connect(function()
			local v1 = InventoryItemUtils.getEquipped(p1.obj)
			if t.unequipAll() and not v1 then
				t.toggleEquip(p1)
			end
		end))
	end)
	InventoryItemBinder:Start()
	InventoryItemOwnerBinder:Start()
	t.addUnequipCondition(function(p1)
		return not InventoryItemUtils.getLocked(p1.obj)
	end)
	UserInputService.InputBegan:Connect(function(p1, p2)
		if not p2 and (p1.UserInputType == Enum.UserInputType.Keyboard and p1.KeyCode == Enum.KeyCode.Backspace) then
			for i, v in ipairs((t.getEquippedFor(Players.LocalPlayer))) do
				v:AttemptDrop()
			end
		end
	end)
end
function t.addEquipCondition(p1)
	table.insert(t._equipConditions, p1)
end
function t.addUnequipCondition(p1)
	table.insert(t._unequipConditions, p1)
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
function t.toggleEquip(p1)
	if InventoryItemUtils.getEquipped(p1.obj) then
		for i, v in ipairs(t._unequipConditions) do
			if not v(p1) then
				return
			end
		end
		p1:AttemptSetEquipped(false)
	else
		for i, v in ipairs(t._equipConditions) do
			if not v(p1) then
				return
			end
		end
		p1:AttemptSetEquipped(true)
	end
	return true
end
function t.getInventoryItemsFor(p1)
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(p12)
		return p12:GetOwner() == p1
	end)
end
function t.getInventoryItemsOfInventoryValue(p1)
	return BinderUtils.getChildren(InventoryItemBinder, p1)
end
function t.getEquipped()
	return TableUtils.filter(InventoryItemBinder:GetAll(), function(p1)
		return InventoryItemUtils.getEquipped(p1.obj)
	end)
end
function t.getEquippedFor(p1)
	return TableUtils.filter(t.getEquipped(), function(p12)
		return p12:GetOwner() == p1
	end)
end
function t.playerHasItem(p1, p2)
	for i, v in ipairs(t.getInventoryItemsFor(p1)) do
		if v:GetName() == p2 then
			return true
		end
	end
	return false
end
return t
