local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setBattleResponseData = function(arg1, self)
		return self.value
	end
})
