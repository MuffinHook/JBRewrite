return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setInPhysical = function(arg1, arg2) -- Line 5, Named "setInPhysical"
        local var2
        if arg2.inPhysical == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing inPhysical value")
        return arg2.inPhysical
    end;
})