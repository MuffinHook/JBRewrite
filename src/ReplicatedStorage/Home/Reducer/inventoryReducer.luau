return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setInventory = function(arg1, arg2) -- Line 6, Named "setInventory"
        return arg2.value
    end;
})