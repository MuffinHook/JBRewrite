return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setCurrentClanInfo = function(arg1, arg2) -- Line 5, Named "setCurrentClanInfo"
        return arg2.value
    end;
})