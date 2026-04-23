local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	toggleGroupVisible = function(p1) --[[ Name: toggleGroupVisible | Line: 5 ]]
		return not p1
	end,
	setGroupVisible = function(p1, p2) --[[ Name: setGroupVisible | Line: 8 ]]
		return p2.value
	end
})