local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassData_upvr = require(ReplicatedStorage.Gamepass.GamepassData)
local tbl = {}
for _, v in ipairs(GamepassData_upvr) do
    table.insert(tbl, v.Title)
end
local module_upvr = {
    ListGamepassTitle = tbl;
    EnumGamepass = require(ReplicatedStorage.Std.Enumer)(tbl);
    GIFT_REMOTE_NAME = "GiftGamepassRemote";
    GAME_PASS_GIFT_DATASTORE_KEY = "GamePassGiftData";
    PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME = "AllowedToAttemptGamePassGift";
    PLAYER_GAME_PASS_GIFT_ATTEMPT_RECEIVER_USER_ID_ATTR_NAME = "GamePassGiftReceiverUserId";
}
function module_upvr.Init(arg1) -- Line 21
    module_upvr.PromptPurchase = assert(arg1.PromptPurchase)
end
function module_upvr.GetGamepassFromEnum(arg1) -- Line 24
    for _, v_2 in ipairs(GamepassData_upvr) do
        if module_upvr.EnumGamepass[v_2.Title] == arg1 then
            return v_2
        end
    end
end
function module_upvr.PromptGamepass(arg1) -- Line 32
    local any_GetGamepassFromEnum_result1 = module_upvr.GetGamepassFromEnum(arg1)
    assert(any_GetGamepassFromEnum_result1)
    module_upvr.PromptPurchase(any_GetGamepassFromEnum_result1)
end
function module_upvr.GetGamepassFromPassId(arg1) -- Line 37
    for _, v_3 in ipairs(GamepassData_upvr) do
        if v_3.PassId == arg1 then
            return v_3
        end
    end
end
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module_upvr.GetGiftProductInfoFromGamepass(arg1) -- Line 44
    for _, v_4 in ipairs(Settings_upvr.DevProduct) do
        if v_4.Type == "GiftGamepass" and v_4.Name == arg1 then
            return v_4
        end
    end
end
return module_upvr