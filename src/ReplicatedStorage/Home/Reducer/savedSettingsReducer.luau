-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setSavedSetting = function(p1, p2)
		if p1[p2.key] == p2.value then
			return p1
		else
			local v1 = table.clone(p1)
			v1[p2.key] = p2.value
			return v1
		end
	end
})
