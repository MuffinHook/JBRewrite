return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setLastDiedAt = function(arg1, arg2) -- Line 5, Named "setLastDiedAt"
        assert(arg2.lastDiedAt, "missing lastDiedAt")
        return arg2.lastDiedAt
    end;
})