return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setViewingClanInfo = function(arg1, arg2) -- Line 5, Named "setViewingClanInfo"
        return arg2.value
    end;
})