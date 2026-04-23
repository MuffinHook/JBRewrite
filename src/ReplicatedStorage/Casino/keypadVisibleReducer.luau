local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setCasinoKeypadVisible = function(p1, p2) --[[ Name: setCasinoKeypadVisible | Line: 5 ]]
		assert(p2.visible ~= nil, "missing visible")
		return p2.visible
	end
})