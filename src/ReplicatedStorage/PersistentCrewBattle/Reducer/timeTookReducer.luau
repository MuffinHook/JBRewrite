return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setTimeTook = function(arg1, arg2) -- Line 5, Named "setTimeTook"
        local var2
        if arg2.clanId == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing clanId")
        var2 = arg1
        local clone = table.clone(var2)
        var2 = arg2.clanId
        clone[var2] = arg2.value
        return clone
    end;
})