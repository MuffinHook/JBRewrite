return {
	doesInventoryValueHave = function(inventoryValue, itemName)
		assert(inventoryValue, "missing inventoryValue")
		assert(itemName, "missing itemName")
		return inventoryValue:FindFirstChild(itemName) ~= nil
	end,
	getInventoryItemValue = function(inventoryValue, itemName)
		assert(inventoryValue, "missing inventoryValue")
		assert(itemName, "missing itemName")
		return inventoryValue:FindFirstChild(itemName)
	end
}
