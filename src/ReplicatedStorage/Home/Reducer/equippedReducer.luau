local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setEquipped = function(p1, p2) --[[ Name: setEquipped | Line: 5 ]]
		return p2.value
	end
})