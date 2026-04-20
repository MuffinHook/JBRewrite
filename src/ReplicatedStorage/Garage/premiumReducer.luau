return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setPremium = function(arg1, arg2) -- Line 5, Named "setPremium"
        local var2
        if arg2.premium == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing premium value")
        return arg2.premium
    end;
})