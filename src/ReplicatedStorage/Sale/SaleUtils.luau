-- Reviewed by Claude
local SaleConsts = require(script.Parent.SaleConsts)
local t = {
	getNumSalesPassed = function()
		return math.floor((workspace:GetServerTimeNow() - SaleConsts.FIRST_SALE_START_TIMESTAMP) / SaleConsts.SALE_DURATION_SECONDS)
	end
}
function t.getNextSaleTime()
	return SaleConsts.FIRST_SALE_START_TIMESTAMP + (t.getNumSalesPassed() + 1) * SaleConsts.SALE_DURATION_SECONDS
end
function t.getTimeToNextSale()
	return t.getNextSaleTime() - workspace:GetServerTimeNow()
end
function t.formatRemaining(p1)
	local v1 = math.max(0, p1)
	local v2 = math.floor(v1 / 86400)
	local var3 = math.floor(v1 % 86400 / 3600)
	local var4 = math.floor(v1 % 3600 / 60)
	local var5 = math.floor(v1 % 60)
	if v2 > 0 then
		return ("%dd %dh %dm %ds"):format(v2, var3, var4, var5)
	elseif var3 > 0 then
		return ("%dh %dm %ds"):format(var3, var4, var5)
	elseif var4 > 0 then
		return ("%dm %ds"):format(var4, var5)
	else
		return ("%ds"):format(var5)
	end
end
return t
