return require(game:GetService("ReplicatedStorage").Rodux).createReducer({
    visible = false;
    countdownTil = 0;
}, {
    setLikePromptConfig = function(arg1, arg2) -- Line 8, Named "setLikePromptConfig"
        local clone = table.clone(arg1)
        clone.visible = arg2.visible
        clone.countdownTil = arg2.countdownTil
        return clone
    end;
})