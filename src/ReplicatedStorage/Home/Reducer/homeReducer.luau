local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setHome = function(p1, p2) --[[ Name: setHome | Line: 6 ]]
		return p2.value
	end
})