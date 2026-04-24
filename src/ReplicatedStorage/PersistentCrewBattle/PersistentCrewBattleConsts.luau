-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
require(ReplicatedStorage.Clan.ClanConsts)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local constant = 60
if RunUtils.getEnv() == RunConsts.QA_NAME then
	constant = 10
elseif RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME then
	constant = 1
end
local t = {
	CURR_CREW_BATTLE_SEASON = 20,
	CREW_BATTLE_SEASON_EXPORT_KEY = "CrewBattleSeasonNum",
	ROUND_ROBBERIES_DONE_ATTR_NAME = "RoundRobberiesDone"
}
t.ROUND_START_COUNTDOWN_TIME = if RunUtils.getEnv() == RunConsts.PROD_NAME then 10 else 1
t.BATTLE_END_COUNTDOWN_LENGTH = 10
t.ROUND_STARTS_AT_ATTR_NAME = "RoundStartsAt"
t.ROUND_MAX_TIME = 600
t.MAX_PLAYERS_PER_TEAM = 5
t.RANKED_BATTLE_TEAM_SIZE = if RunUtils.getEnv() == RunConsts.PROD_NAME then 3 else 1
t.INVITE_TIMEOUT_DURATION = 60
t.MATCHMAKING_TIMEOUT_DURATION = 60
t.RESPONSE_REMOTE_NAME = "BattleResponseRemote"
t.ANNOUNCE_WIN_REMOTE_NAME = "AnnounceWinRemote"
t.ANNOUNCE_PENALTY_REMOTE_NAME = "AnnouncePenaltyRemote"
t.CUSTOM_BATTLE_INVITE_REMOTE_NAME = "CustomBattleInviteRemote"
t.INVITES_FOLDER_NAME = "CrewBattleInvitesFolder"
t.INVITE_CREATED_AT_ATTR_NAME = "InviteCreatedAt"
t.INVITE_OPPOSING_CLAN_NAME_ATTR_NAME = "InviteOpposingClanName"
t.INVITE_NUM_PLAYERS_PER_TEAM_ATTR_NAME = "InviteNumPlayersPerTeam"
t.INVITE_CLAN_DISPLAY_RATING_ATTR_NAME = "InviteBattleDisplayClanRating"
t.INVITE_INTIATOR_USER_ID_ATTR_NAME = "InitiatorUserId"
t.INVITE_RANKED_ATTR_NAME = "InviteRanked"
t.INVITE_OPPOSING_CLAN_OWNER_NAME_ATTR_NAME = "InviteOpposingClanOwnerName"
t.MESSAGING_SERVICE_TOPIC = "CrewBattleInfo"
t.INVITE_MESSAGE_TYPE = "Invite"
t.TELEPORT_MESSAGE_TYPE = "Teleport"
t.BATTLE_REJECTED_MESSAGE_TYPE = "BattleRejected"
t.NUM_PROVISIONAL_RATING_BATTLES = if RunUtils.getEnv() == RunConsts.PROD_NAME then 10 else 1
t.UNACCEPT_BATTLE_INVITE_REMOTE_NAME = "UnacceptBattleInviteRemote"
t.BATTLE_INVITE_COOLDOWN_TIME = constant
t.NUM_ROBBERIES_AVAILABLE = 5
t.NUM_ROBBERIES_TO_FINISH_ROUND = 3
t.CREW_BATTLE_END_REASON_ENUM = Enumer({ "BattleComplete", "WinByDefault" })
t.ALL_CREW_BATTLE_DATA_OBJ_NAME = "AllCrewBattleData"
t.ROUND_START_ATTR_NAME = "RoundStartTime"
t.ROUND_PENALTY_DURATION_ATTR_NAME = "RoundPenaltyDuration"
t.ROUND_TIME_TOOK_ATTR_NAME = "RoundTimeTook"
t.CLAN_NAME_ATTR_NAME = "CrewBattleClanName"
t.PENALTY_FOR_RESET = 60
t.PENALTY_FOR_DEATH = 20
t.PENALTY_FOR_ARREST = 40
t.PENALTY_COOLDOWN = 10
t.ATTACKING_CLAN_ID = "AttackingClanId"
t.REPORT_CLAN_REMOTE_NAME = "ReportClanRemote"
t.CLAN_REPORT_OPTIONS = {
	{
		name = "negativeAttitude",
		title = "Negative Attitude"
	},
	{
		name = "toxicity",
		title = "Toxicity"
	},
	{
		name = "hacking",
		title = "Hacking"
	},
	{
		name = "offensiveName",
		title = "Offensive Name"
	}
}
t.MAX_NUM_ROUNDS = 2
t.MAX_TIME_BEFORE_ROUND_START = 30
t.BATTLE_SERVER_INIT_TIME_ATTR_NAME = "BattleServerInitTime"
t.DISALLOWED_ROBBERY_TO_MIN_NUM_PLAYERS_NEEDED_MAP = {
	[RobberyConsts.ENUM_ROBBERY.STORE_GAS] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.STORE_DONUT] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.HOME_VAULT] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.TRAIN_PASSENGER] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.MONEY_TRUCK] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.MANSION] = (1 / 0),
	[RobberyConsts.ENUM_ROBBERY.MUSEUM] = 2,
	[RobberyConsts.ENUM_ROBBERY.TOMB] = 2
}
t.RATING_PERIOD_LENGTH = 86400
t.LEADERBOARD_INFO_REMOTE_NAME = "LeaderboardInfoRemote"
t.ROBBERIES_COMPLETED_REMOTE_NAME = "PersistentCrewBattleChosenRobberyTypesRemote"
t.UPDATE_BATTLE_RESPONSES_REMOTE_NAME = "BattleInviteOthersAcceptedRemote"
t.CREWS_IN_SERVER_DISPLAY_INFO_REMOTE_NAME = "CrewsInServerDisplayInfoRemote"
t.BATTLE_TELEPORTATION_CHECK_FREQUENCY = 5
t.BATTLE_ACCEPTANCE_CHECK_FREQUENCY = 2.5
t.BATTLE_WIN_CASH_PRIZE = 10000
t.MAX_RATING_DIFF_BEFORE_MATCHMAKING_TAKING_ANYONE = 100
t.MAX_RATING_DIFF_INITIALLY_ALLOWED = 50
t.MATCHMAKING_MAX_TIME_BEFORE_TAKING_ANYONE = 30
t.CREWS_IN_SERVER_DISPLAY_INFO_UPDATE_FREQUENCY = if RunUtils.isStudio() then 30 else 60
t.LEADERBOARD_UPDATE_FREQUENCY = if RunUtils.isStudio() then 5 else 60
t.LEADERBOARD_MAX_NO_BATTLE_TIME_BEFORE_HIDING = 259200
t.LEADERBOARD_DISPLAY_TYPE_ENUM = Enumer({ "Leaderboard", "CrewsInServer" })
t.CREWS_IN_SERVER_DISPLAY_TAG_NAME = "CrewsInServerDisplay"
t.CREW_LEADERBOARD_TAG_NAME = "CrewLeaderboard"
t.UNRENDER_LEADERBOARD_DISPLAY_DISTANCE = 300
t.DEFAULT_RATING = 1500
t.DEFAULT_RATING_DEVIATION = 150
t.DEFAULT_SIGMA_GRINDSET = 0.06
t.NUM_LEADERBOARD_ENTRIES = 100
t.ON_JOIN_KEY_PATTERN_TO_REWARD_MAP = {
	["Season%d+CrewBattleTop1Touch"] = {
		Type = "UniqueItem",
		ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
		CategoryName = "Drift",
		ItemName = "BlueFire"
	},
	["Season%d+EndCrewBattleTop50"] = {
		Type = "UniqueItem",
		ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
		CategoryName = "Drift",
		ItemName = "GradientPixel"
	}
}
return TableUtils.requireValidIndexAndFreeze(t)
