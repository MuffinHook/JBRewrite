return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setVisible = function(arg1, arg2) -- Line 5, Named "setVisible"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "action.value must not be nil")
        return arg2.value
    end;
    toggleVisible = function(arg1, arg2) -- Line 9, Named "toggleVisible"
        return not arg1
    end;
})