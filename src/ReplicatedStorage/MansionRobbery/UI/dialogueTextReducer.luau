local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("", {
	setDialogueText = function(p1, p2) --[[ Name: setDialogueText | Line: 5 ]]
		assert(p2.text ~= nil, "missing dialogue text")
		return p2.text
	end
})