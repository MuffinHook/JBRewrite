-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	minimapSetSpawns = function(p1, p2)
		local t = {}
		for v1, v2 in p2.spawns do
			assert(v2.name, "missing name")
			if not v2.title then
				v2.title = v2.name
			end
			table.insert(t, v2)
		end
		return t
	end
})
