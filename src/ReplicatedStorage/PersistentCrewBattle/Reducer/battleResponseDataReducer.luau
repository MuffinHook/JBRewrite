return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setBattleResponseData = function(arg1, arg2) -- Line 5, Named "setBattleResponseData"
        return arg2.value
    end;
})