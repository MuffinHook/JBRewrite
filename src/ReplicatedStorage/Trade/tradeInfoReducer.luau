return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setTradeInfo = function(arg1, arg2) -- Line 5, Named "setTradeInfo"
        return arg2.info
    end;
})