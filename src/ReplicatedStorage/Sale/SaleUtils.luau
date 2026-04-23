local SaleConsts = require(script.Parent.SaleConsts)
local t = {
	getNumSalesPassed = function() --[[ Name: getNumSalesPassed | Line: 3 | Upvalues: SaleConsts (copy) ]]
		return math.floor((workspace:GetServerTimeNow() - SaleConsts.FIRST_SALE_START_TIMESTAMP) / SaleConsts.SALE_DURATION_SECONDS)
	end
}
function t.getNextSaleTime() --[[ Line: 7 | Upvalues: t (copy), SaleConsts (copy) ]]
	return SaleConsts.FIRST_SALE_START_TIMESTAMP + (t.getNumSalesPassed() + 1) * SaleConsts.SALE_DURATION_SECONDS
end
function t.getTimeToNextSale() --[[ Line: 13 | Upvalues: t (copy) ]]
	return t.getNextSaleTime() - workspace:GetServerTimeNow()
end
function t.formatRemaining(p1) --[[ Line: 18 ]]
	local v1 = math.max(0, p1)
	local v2 = math.floor(v1 / 86400)
	local v3 = math.floor(v1 % 86400 / 3600)
	local v4 = math.floor(v1 % 3600 / 60)
	local v5 = math.floor(v1 % 60)
	if v2 > 0 then
		return ("%dd %dh %dm %ds"):format(v2, v3, v4, v5)
	elseif v3 > 0 then
		return ("%dh %dm %ds"):format(v3, v4, v5)
	elseif v4 > 0 then
		return ("%dm %ds"):format(v4, v5)
	else
		return ("%ds"):format(v5)
	end
end
return t