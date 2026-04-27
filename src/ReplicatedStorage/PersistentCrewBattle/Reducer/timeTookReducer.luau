local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setTimeTook = function(state, self)
		assert(self.clanId ~= nil, "missing clanId")
		local updatedState = table.clone(state)
		updatedState[self.clanId] = self.value
		return updatedState
	end
})
