local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setNetworkMutexLocked = function(p1, p2) --[[ Name: setNetworkMutexLocked | Line: 8 ]]
		return p2.value
	end
})