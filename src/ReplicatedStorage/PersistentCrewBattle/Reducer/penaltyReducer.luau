return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setPenaltyText = function(arg1, arg2) -- Line 5, Named "setPenaltyText"
        return arg2.value
    end;
})