local EnumSort = require(script.Parent.EnumSort)
local sortUtilsModule = {
	getSortFunc = function(sortEnum)
		if sortEnum == EnumSort.Alphabetical then
			return function(itemA, itemB)
				local title = itemA.title
				local title_2 = itemB.title
				if itemA.isNone then
					title = "\0"
				end
				if itemB.isNone then
					title_2 = "\0"
				end
				return title < title_2
			end
		end
		if sortEnum == EnumSort.Price then
			return function(itemA, itemB)
				local itemAMetric = itemA.priceSortMetric or itemA.price or 0
				if itemA.hidden then
					itemAMetric = 0
				end
				local itemBMetric = itemB.priceSortMetric or itemB.price or 0
				if itemB.hidden then
					itemBMetric = 0
				end
				if itemA.isNone or itemA.limited then
					itemAMetric = -1
				end
				if itemB.isNone or itemB.limited then
					itemBMetric = -1
				end
				return itemBMetric < itemAMetric
			end
		end
		if sortEnum == EnumSort.PriceLow then
			return function(itemA, itemB)
				local itemAMetric = itemA.priceSortMetric or itemA.price or 0
				if itemA.hidden then
					itemAMetric = 0
				end
				local itemBMetric = itemB.priceSortMetric or itemB.price or 0
				if itemB.hidden then
					itemBMetric = 0
				end
				if itemA.isNone or itemA.limited then
					itemAMetric = (1 / 0)
				end
				if itemB.isNone or itemB.limited then
					itemBMetric = (1 / 0)
				end
				return itemAMetric < itemBMetric
			end
		end
		if sortEnum == EnumSort.Newest then
			return function(itemA, itemB)
				local itemAMetric = itemA.timeSortMetric or itemA.primaryIndex
				local itemBMetric = itemB.timeSortMetric or itemB.primaryIndex
				if itemA.isNone then
					itemAMetric = (-1 / 0)
				end
				if itemB.isNone then
					itemBMetric = (-1 / 0)
				end
				return itemAMetric < itemBMetric
			end
		end
		if sortEnum == EnumSort.Popular then
			return function(itemA, itemB)
				local itemAMetric = itemA.salesIndex or itemA.primaryIndex + 9999
				local itemBMetric = itemB.salesIndex or itemB.primaryIndex + 9999
				if itemA.isNone then
					itemAMetric = 0
				end
				if itemB.isNone then
					itemBMetric = 0
				end
				return itemAMetric < itemBMetric
			end
		end
		error("invalid sort enum passed", sortEnum)
	end
}
function sortUtilsModule.getTradeSortFunc(sortEnum)
	if sortEnum == EnumSort.Popular then
		return function(itemA, itemB)
			local itemAMetric = itemA.tradePopularMetric or 0
			local itemBMetric = itemB.tradePopularMetric or 0
			if itemA.isNone then
				itemAMetric = (-1 / 0)
			end
			if itemB.isNone then
				itemBMetric = (-1 / 0)
			end
			return itemBMetric < itemAMetric
		end
	else
		return sortUtilsModule.getSortFunc(sortEnum)
	end
end
return sortUtilsModule
