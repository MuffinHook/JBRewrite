-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local GameModeUtils = {
	getGameModeNames = function()
		local modeNames = TableUtils.map(ReplicatedStorage.GameMode.Mode:GetChildren(), function(modeModule)
			return modeModule.Name
		end)
		table.insert(modeNames, "CrewBattle")
		return modeNames
	end,
	getGameModesRunning = function()
		return CollectionService:GetTagged("GameMode")
	end
}
function GameModeUtils.isThisGameModeRunning(gameModeName)
	for _, runningGameMode in GameModeUtils.getGameModesRunning() do
		if runningGameMode.Name == gameModeName then
			return true
		end
	end
	return false
end
return GameModeUtils
