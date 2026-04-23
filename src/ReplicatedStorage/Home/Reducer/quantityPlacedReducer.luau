local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setQuantityPlaced = function(p1, p2) --[[ Name: setQuantityPlaced | Line: 6 ]]
		return p2.value
	end
})