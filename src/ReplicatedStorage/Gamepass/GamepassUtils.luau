-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
local GamepassData = require(ReplicatedStorage.Gamepass.GamepassData)
local Settings = require(ReplicatedStorage.Resource.Settings)
local gamepassTitlesList = {}
for i, gamepassEntry in ipairs(GamepassData) do
	table.insert(gamepassTitlesList, gamepassEntry.Title)
end
local module = {
	ListGamepassTitle = gamepassTitlesList,
	EnumGamepass = Enumer(gamepassTitlesList),
	GIFT_REMOTE_NAME = "GiftGamepassRemote",
	GAME_PASS_GIFT_DATASTORE_KEY = "GamePassGiftData",
	PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME = "AllowedToAttemptGamePassGift",
	PLAYER_GAME_PASS_GIFT_ATTEMPT_RECEIVER_USER_ID_ATTR_NAME = "GamePassGiftReceiverUserId"
}
function module.Init(settings)
	module.PromptPurchase = assert(settings.PromptPurchase)
end
function module.GetGamepassFromEnum(enumValue)
	for i, gamepassEntry in ipairs(GamepassData) do
		if module.EnumGamepass[gamepassEntry.Title] == enumValue then
			return gamepassEntry
		end
	end
end
function module.PromptGamepass(enumValue)
	local gamepass = module.GetGamepassFromEnum(enumValue)
	assert(gamepass)
	module.PromptPurchase(gamepass)
end
function module.GetGamepassFromPassId(passId)
	for i, gamepassEntry in ipairs(GamepassData) do
		if gamepassEntry.PassId == passId then
			return gamepassEntry
		end
	end
end
function module.GetGiftProductInfoFromGamepass(gamepassName)
	for i, productEntry in ipairs(Settings.DevProduct) do
		if productEntry.Type == "GiftGamepass" and productEntry.Name == gamepassName then
			return productEntry
		end
	end
end
return module
