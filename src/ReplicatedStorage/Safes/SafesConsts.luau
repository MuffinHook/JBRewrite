-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local v1 = Enumer({ "Tier1v1", "Tier2v1", "Tier3v1", "Tier4v1", "Tier5v1" })
local t = {
	SAFE_OPEN_DURATION = 2.5,
	FIREWORK_FX_REMOTE_NAME = "SafeFireworksFx",
	SAFE_PURCHASE_REMOTE_NAME = "SafePurchaseRemote",
	SAFE_OPEN_REMOTE_NAME = "SafeOpenRemote",
	UPDATE_SAFES_INVENTORY_REMOTE_NAME = "SafeUpdateInventoryRemote",
	SPINNER_TOTAL_NUM_CARDS = 30,
	TYPE_ENUM = v1,
	MIN_CASH_REPLACEMENT_VALUE_MULTIPLIER = 0.4,
	CASH_REPLACEMENT_MULTIPLIER_DESIRED_MEAN = 0.5,
	MAX_POSSIBLE_CASH_REPLACEMENT = 1000000,
	NEW_PLAYER_SAFE_REWARDS = { v1.Tier1v1, v1.Tier1v1, v1.Tier2v1 },
	SAFE_REWARD_SPINNER_TOPIC = "SafeOpen",
	PITY_REWARD_MULTIPLIER = 1.25
}
t.SPINNER_STOP_INDEX = t.SPINNER_TOTAL_NUM_CARDS - 4
t.SAFE_DATA = {
	[v1.Tier1v1] = {
 Title = "Common",
 OnSale = true,
 Price = 6000,
 ImageId = 10313418867,
 PrimaryColor = Color3.fromRGB(211, 221, 240),
 RarityProbabilities = {
 [EnumRarity.Common] = 62,
 [EnumRarity.Rare] = 30,
 [EnumRarity.UltraRare] = 5,
 [EnumRarity.Epic] = 3,
 [EnumRarity.Legendary] = 0
 },
 RewardData = {
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Rally Lights"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Drift",
 ItemName = "Bananas"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Tiki Stack of Badimo"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireSticker",
 ItemName = "JungleMosaic"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Bamboo"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Money"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Rally Signage"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Expeditioner"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Texture",
 ItemName = "Prehistoric"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireMesh",
 ItemName = "Safari"
 }
 }
	},
	[v1.Tier2v1] = {
 Title = "Rare",
 OnSale = true,
 Price = 16000,
 ImageId = 10313419548,
 PrimaryColor = Color3.fromRGB(152, 234, 78),
 RarityProbabilities = {
 [EnumRarity.Common] = 60,
 [EnumRarity.Rare] = 25,
 [EnumRarity.UltraRare] = 10,
 [EnumRarity.Epic] = 5,
 [EnumRarity.Legendary] = 0
 },
 RewardData = {
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Spike"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Laviolette"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Sloopwreck Bed"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Captain Chandelier"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Captain Table"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "TreasureIsland"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Settima"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "147"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Dual WingBeat"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Parrot"
 }
 }
	},
	[v1.Tier3v1] = {
 Title = "Ultra Rare",
 OnSale = true,
 Price = 37500,
 ImageId = 10313420284,
 PrimaryColor = Color3.fromRGB(0, 127, 255),
 RarityProbabilities = {
 [EnumRarity.Common] = 43,
 [EnumRarity.Rare] = 25,
 [EnumRarity.UltraRare] = 20,
 [EnumRarity.Epic] = 10,
 [EnumRarity.Legendary] = 2
 },
 RewardData = {
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Hammerhead"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireSticker",
 ItemName = "Jade Glow"
 },
 {
 RarityId = EnumRarity.Common,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Wanted Hologram Signage"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Hologram Donut Vendor"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Voltline"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Hex-Bond"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Corp CR1"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Bleeding Edge"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Armorpunk"
 },
 {
 RarityId = EnumRarity.Legendary,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "WYNDR"
 }
 }
	},
	[v1.Tier4v1] = {
 Title = "Epic",
 OnSale = true,
 Price = 75000,
 ImageId = 10313420675,
 PrimaryColor = Color3.fromRGB(254, 38, 41),
 RarityProbabilities = {
 [EnumRarity.Common] = 0,
 [EnumRarity.Rare] = 41,
 [EnumRarity.UltraRare] = 30,
 [EnumRarity.Epic] = 25,
 [EnumRarity.Legendary] = 4
 },
 RewardData = {
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Venom"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "HoldE"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireMesh",
 ItemName = "Studded"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Drift",
 ItemName = "Subspace"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Animated Obby"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Delivery"
 },
 {
 RarityId = EnumRarity.Legendary,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "PizzaDelivery"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Classic Jet"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Spawn"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireSticker",
 ItemName = "SFOTH"
 }
 }
	},
	[v1.Tier5v1] = {
 Title = "Legendary",
 OnSale = true,
 Price = 100000,
 ImageId = 10313423265,
 PrimaryColor = Color3.fromRGB(144, 85, 254),
 RarityProbabilities = {
 [EnumRarity.Common] = 0,
 [EnumRarity.Rare] = 40,
 [EnumRarity.UltraRare] = 30,
 [EnumRarity.Epic] = 28,
 [EnumRarity.Legendary] = 2
 },
 RewardData = {
 {
 RarityId = EnumRarity.Legendary,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Bluebird"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
 Make = "Manta"
 },
 {
 RarityId = EnumRarity.Rare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "Aeroblob"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Rim",
 ItemName = "MonsterVoid"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "SuperAttack"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Drift",
 ItemName = "Rainboom"
 },
 {
 RarityId = EnumRarity.Epic,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Spoiler",
 ItemName = "Cassette"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
 ItemName = "Crazy Driver"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "TireMesh",
 ItemName = "ClosedCircuit"
 },
 {
 RarityId = EnumRarity.UltraRare,
 Type = "UniqueItem",
 ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
 CategoryName = "Texture",
 ItemName = "Electronic"
 }
 }
	}
}
for v2, v3 in t.SAFE_DATA do
	local t2 = {}
	for v4, v5 in v3.RewardData do
 if not t2[v5.RarityId] then
 t2[v5.RarityId] = 0
 end
 local RarityId = v5.RarityId
 t2[RarityId] = t2[RarityId] + 1
	end
	local t3 = {}
	local sum = 0
	for v7, v8 in v3.RarityProbabilities do
 local v6
 v6 = if v8 >= 0 then v8 <= 100 else false
 assert(v6, "Invalid rarity probability")
 if v8 ~= 0 and not t2[v7] then
 error("No items of rarity exist: " .. v7)
 end
 if t2[v7] and v8 == 0 then
 warn("Items of rarity " .. v7 .. " exist but that rarity has 0 probability")
 end
 if t2[v7] then
 t3[v7] = v8 / t2[v7]
 sum = sum + v8
 end
	end
	if math.abs(sum - 100) > 0.0001 then
 error("Invalid total rarity probabilities: " .. sum .. ", safeName: " .. v3.Title)
	end
	for v9, v10 in v3.RewardData do
 local var11 = t3[v10.RarityId]
 local RarityId = v10.RarityId
 if var11 then
 if var11 == 0 then
 warn("Rarity has 0 probability but a reward with given rarity exists: " .. RarityId)
 end
 else
 error("No probability for rarity: " .. RarityId)
 end
 v10.AbsoluteProbability = var11
	end
end
for v12, v13 in v1:GetEnumItems() do
	assert(t.SAFE_DATA[v1[v13]], "No safe data for safe " .. v13)
end
return TableUtils.requireValidIndexAndFreeze(t)