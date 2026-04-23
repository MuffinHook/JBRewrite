local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Inventory",
	CURRENT_INVENTORY_VALUE_NAME = "CurrentInventory"
})