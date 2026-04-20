return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addTradeChatMessage = function(arg1, arg2) -- Line 5, Named "addTradeChatMessage"
        assert(arg2.displayName, "No display name")
        local text = arg2.text
        assert(text, "No text")
        if typeof(arg2.me) ~= "boolean" then
            text = false
        else
            text = true
        end
        assert(text, "No me value passed")
        local clone = table.clone(arg1)
        table.insert(clone, {
            displayName = arg2.displayName;
            me = arg2.me;
            text = arg2.text;
            color = arg2.color;
        })
        return clone
    end;
    clearTradeChatMessages = function(arg1, arg2) -- Line 19, Named "clearTradeChatMessages"
        return {}
    end;
})