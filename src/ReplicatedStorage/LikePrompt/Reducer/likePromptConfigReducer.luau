local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({
	visible = false,
	countdownTil = 0
}, {
	setLikePromptConfig = function(p1, p2) --[[ Name: setLikePromptConfig | Line: 8 ]]
		local v1 = table.clone(p1)
		v1.visible = p2.visible
		v1.countdownTil = p2.countdownTil
		return v1
	end
})