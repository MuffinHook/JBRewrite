local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setInventory = function(p1, p2) --[[ Name: setInventory | Line: 6 ]]
		return p2.value
	end
})