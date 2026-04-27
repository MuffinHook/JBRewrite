local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setNetworkMutexLocked = function(arg1, self)
		return self.value
	end
})
