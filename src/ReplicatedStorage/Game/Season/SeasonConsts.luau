local TableUtils = require(game:GetService("ReplicatedStorage").Std.TableUtils)
local tbl_2 = {
    year = 2026;
    month = 4;
    day = 20;
    hour = 24;
}
local UnixTimestamp = DateTime.fromUniversalTime(tbl_2.year, tbl_2.month, tbl_2.day, tbl_2.hour - -5).UnixTimestamp
local tbl_3 = {1175277983, 1175278017, 1175278044}
local tbl = {}
for i = 1, #tbl_3 do
    tbl[tbl_3[i]] = i
end
return TableUtils.requireValidIndexAndFreeze({
    SEASON_NUM = 31;
    SEASON_TITLE = "FREESTYLE!";
    SEASON_END_UNIX = UnixTimestamp;
    BUY_END_UNIX = UnixTimestamp;
    AUTOMATE_SEASON_XP_MULT = true;
    SEASON_XP_MULT_START_UNIX = UnixTimestamp - 432000;
    SEASON_XP_MULT = 2;
    SEASON_BONUS_ENABLED = true;
    NUM_BONUS_AWARDS = 1;
    CONTRACT_SEASON_EXPORT_KEY = "ContractSeasonNum";
    HAS_SEASON_PASS_VALUE_NAME = "HasSeasonPass";
    HAS_SEEN_REWARDS_VALUE_NAME = "HasSeenRewards";
    OPENED_SEASON_REMOTE_NAME = "OpenedSeason";
    REDEEM_REMOTE_NAME = "SeasonRedeemAward";
    LEVELS_AWARDED_VALUE_NAME = "LevelsAwarded";
    PRIZE_PURCHASE_REMOTE_NAME = "PrizePurchase";
    PRIZE_BUY_TIER = {};
    PRIZE_PRODUCT_ID_TIER = tbl;
    PRIZE_TIER_PRODUCT_ID = TableUtils.requireValidIndexAndFreeze(tbl_3);
    SEASON_SUBTITLE = "Level up to win exclusive prizes!";
    BUY_SUBTITLE = "Season end: you may purchase the remaining items.";
    POST_SUBTITLE = "Thanks for playing! The next season is coming soon.";
    MAX_REWARD_LEVEL = 10;
    SEASON_PASS_GIFT_DATASTORE_KEY = "SeasonPassGiftData";
    SEASON_PASS_GIFT_ATTEMPT_REMOTE_NAME = "AttemptingSeasonPassGift";
    PLAYER_SEASON_PASS_GIFT_VALUES_FOLDER_NAME = "SeasonPassGiftValues";
    PLAYER_ALLOWED_TO_ATTEMPT_SEASON_PASS_GIFT_FLAG_NAME = "AllowedToAttemptSeasonPassGift";
    PLAYER_SEASON_PASS_GIFT_ATTEMPT_RECEIVER_USER_ID_VALUE_NAME = "SeasonPassGiftReceiverUserId";
})