local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("Customize", {
	setPage = function(state, action)
		assert(action.pageName ~= nil, "missing page Name")
		return action.pageName
	end
})
