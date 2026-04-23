local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	getGameModeNames = function() --[[ Name: getGameModeNames | Line: 6 | Upvalues: TableUtils (copy), ReplicatedStorage (copy) ]]
		local v1 = TableUtils.map(ReplicatedStorage.GameMode.Mode:GetChildren(), function(p1) --[[ Line: 7 ]]
			return p1.Name
		end)
		table.insert(v1, "CrewBattle")
		return v1
	end,
	getGameModesRunning = function() --[[ Name: getGameModesRunning | Line: 14 | Upvalues: CollectionService (copy) ]]
		return CollectionService:GetTagged("GameMode")
	end
}
function t.isThisGameModeRunning(p1) --[[ Line: 17 | Upvalues: t (copy) ]]
	for v1, v2 in t.getGameModesRunning() do
		if v2.Name == p1 then
			return true
		end
	end
	return false
end
return t