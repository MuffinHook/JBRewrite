return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setOtherTradeServerInfo = function(arg1, arg2) -- Line 5, Named "setOtherTradeServerInfo"
        local clone_2 = table.clone(arg1)
        clone_2.otherTradeServerInfo = arg2.value
        return clone_2
    end;
    setOtherTradeServerListVisible = function(arg1, arg2) -- Line 10, Named "setOtherTradeServerListVisible"
        local clone = table.clone(arg1)
        clone.visible = arg2.value
        return clone
    end;
})