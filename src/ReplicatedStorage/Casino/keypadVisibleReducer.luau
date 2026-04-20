return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setCasinoKeypadVisible = function(arg1, arg2) -- Line 5, Named "setCasinoKeypadVisible"
        local var2
        if arg2.visible == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing visible")
        return arg2.visible
    end;
})