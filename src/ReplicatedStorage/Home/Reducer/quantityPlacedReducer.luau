return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setQuantityPlaced = function(arg1, arg2) -- Line 6, Named "setQuantityPlaced"
        return arg2.value
    end;
})