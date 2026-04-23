local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local InventoryConsts = require(ReplicatedStorage.Inventory.InventoryConsts)
return Binder.new(InventoryConsts.TAG_NAME, require(script.Parent.Inventory))