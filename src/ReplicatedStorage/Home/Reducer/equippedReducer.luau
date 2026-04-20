return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setEquipped = function(arg1, arg2) -- Line 5, Named "setEquipped"
        return arg2.value
    end;
})