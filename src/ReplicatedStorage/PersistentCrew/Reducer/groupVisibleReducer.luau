return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    toggleGroupVisible = function(arg1) -- Line 5, Named "toggleGroupVisible"
        return not arg1
    end;
    setGroupVisible = function(arg1, arg2) -- Line 8, Named "setGroupVisible"
        return arg2.value
    end;
})