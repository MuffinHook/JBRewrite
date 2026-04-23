local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local EnumRarity = require(script.Parent.EnumRarity)
local t = {
	{
		id = EnumRarity.Common,
		name = "Common",
		color = Color3.fromRGB(211, 221, 240)
	},
	{
		id = EnumRarity.Rare,
		name = "Rare",
		color = Color3.fromRGB(152, 234, 78)
	},
	{
		id = EnumRarity.UltraRare,
		name = "Ultra Rare",
		color = Color3.fromRGB(0, 127, 255)
	},
	{
		id = EnumRarity.Epic,
		name = "Epic",
		color = Color3.fromRGB(254, 38, 41)
	},
	{
		id = EnumRarity.Legendary,
		name = "Legendary",
		color = Color3.fromRGB(144, 85, 254)
	}
}
local t2 = {}
for v1, v2 in t do
	v2.index = v1
	t2[v2.id] = v2
end
return TableUtils.requireValidIndexAndFreeze({
	COLLECT_REWARD_REMOTE_NAME = "RewardSpinnerCollectReward",
	SPIN_REMOTE_NAME = "RewardSpinnerSpin",
	RARITIES = t,
	RARITY_ID_TO_RARITY = t2
})