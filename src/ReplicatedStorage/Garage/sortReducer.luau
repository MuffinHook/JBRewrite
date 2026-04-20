return require(game:GetService("ReplicatedStorage").Rodux).createReducer(require(script.Parent.EnumSort).Popular, {
    setSort = function(arg1, arg2) -- Line 7, Named "setSort"
        local var2
        if arg2.id == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing id")
        return arg2.id
    end;
})