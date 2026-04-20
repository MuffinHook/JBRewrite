return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setJoinRequests = function(arg1, arg2) -- Line 5, Named "setJoinRequests"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "join requests cannot be nil; try blank table?")
        return arg2.value
    end;
})