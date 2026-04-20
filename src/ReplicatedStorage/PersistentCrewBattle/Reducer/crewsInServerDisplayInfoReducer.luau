return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCrewsInServerDisplayInfo = function(arg1, arg2) -- Line 5, Named "setCrewsInServerDisplayInfo"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing value")
        return arg2.value
    end;
})