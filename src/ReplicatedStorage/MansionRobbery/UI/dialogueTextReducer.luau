return require(game:GetService("ReplicatedStorage").Rodux).createReducer("", {
    setDialogueText = function(arg1, arg2) -- Line 5, Named "setDialogueText"
        local var2
        if arg2.text == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing dialogue text")
        return arg2.text
    end;
})