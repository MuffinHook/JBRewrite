return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setGamepassOwned = function(arg1, arg2) -- Line 5, Named "setGamepassOwned"
        local var2
        if typeof(arg2.gamepassEnum) ~= "number" then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "Incorrect gamepassEnum passed")
        if typeof(arg2.gamepassOwned) ~= "boolean" then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "Incorrect gamepassOwned value passed")
        var2 = arg1
        local clone = table.clone(var2)
        var2 = arg2.gamepassEnum
        clone[var2] = arg2.gamepassOwned
        return clone
    end;
})