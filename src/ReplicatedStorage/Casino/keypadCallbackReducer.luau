return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setCasinoKeypadCallback = function(arg1, arg2) -- Line 5, Named "setCasinoKeypadCallback"
        local var2
        if arg2.callback == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing callback")
        return arg2.callback
    end;
})