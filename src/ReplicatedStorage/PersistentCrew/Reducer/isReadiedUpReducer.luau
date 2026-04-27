local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setIsReadiedUp = function(arg1, self)
		assert(self.value ~= nil, "isReadiedUp cannot be nil; try boolean")
		return self.value
	end
})
