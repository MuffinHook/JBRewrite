-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
local GamepassData = require(ReplicatedStorage.Gamepass.GamepassData)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {}
for i, v in ipairs(GamepassData) do
	table.insert(t, v.Title)
end
local t2 = {
	ListGamepassTitle = t,
	EnumGamepass = Enumer(t),
	GIFT_REMOTE_NAME = "GiftGamepassRemote",
	GAME_PASS_GIFT_DATASTORE_KEY = "GamePassGiftData",
	PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME = "AllowedToAttemptGamePassGift",
	PLAYER_GAME_PASS_GIFT_ATTEMPT_RECEIVER_USER_ID_ATTR_NAME = "GamePassGiftReceiverUserId"
}
function t2.Init(p1)
	t2.PromptPurchase = assert(p1.PromptPurchase)
end
function t2.GetGamepassFromEnum(p1)
	for i, v in ipairs(GamepassData) do
		if t2.EnumGamepass[v.Title] == p1 then
			return v
		end
	end
end
function t2.PromptGamepass(p1)
	local v1 = t2.GetGamepassFromEnum(p1)
	assert(v1)
	t2.PromptPurchase(v1)
end
function t2.GetGamepassFromPassId(p1)
	for i, v in ipairs(GamepassData) do
		if v.PassId == p1 then
			return v
		end
	end
end
function t2.GetGiftProductInfoFromGamepass(p1)
	for i, v in ipairs(Settings.DevProduct) do
		if v.Type == "GiftGamepass" and v.Name == p1 then
			return v
		end
	end
end
return t2
