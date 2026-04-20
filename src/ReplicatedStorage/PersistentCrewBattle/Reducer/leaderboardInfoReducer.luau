return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCrewLeaderboard = function(arg1, arg2) -- Line 5, Named "setCrewLeaderboard"
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