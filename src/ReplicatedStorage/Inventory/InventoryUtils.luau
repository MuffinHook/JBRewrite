-- Reviewed by Claude
return {
	doesInventoryValueHave = function(p1, p2)
		assert(p1, "missing inventoryValue")
		assert(p2, "missing itemName")
		return p1:FindFirstChild(p2) ~= nil
	end,
	getInventoryItemValue = function(p1, p2)
		assert(p1, "missing inventoryValue")
		assert(p2, "missing itemName")
		return p1:FindFirstChild(p2)
	end
}
