-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setSavedSetting = function(p1, p2)
		if p1[p2.key] == p2.value then
			return p1
		else
			local tbl = table.clone(p1)
			tbl[p2.key] = p2.value
			return tbl
		end
	end
})
