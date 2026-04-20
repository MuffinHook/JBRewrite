return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setNetworkMutexLocked = function(arg1, arg2) -- Line 8, Named "setNetworkMutexLocked"
        return arg2.value
    end;
})