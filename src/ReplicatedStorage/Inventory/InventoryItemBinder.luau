local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local InventoryItemConsts = require(ReplicatedStorage.Inventory.InventoryItemConsts)
return Binder.new(InventoryItemConsts.TAG_NAME, require(script.Parent.InventoryItem))
