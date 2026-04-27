local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
return TableUtils.requireValidIndexAndFreeze({
	CONTRACT_DATA_FOLDER_NAME = "PlayerContracts",
	TEAM_VALUE_NAME = "Team",
	STATE_VALUE_NAME = "State",
	GOAL_VALUE_NAME = "Goal",
	PROGRESS_VALUE_NAME = "Progress",
	REQUIRE_SEASON_PASS_VALUE_NAME = "ReqSeasonPass",
	LAST_STATE_UPDATE_VALUE_NAME = "LastStateUpdate",
	CONTRACT_ACTION_REMOTE_NAME = "Action",
	REROLLED_VALUE_NAME = "Rerolled",
	DEADLINE_VALUE_NAME = "ContractDeadline",
	COOLDOWN_DURATION = 15,
	REFRESH_DURATION = 604800,
	enumState = Enumer({ "ACCEPTABLE", "ACTIVE", "FAILED", "ABORTED", "COMPLETED" }),
	ALLOW_MULTIPLE_ACTIVE = true,
	AUTO_ACCEPT_CONTRACTS = true,
	REROLL_PRICE = 25000
})
