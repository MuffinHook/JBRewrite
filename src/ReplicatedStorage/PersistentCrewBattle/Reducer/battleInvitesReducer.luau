return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    battleInvitesSet = function(arg1, arg2) -- Line 5, Named "battleInvitesSet"
        local var2
        if arg2.list == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing list")
        return arg2.list
    end;
    battleInvitesRemoveByIndex = function(arg1, arg2) -- Line 9, Named "battleInvitesRemoveByIndex"
        local var3
        if arg2.index == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing index")
        var3 = arg1
        local clone = table.clone(var3)
        var3 = table.remove
        var3(clone, arg2.index)
        return clone
    end;
})