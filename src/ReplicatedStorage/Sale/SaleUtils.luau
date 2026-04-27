local SaleConsts = require(script.Parent.SaleConsts)
local SaleUtils = {
	getNumSalesPassed = function()
		return math.floor((workspace:GetServerTimeNow() - SaleConsts.FIRST_SALE_START_TIMESTAMP) / SaleConsts.SALE_DURATION_SECONDS)
	end
}
function SaleUtils.getNextSaleTime()
	return SaleConsts.FIRST_SALE_START_TIMESTAMP + (SaleUtils.getNumSalesPassed() + 1) * SaleConsts.SALE_DURATION_SECONDS
end
function SaleUtils.getTimeToNextSale()
	return SaleUtils.getNextSaleTime() - workspace:GetServerTimeNow()
end
function SaleUtils.formatRemaining(remainingSeconds)
	local clampedSeconds = math.max(0, remainingSeconds)
	local days = math.floor(clampedSeconds / 86400)
	local hours = math.floor(clampedSeconds % 86400 / 3600)
	local minutes = math.floor(clampedSeconds % 3600 / 60)
	local seconds = math.floor(clampedSeconds % 60)
	if days > 0 then
		return ("%dd %dh %dm %ds"):format(days, hours, minutes, seconds)
	elseif hours > 0 then
		return ("%dh %dm %ds"):format(hours, minutes, seconds)
	elseif minutes > 0 then
		return ("%dm %ds"):format(minutes, seconds)
	else
		return ("%ds"):format(seconds)
	end
end
return SaleUtils
