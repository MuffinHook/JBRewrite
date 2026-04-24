-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	minimapSetSpawns = function(state, action)
		local result = {}
		for index, spawn in action.spawns do
			assert(spawn.name, "missing name")
			if not spawn.title then
				spawn.title = spawn.name
			end
			table.insert(result, spawn)
		end
		return result
	end
})
