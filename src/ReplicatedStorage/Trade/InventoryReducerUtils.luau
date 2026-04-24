-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return {
	setItemsOwned = function(p1, p2)
		assert(p2.itemsOwned ~= nil, "missing itemsOwned")
		local t = {}
		local t2 = {}
		for i = 1, #p2.itemsOwned do
			local v2 = TradeReducerUtils.buildItemProps(p2.itemsOwned[i])
			if v2 then
				v2.timeSortMetric = -i
				v2.primaryIndex = i
				local v3 = (t[v2.getInstCompare] or 0) + 1
				t[v2.getInstCompare] = v3
				v2.number = v3
				table.insert(t2, v2)
			end
		end
		for j = 1, #t2 do
			local v4 = t2[j]
			if t[v4.getInstCompare] <= 1 then
				v4.number = nil
			end
		end
		return t2
	end
}
