return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setIsBattleServer = function(arg1, arg2) -- Line 5, Named "setIsBattleServer"
        return arg2.value
    end;
})