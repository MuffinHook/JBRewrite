local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(require(ReplicatedStorage.Sale.SaleConsts).CATEGORY_NAME, {
    setCategory = function(arg1, arg2) -- Line 6, Named "setCategory"
        local var3
        if arg2.categoryName == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing category Name")
        return arg2.categoryName
    end;
    setPage = function(arg1, arg2) -- Line 11, Named "setPage"
        if arg2.categoryName then
            return arg2.categoryName
        end
        return arg1
    end;
})