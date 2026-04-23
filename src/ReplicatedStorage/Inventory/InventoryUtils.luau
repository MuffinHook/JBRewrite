return {
	doesInventoryValueHave = function(p1, p2) --[[ Name: doesInventoryValueHave | Line: 2 ]]
		assert(p1, "missing inventoryValue")
		assert(p2, "missing itemName")
		return p1:FindFirstChild(p2) ~= nil
	end,
	getInventoryItemValue = function(p1, p2) --[[ Name: getInventoryItemValue | Line: 8 ]]
		assert(p1, "missing inventoryValue")
		assert(p2, "missing itemName")
		return p1:FindFirstChild(p2)
	end
}