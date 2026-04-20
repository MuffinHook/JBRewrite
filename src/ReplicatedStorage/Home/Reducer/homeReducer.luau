return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setHome = function(arg1, arg2) -- Line 6, Named "setHome"
        return arg2.value
    end;
})