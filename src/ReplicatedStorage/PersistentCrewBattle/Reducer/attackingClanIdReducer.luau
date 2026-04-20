return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setAttackingClanId = function(arg1, arg2) -- Line 5, Named "setAttackingClanId"
        return arg2.value
    end;
})