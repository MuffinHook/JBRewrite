-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("Customize", {
	setPage = function(p1, p2)
		assert(p2.pageName ~= nil, "missing page Name")
		return p2.pageName
	end
})
