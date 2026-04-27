local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Signal = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
require(ReplicatedStorage.Std.Maid)
local InventoryItemOwnerClass = {}
InventoryItemOwnerClass.__index = InventoryItemOwnerClass
setmetatable(InventoryItemOwnerClass, BaseObject)
function InventoryItemOwnerClass.new(inventoryItem)
	local instance = BaseObject.new(inventoryItem)
	setmetatable(instance, InventoryItemOwnerClass)
	instance.Name = inventoryItem.Name
	instance._onCharacterChanged = Signal.new()
	local function update()
		if inventoryItem.Value then
			instance.maid.observeChar = RxInstanceUtils.observeProperty(inventoryItem.Value, "PrimaryPart", function(primaryPart)
				task.wait()
				if primaryPart then
					instance.Character = inventoryItem.Value
				else
					instance.Character = nil
				end
				instance._onCharacterChanged:Fire(instance.Character)
			end)
		end
	end
	if inventoryItem.Value then
		instance.maid.observeChar = RxInstanceUtils.observeProperty(inventoryItem.Value, "PrimaryPart", function(primaryPart)
			task.wait()
			if primaryPart then
				instance.Character = inventoryItem.Value
			else
				instance.Character = nil
			end
			instance._onCharacterChanged:Fire(instance.Character)
		end)
	end
	instance.maid:GiveTask(inventoryItem.Changed:Connect(update))
	return instance
end
function InventoryItemOwnerClass.GetAttribute(inventoryItem, attributeName)
	return inventoryItem["attr" .. tostring(attributeName)]
end
function InventoryItemOwnerClass.SetAttribute(inventoryItem, attributeName, attributeValue)
	inventoryItem["attr" .. tostring(attributeName)] = attributeValue
end
return Binder.new("InventoryItemOwner", InventoryItemOwnerClass)
