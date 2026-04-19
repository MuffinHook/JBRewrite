local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)

local SafeTypeEnum = Enumer({
	"Tier1v1",
	"Tier2v1",
	"Tier3v1",
	"Tier4v1",
	"Tier5v1",
})

local SafeConsts = {}

SafeConsts.SAFE_OPEN_DURATION = 2.5
SafeConsts.FIREWORK_FX_REMOTE_NAME = "SafeFireworksFx"
SafeConsts.SAFE_PURCHASE_REMOTE_NAME = "SafePurchaseRemote"
SafeConsts.SAFE_OPEN_REMOTE_NAME = "SafeOpenRemote"
SafeConsts.UPDATE_SAFES_INVENTORY_REMOTE_NAME = "SafeUpdateInventoryRemote"

SafeConsts.SPINNER_TOTAL_NUM_CARDS = 30
SafeConsts.SPINNER_STOP_INDEX = SafeConsts.SPINNER_TOTAL_NUM_CARDS - 4
SafeConsts.TYPE_ENUM = SafeTypeEnum

SafeConsts.MIN_CASH_REPLACEMENT_VALUE_MULTIPLIER = 0.4
SafeConsts.CASH_REPLACEMENT_MULTIPLIER_DESIRED_MEAN = 0.5
SafeConsts.MAX_POSSIBLE_CASH_REPLACEMENT = 1_000_000

SafeConsts.NEW_PLAYER_SAFE_REWARDS = {
	SafeTypeEnum.Tier1v1,
	SafeTypeEnum.Tier1v1,
	SafeTypeEnum.Tier2v1,
}

SafeConsts.SAFE_REWARD_SPINNER_TOPIC = "SafeOpen"
SafeConsts.PITY_REWARD_MULTIPLIER = 1.25

SafeConsts.SAFE_DATA = {
	[SafeTypeEnum.Tier1v1] = {
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
			[EnumRarity.Legendary] = 0,
		},
		RewardData = {
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Rally Lights",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Drift",
				ItemName = "Bananas",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Tiki Stack of Badimo",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireSticker",
				ItemName = "JungleMosaic",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Bamboo",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Money",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Rally Signage",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Expeditioner",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Texture",
				ItemName = "Prehistoric",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireMesh",
				ItemName = "Safari",
			},
		},
	},

	[SafeTypeEnum.Tier2v1] = {
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
			[EnumRarity.Legendary] = 0,
		},
		RewardData = {
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Spike",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Laviolette",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Sloopwreck Bed",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Captain Chandelier",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Captain Table",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "TreasureIsland",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Settima",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "147",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Dual WingBeat",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Parrot",
			},
		},
	},

	[SafeTypeEnum.Tier3v1] = {
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
			[EnumRarity.Legendary] = 2,
		},
		RewardData = {
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Hammerhead",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireSticker",
				ItemName = "Jade Glow",
			},
			{
				RarityId = EnumRarity.Common,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Wanted Hologram Signage",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Hologram Donut Vendor",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Voltline",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Hex-Bond",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Corp CR1",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Bleeding Edge",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Armorpunk",
			},
			{
				RarityId = EnumRarity.Legendary,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "WYNDR",
			},
		},
	},

	[SafeTypeEnum.Tier4v1] = {
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
			[EnumRarity.Legendary] = 4,
		},
		RewardData = {
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Venom",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "HoldE",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireMesh",
				ItemName = "Studded",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Drift",
				ItemName = "Subspace",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Animated Obby",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Delivery",
			},
			{
				RarityId = EnumRarity.Legendary,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "PizzaDelivery",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Classic Jet",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Spawn",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireSticker",
				ItemName = "SFOTH",
			},
		},
	},

	[SafeTypeEnum.Tier5v1] = {
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
			[EnumRarity.Legendary] = 2,
		},
		RewardData = {
			{
				RarityId = EnumRarity.Legendary,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Bluebird",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
				Make = "Manta",
			},
			{
				RarityId = EnumRarity.Rare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "Aeroblob",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Rim",
				ItemName = "MonsterVoid",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "SuperAttack",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Drift",
				ItemName = "Rainboom",
			},
			{
				RarityId = EnumRarity.Epic,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Spoiler",
				ItemName = "Cassette",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
				ItemName = "Crazy Driver",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "TireMesh",
				ItemName = "ClosedCircuit",
			},
			{
				RarityId = EnumRarity.UltraRare,
				Type = "UniqueItem",
				ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
				CategoryName = "Texture",
				ItemName = "Electronic",
			},
		},
	},
}

for _, safeData in pairs(SafeConsts.SAFE_DATA) do
	local rarityCounts = {}

	for _, rewardData in ipairs(safeData.RewardData) do
		rarityCounts[rewardData.RarityId] = (rarityCounts[rewardData.RarityId] or 0) + 1
	end

	local rarityToAbsoluteProbability = {}
	local totalProbability = 0

	for rarityId, probability in pairs(safeData.RarityProbabilities) do
		assert(probability >= 0 and probability <= 100, "Invalid rarity probability")

		if probability > 0 and not rarityCounts[rarityId] then
			error("No items exist for rarity: " .. tostring(rarityId))
		end

		if rarityCounts[rarityId] and probability == 0 then
			warn("Items of rarity " .. tostring(rarityId) .. " exist but that rarity has 0 probability")
		end

		if rarityCounts[rarityId] then
			rarityToAbsoluteProbability[rarityId] = probability / rarityCounts[rarityId]
			totalProbability += probability
		end
	end

	if math.abs(totalProbability - 100) > 0.0001 then
		error("Invalid total rarity probabilities: " .. tostring(totalProbability) .. ", safeName: " .. safeData.Title)
	end

	for _, rewardData in ipairs(safeData.RewardData) do
		local absoluteProbability = rarityToAbsoluteProbability[rewardData.RarityId]

		if not absoluteProbability then
			error("No probability for rarity: " .. tostring(rewardData.RarityId))
		elseif absoluteProbability == 0 then
			warn("Rarity has 0 probability but a reward with given rarity exists: " .. tostring(rewardData.RarityId))
		end

		rewardData.AbsoluteProbability = absoluteProbability
	end
end

for safeType, _ in pairs(SafeConsts.SAFE_DATA) do
	assert(SafeConsts.SAFE_DATA[safeType], "No safe data for safe " .. tostring(safeType))
end

return TableUtils.requireValidIndexAndFreeze(SafeConsts)