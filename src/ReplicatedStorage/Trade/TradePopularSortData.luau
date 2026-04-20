local module_upvr = {}
function module_upvr.setPopularTradeItemData(arg1) -- Line 3
    module_upvr._popularTradeItemData = arg1
end
function module_upvr.getPopularTradeItemData() -- Line 6
    return module_upvr._popularTradeItemData
end
return module_upvr