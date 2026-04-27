local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local TradeConstants = {
	OTHER_TRADE_SERVER_LIST_REGION_TAG_NAME = "OtherTradeServerList",
	MAX_TRADE_SERVER_SIZE = Players.MaxPlayers,
	TRADE_SERVER_DATA_UPDATE_INTERVAL = 30,
	MAX_OTHER_TRADE_SERVER_GET_RANGE_REQUESTS = 10,
	OTHER_TRADE_SERVER_GET_RANGE_REQUEST_SIZE = 10,
	OTHER_TRADE_SERVER_DATA_UPDATE_INTERVAL = 30,
	JOIN_OTHER_TRADE_SERVER_REMOTE_NAME = "TradeJoinOtherTradeServer",
	OTHER_TRADE_SERVER_DATA_REMOTE_NAME = "OtherTradeServerData",
	POPULAR_TRADE_ITEM_DATA_UPDATE_INTERVAL = 60,
	POPULAR_TRADE_ITEM_DATA_REMOTE_NAME = "TradePopularTradeItemData",
	UPDATE_OWNED_REMOTE_NAME = "TradeUpdateOwned",
	UPDATE_INVENTORY_PLAYER_REMOTE_NAME = "TradeInventoryUpdatePlayer",
	UPDATE_OFFERING_REMOTE_NAME = "TradeUpdateOffering",
	UPDATE_OFFERING_INFO_REMOTE_NAME = "TradeUpdateOfferingInfo",
	ACCEPT_OFFERING_REMOTE_NAME = "TradeAcceptOffering",
	DECLINE_OFFERING_REMOTE_NAME = "TradeDeclineOffering",
	OFFERING_RESPONSE_COOLDOWN = 5,
	TRADE_EXECUTE_COOLDOWN = 60,
	EXIT_OFFERING_REMOTE_NAME = "TradeExitOffering",
	SEND_TRADE_INITIATION_REMOTE_NAME = "TradeSendInitiation",
	ACCEPT_TRADE_INITIATION_REMOTE_NAME = "TradeAcceptInitiation",
	DECLINE_TRADE_INITIATION_REMOTE_NAME = "TradeDeclineInitiation",
	OFFERING_RESULT_REMOTE_NAME = "TradeOfferingResult",
	ACTIVE_TRADE_OBJ_NAME = "ActiveTrade",
	IS_READY_ATTR_NAME = "TraderIsReady",
	IS_ACCEPTED_ATTR_NAME = "TraderIsAccepted",
	WITH_USER_ID_ATTR_NAME = "TradeWithUserId",
	ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME = "TradingEnabled",
	ARE_TRADE_REQUESTS_ENABLED_REMOTE_NAME = "TradingEnabledRemote",
	INITIATIONS_FOLDER_NAME = "TradeInitiations",
	INITIATION_CREATED_AT_ATTR_NAME = "InitiationCreatedAt",
	MAX_OFFER_ITEMS = 8,
	INITIATION_TIMEOUT = 60,
	VIP_INITIATION_TIMEOUT = 90,
	VIP_INITIATION_COLOR = Color3.fromRGB(255, 215, 0),
	TRADE_WARNING_MESSAGE = "WARNING: You can lose valuable items in trading, make sure you double check trades are balanced before readying up.",
	MIN_PROBABILITY_OF_LOSER_WINNING = 0.13,
	STD_DEVIATION_NOISE_MULTIPLIER = 0.3,
	MIN_VALUE_PER_SIDE_TO_DISABLE_TRADE_BALANCING = 2000000,
	TRADING_VIP_ATTRIBUTE_NAME = "IsTradingVIP",
	MAP_CATEGORY_IGNORE = {
		Engine = true,
		Brakes = true,
		WindowTint = true,
		SuspensionHeight = true,
		Safe = true
	}
}
local function toUnix(dateTable)
	return DateTime.fromUniversalTime(dateTable.year, dateTable.month, dateTable.day, dateTable.hour - -4).UnixTimestamp
end
local tradeUpdateDate = {
	year = 2022,
	month = 6,
	day = 10,
	hour = 20
}
TradeConstants.TRADE_UPDATE_UNIX_TIMESTAMP = DateTime.fromUniversalTime(tradeUpdateDate.year, tradeUpdateDate.month, tradeUpdateDate.day, tradeUpdateDate.hour - -4).UnixTimestamp
return TableUtils.requireValidIndexAndFreeze(TradeConstants)
