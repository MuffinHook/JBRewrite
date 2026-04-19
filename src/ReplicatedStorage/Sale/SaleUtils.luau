local SaleConsts_upvr = require(script.Parent.SaleConsts)
local module_upvr = {
    getNumSalesPassed = function() -- Line 3, Named "getNumSalesPassed"
        --[[ Upvalues[1]:
            [1]: SaleConsts_upvr (readonly)
        ]]
        return math.floor((workspace:GetServerTimeNow() - SaleConsts_upvr.FIRST_SALE_START_TIMESTAMP) / SaleConsts_upvr.SALE_DURATION_SECONDS)
    end;
}
function module_upvr.getNextSaleTime() -- Line 7
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: SaleConsts_upvr (readonly)
    ]]
    return SaleConsts_upvr.FIRST_SALE_START_TIMESTAMP + (module_upvr.getNumSalesPassed() + 1) * SaleConsts_upvr.SALE_DURATION_SECONDS
end
function module_upvr.getTimeToNextSale() -- Line 13
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr.getNextSaleTime() - workspace:GetServerTimeNow()
end
function module_upvr.formatRemaining(arg1) -- Line 18
    local maximum = math.max(0, arg1)
    local floored = math.floor(maximum / 86400)
    local floored_3 = math.floor(maximum % 86400 / 3600)
    local floored_2 = math.floor(maximum % 3600 / 60)
	local floored_4 = math.floor(maximum % 60)
	
    if 0 < floored then
        return string.format("%dd %dh %dm %ds", floored, floored_3, floored_2, floored_4)
	end
	
    if 0 < floored_3 then
        return string.format("%dh %dm %ds", floored_3, floored_2, floored_4)
	end
	
    if 0 < floored_2 then
        return string.format("%dm %ds", floored_2, floored_4)
    end
    return string.format("%ds", floored_4)
end
return module_upvr