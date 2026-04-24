-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	GAME_MODE_START_PART_TAG_NAME = "GameModeStartPart",
	GAME_MODE_NAME_ATTR_NAME = "GameModeName",
	GAME_MODE_TAG_NAME = "GameMode",
	GAME_MODE_WINNER_REMOTE_NAME = "GameModeWinner"
})
