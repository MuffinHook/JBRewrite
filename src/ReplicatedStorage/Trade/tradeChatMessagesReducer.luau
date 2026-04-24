-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addTradeChatMessage = function(p1, p2)
		assert(p2.displayName, "No display name")
		assert(p2.text, "No text")
		assert(typeof(p2.me) == "boolean", "No me value passed")
		local v2 = table.clone(p1)
		table.insert(v2, {
			displayName = p2.displayName,
			me = p2.me,
			text = p2.text,
			color = p2.color
		})
		return v2
	end,
	clearTradeChatMessages = function(p1, p2)
		return {}
	end
})
