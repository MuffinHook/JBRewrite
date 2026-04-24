-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return {
	setItemsOwned = function(p1, p2)
		assert(p2.itemsOwned ~= nil, "missing itemsOwned")
		local itemCountMap = {}
		local processedItems = {}
		for i = 1, #p2.itemsOwned do
			local itemProps = TradeReducerUtils.buildItemProps(p2.itemsOwned[i])
			if itemProps then
				itemProps.timeSortMetric = -i
				itemProps.primaryIndex = i
				local count = (itemCountMap[itemProps.getInstCompare] or 0) + 1
				itemCountMap[itemProps.getInstCompare] = count
				itemProps.number = count
				table.insert(processedItems, itemProps)
			end
		end
		for j = 1, #processedItems do
			local item = processedItems[j]
			if itemCountMap[item.getInstCompare] <= 1 then
				item.number = nil
			end
		end
		return processedItems
	end
}
