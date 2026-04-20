return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setTradeResult = function(arg1, arg2) -- Line 5, Named "setTradeResult"
        return arg2.value
    end;
})