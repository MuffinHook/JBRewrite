local EnumRarity = require(script.Parent.EnumRarity)
local tbl = {}
local tbl_2 = {
    id = EnumRarity.Common;
    name = "Common";
    color = Color3.fromRGB(211, 221, 240);
}
tbl[1] = tbl_2
tbl[2] = {
    id = EnumRarity.Rare;
    name = "Rare";
    color = Color3.fromRGB(152, 234, 78);
}
tbl[3] = {
    id = EnumRarity.UltraRare;
    name = "Ultra Rare";
    color = Color3.fromRGB(0, 127, 255);
}
tbl[4] = {
    id = EnumRarity.Epic;
    name = "Epic";
    color = Color3.fromRGB(254, 38, 41);
}
tbl[5] = {
    id = EnumRarity.Legendary;
    name = "Legendary";
    color = Color3.fromRGB(144, 85, 254);
}
tbl_2 = {}
local var12 = tbl_2
for i, v in tbl do
    v.index = i
    var12[v.id] = v
end
return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    COLLECT_REWARD_REMOTE_NAME = "RewardSpinnerCollectReward";
    SPIN_REMOTE_NAME = "RewardSpinnerSpin";
    RARITIES = tbl;
    RARITY_ID_TO_RARITY = var12;
})