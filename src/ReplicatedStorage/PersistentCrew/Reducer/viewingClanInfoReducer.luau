local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setViewingClanInfo = function(arg1, self)
		return self.value
	end
})
