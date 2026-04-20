return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setMembersOnlineMap = function(arg1, arg2) -- Line 5, Named "setMembersOnlineMap"
        return arg2.value
    end;
})