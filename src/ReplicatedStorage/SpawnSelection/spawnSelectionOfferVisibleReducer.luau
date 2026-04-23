local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setSpawnSelectionOfferVisible = function(p1, p2) --[[ Name: setSpawnSelectionOfferVisible | Line: 5 ]]
		return p2.visible
	end
})