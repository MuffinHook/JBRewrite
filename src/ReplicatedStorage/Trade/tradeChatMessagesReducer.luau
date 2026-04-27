local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addTradeChatMessage = function(state, action)
		assert(action.displayName, "No display name")
		assert(action.text, "No text")
		assert(typeof(action.me) == "boolean", "No me value passed")
		local newMessages = table.clone(state)
		table.insert(newMessages, {
			displayName = action.displayName,
			me = action.me,
			text = action.text,
			color = action.color
		})
		return newMessages
	end,
	clearTradeChatMessages = function(state, action)
		return {}
	end
})
