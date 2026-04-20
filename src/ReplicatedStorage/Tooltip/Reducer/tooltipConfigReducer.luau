return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setTooltipText = function(arg1, arg2) -- Line 6, Named "setTooltipText"
        local var3 = arg1
        if not var3 then
            var3 = {}
        end
        local clone = table.clone(var3)
        clone.text = arg2.value
        return clone
    end;
    setTooltipVisible = function(arg1, arg2) -- Line 13, Named "setTooltipVisible"
        local var5 = arg1
        if not var5 then
            var5 = {}
        end
        local clone_2 = table.clone(var5)
        clone_2.visible = arg2.value
        return clone_2
    end;
})