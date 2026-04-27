local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local SafeType = Enumer({ "Tier1v1", "Tier2v1", "Tier3v1", "Tier4v1", "Tier5v1" })
local constants = {
	SAFE_OPEN_DURATION = 2.5,
	FIREWORK_FX_REMOTE_NAME = "SafeFireworksFx",
	SAFE_PURCHASE_REMOTE_NAME = "SafePurchaseRemote",
	SAFE_OPEN_REMOTE_NAME = "SafeOpenRemote",
	UPDATE_SAFES_INVENTORY_REMOTE_NAME = "SafeUpdateInventoryRemote",
	SPINNER_TOTAL_NUM_CARDS = 30,
	TYPE_ENUM = SafeType,
	MIN_CASH_REPLACEMENT_VALUE_MULTIPLIER = 0.4,
	CASH_REPLACEMENT_MULTIPLIER_DESIRED_MEAN = 0.5,
	MAX_POSSIBLE_CASH_REPLACEMENT = 1000000,
	NEW_PLAYER_SAFE_REWARDS = { SafeType.Tier1v1, SafeType.Tier1v1, SafeType.Tier2v1 },
	SAFE_REWARD_SPINNER_TOPIC = "SafeOpen",
	PITY_REWARD_MULTIPLIER = 1.25
}
constants.SPINNER_STOP_INDEX = constants.SPINNER_TOTAL_NUM_CARDS - 4
constants.SAFE_DATA = {
	[SafeType.Tier1v1] = {
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
	[SafeType.Tier2v1] = {
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
	[SafeType.Tier3v1] = {
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
	[SafeType.Tier4v1] = {
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
	[SafeType.Tier5v1] = {
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
for safeType, safeData in constants.SAFE_DATA do
	local rarityItemCounts = {}
	for rewardIndex, rewardItem in safeData.RewardData do
 if not rarityItemCounts[rewardItem.RarityId] then
 rarityItemCounts[rewardItem.RarityId] = 0
 end
 local RarityId = rewardItem.RarityId
 rarityItemCounts[RarityId] = rarityItemCounts[RarityId] + 1
	end
	local rarityProbabilityPerItem = {}
	local sum = 0
	for rarityType, rarityProbability in safeData.RarityProbabilities do
 local isValidProbability
 isValidProbability = if rarityProbability >= 0 then rarityProbability <= 100 else false
 assert(isValidProbability, "Invalid rarity probability")
 if rarityProbability ~= 0 and not rarityItemCounts[rarityType] then
 error("No items of rarity exist: " .. rarityType)
 end
 if rarityItemCounts[rarityType] and rarityProbability == 0 then
 warn("Items of rarity " .. rarityType .. " exist but that rarity has 0 probability")
 end
 if rarityItemCounts[rarityType] then
 rarityProbabilityPerItem[rarityType] = rarityProbability / rarityItemCounts[rarityType]
 sum = sum + rarityProbability
 end
	end
	if math.abs(sum - 100) > 0.0001 then
 error("Invalid total rarity probabilities: " .. sum .. ", safeName: " .. safeData.Title)
	end
	for rewardIndex, rewardItem in safeData.RewardData do
 local itemRarityProbability = rarityProbabilityPerItem[rewardItem.RarityId]
 local RarityId = rewardItem.RarityId
 if itemRarityProbability then
 if itemRarityProbability == 0 then
 warn("Rarity has 0 probability but a reward with given rarity exists: " .. RarityId)
 end
 else
 error("No probability for rarity: " .. RarityId)
 end
 rewardItem.AbsoluteProbability = itemRarityProbability
	end
end
for enumIndex, safeTierName in SafeType:GetEnumItems() do
	assert(constants.SAFE_DATA[SafeType[safeTierName]], "No safe data for safe " .. safeTierName)
end
return TableUtils.requireValidIndexAndFreeze(constants)
