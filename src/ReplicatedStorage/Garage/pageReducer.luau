return require(game:GetService("ReplicatedStorage").Rodux).createReducer("Customize", {
    setPage = function(arg1, arg2) -- Line 5, Named "setPage"
        local var2
        if arg2.pageName == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing page Name")
        return arg2.pageName
    end;
})