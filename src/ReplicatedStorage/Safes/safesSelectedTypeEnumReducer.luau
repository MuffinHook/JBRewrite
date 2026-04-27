local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(1, {
	setSafesSelectedSafeTypeEnum = function(currentSelectedTypeEnum, action)
		assert(action.typeEnum ~= nil, "missing typeEnum")
		return action.typeEnum
	end
})
