-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({
	visible = false,
	countdownTil = 0
}, {
	setLikePromptConfig = function(p1, p2)
		local tbl = table.clone(p1)
		tbl.visible = p2.visible
		tbl.countdownTil = p2.countdownTil
		return tbl
	end
})
