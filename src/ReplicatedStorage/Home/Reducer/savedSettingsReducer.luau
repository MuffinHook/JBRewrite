return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setSavedSetting = function(arg1, arg2) -- Line 6, Named "setSavedSetting"
        if arg1[arg2.key] == arg2.value then
            return arg1
        end
        local clone = table.clone(arg1)
        clone[arg2.key] = arg2.value
        return clone
    end;
})