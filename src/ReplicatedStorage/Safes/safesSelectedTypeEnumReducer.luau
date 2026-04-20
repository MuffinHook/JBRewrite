return require(game:GetService("ReplicatedStorage").Rodux).createReducer(1, {
    setSafesSelectedSafeTypeEnum = function(arg1, arg2) -- Line 5, Named "setSafesSelectedSafeTypeEnum"
        local var2
        if arg2.typeEnum == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing typeEnum")
        return arg2.typeEnum
    end;
})