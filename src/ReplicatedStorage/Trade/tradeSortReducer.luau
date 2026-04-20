local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(require(ReplicatedStorage.Garage.EnumSort).Newest, {
    setTradeSortId = function(arg1, arg2) -- Line 7, Named "setTradeSortId"
        local var3
        if arg2.sortId == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing sortId")
        return arg2.sortId
    end;
})