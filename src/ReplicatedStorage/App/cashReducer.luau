return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setCash = function(arg1, arg2) -- Line 5, Named "setCash"
        assert(arg2.cash, "missing cash value")
        return arg2.cash
    end;
})