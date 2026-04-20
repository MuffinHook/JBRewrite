return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setSpawnSelectionReceivedAt = function(arg1, arg2) -- Line 5, Named "setSpawnSelectionReceivedAt"
        assert(arg2.receivedAt, "missing receivedAt")
        return arg2.receivedAt
    end;
})