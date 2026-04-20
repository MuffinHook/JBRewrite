local module_upvr = {
    getRowRatio = function(arg1) -- Line 3, Named "getRowRatio"
        local var2 = arg1.verticalPaddingRatio * arg1.aspectRatio
        return 1 / ((1) / (arg1.aspectRatio * arg1.rowsPerPage) - 1 / var2 - (1) / (var2 * arg1.rowsPerPage))
    end;
}
function module_upvr.getColRatio(arg1, arg2) -- Line 7
    local var3 = arg1.verticalPaddingRatio * arg1.aspectRatio
    local var4 = arg2
    if not var4 then
        var4 = module_upvr
        var4 = var4.getRowRatio(arg1)
    end
    local var5 = var4
    return var5 / arg1.colsPerRow - var5 / var3 - var5 / var3 / arg1.colsPerRow
end
function module_upvr.getScaleX(arg1) -- Line 12
    local var6 = arg1.verticalPaddingRatio * arg1.aspectRatio
    return 1 / arg1.colsPerRow - 1 / var6 - 1 / var6 / arg1.colsPerRow
end
return module_upvr