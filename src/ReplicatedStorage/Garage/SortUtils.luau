local EnumSort = require(script.Parent.EnumSort)
local t = {
	getSortFunc = function(p1) --[[ Name: getSortFunc | Line: 6 | Upvalues: EnumSort (copy) ]]
		if p1 == EnumSort.Alphabetical then
			return function(p1, p2) --[[ Line: 8 ]]
				local title = p1.title
				local title_2 = p2.title
				if p1.isNone then
					title = "\0"
				end
				if p2.isNone then
					title_2 = "\0"
				end
				return title < title_2
			end
		end
		if p1 == EnumSort.Price then
			return function(p1, p2) --[[ Line: 20 ]]
				local v1 = p1.priceSortMetric or p1.price or 0
				if p1.hidden then
					v1 = 0
				end
				local v2 = p2.priceSortMetric or p2.price or 0
				if p2.hidden then
					v2 = 0
				end
				if p1.isNone or p1.limited then
					v1 = -1
				end
				if p2.isNone or p2.limited then
					v2 = -1
				end
				return v2 < v1
			end
		end
		if p1 == EnumSort.PriceLow then
			return function(p1, p2) --[[ Line: 38 ]]
				local v1 = p1.priceSortMetric or p1.price or 0
				if p1.hidden then
					v1 = 0
				end
				local v2 = p2.priceSortMetric or p2.price or 0
				if p2.hidden then
					v2 = 0
				end
				if p1.isNone or p1.limited then
					v1 = (1 / 0)
				end
				if p2.isNone or p2.limited then
					v2 = (1 / 0)
				end
				return v1 < v2
			end
		end
		if p1 == EnumSort.Newest then
			return function(p1, p2) --[[ Line: 56 ]]
				local v1 = p1.timeSortMetric or p1.primaryIndex
				local v2 = p2.timeSortMetric or p2.primaryIndex
				if p1.isNone then
					v1 = (-1 / 0)
				end
				if p2.isNone then
					v2 = (-1 / 0)
				end
				return v1 < v2
			end
		end
		if p1 == EnumSort.Popular then
			return function(p1, p2) --[[ Line: 68 ]]
				local v1 = p1.salesIndex or p1.primaryIndex + 9999
				local v2 = p2.salesIndex or p2.primaryIndex + 9999
				if p1.isNone then
					v1 = 0
				end
				if p2.isNone then
					v2 = 0
				end
				return v1 < v2
			end
		end
		error("invalid sort enum passed", p1)
	end
}
function t.getTradeSortFunc(p1) --[[ Line: 83 | Upvalues: EnumSort (copy), t (copy) ]]
	if p1 == EnumSort.Popular then
		return function(p1, p2) --[[ Line: 85 ]]
			local v1 = p1.tradePopularMetric or 0
			local v2 = p2.tradePopularMetric or 0
			if p1.isNone then
				v1 = (-1 / 0)
			end
			if p2.isNone then
				v2 = (-1 / 0)
			end
			return v2 < v1
		end
	else
		return t.getSortFunc(p1)
	end
end
return t