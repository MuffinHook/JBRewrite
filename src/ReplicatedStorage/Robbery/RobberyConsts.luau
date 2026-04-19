local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Enumer = require(ReplicatedStorage.Std.Enumer)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)

local robberyDefinitions = {
	{
		key = "BANK",
		name = "Rising City Bank",
		markerName = "Bank",
		imageId = 136495546278020,
	},
	{
		key = "BANK2",
		name = "Crater Bank",
		markerName = "Bank2",
		imageId = 73192489940892,
	},
	{
		key = "JEWELRY",
		name = "Jewelry Store",
		markerName = "Jewelry",
		imageId = 118335970965314,
		frameData = {
			topImageId = 110457092688550,
			cashImageId = 80371007738496,
			color = Color3.fromRGB(133, 211, 241),
		},
	},
	{
		key = "MUSEUM",
		name = "Museum",
		markerName = "Museum",
		imageId = 77293148186745,
		frameData = {
			topImageId = 96419584292722,
			cashImageId = 126600430568145,
			color = Color3.fromRGB(228, 198, 131),
		},
	},
	{
		key = "POWER_PLANT",
		name = "Power Plant",
		markerName = "PowerPlant",
		imageId = 105699516772445,
	},
	{
		key = "TRAIN_PASSENGER",
		name = "Passenger Train",
		markerName = "TrainPassenger",
		imageId = 83454536293678,
	},
	{
		key = "TRAIN_CARGO",
		name = "Cargo Train",
		markerName = "TrainCargo",
		imageId = 76283666439593,
	},
	{
		key = "CARGO_SHIP",
		name = "Cargo Ship",
		markerName = "CargoShip",
		imageId = 136506927209354,
	},
	{
		key = "CARGO_PLANE",
		name = "Cargo Plane",
		markerName = "CargoPlane",
		imageId = 123283496361865,
	},
	{
		key = "STORE_GAS",
		name = "Gas Station",
		markerName = "Gas",
		imageId = 86590402249605,
	},
	{
		key = "STORE_DONUT",
		name = "Donut Store",
		markerName = "Donut",
		imageId = 111833711680255,
	},
	{
		key = "MONEY_TRUCK",
		name = "Money Truck",
		markerName = "MoneyTruck",
		imageId = 124857469875945,
		frameData = {
			alternativeText = "BANK TRUCK",
		},
	},
	{
		key = "HOME_VAULT",
		name = "Home Vault",
		markerName = "HomeVault",
		imageId = 13279595483,
	},
	{
		key = "TOMB",
		name = "Tomb",
		markerName = "Tomb",
		imageId = 75075993183300,
		frameData = {
			topImageId = 110255279458511,
			cashImageId = 97842711725911,
			color = Color3.fromRGB(200, 129, 118),
		},
	},
	{
		key = "CROWN_JEWEL",
		name = "Crown Jewel",
		markerName = "Casino",
		imageId = 90511395098994,
		frameData = {
			topImageId = 119472027123966,
			cashImageId = 100707132869946,
			color = Color3.fromRGB(222, 108, 225),
		},
	},
	{
		key = "MANSION",
		name = "Mansion",
		markerName = "Mansion",
		imageId = 89104385607146,
	},
	{
		key = "OIL_RIG",
		name = "Oil Rig",
		markerName = "OilRig",
		imageId = 93493475540803,
		frameData = {
			topImageId = 91153157851473,
			cashImageId = 81160299342495,
			color = Color3.fromRGB(121, 118, 196),
		},
	},
}

local robberyKeys = {}
for _, robberyData in ipairs(robberyDefinitions) do
	assert(robberyData.key ~= nil, "Missing robbery key")
	assert(robberyData.name ~= nil, "Missing robbery name")
	table.insert(robberyKeys, robberyData.key)
end

local RobberyEnum = Enumer(robberyKeys)

local prettyNamesByEnum = {}
local robberyDataByEnum = {}

for _, robberyData in ipairs(robberyDefinitions) do
	local robberyId = RobberyEnum[robberyData.key]
	prettyNamesByEnum[robberyId] = robberyData.name
	robberyDataByEnum[robberyId] = robberyData
end

return TableUtils.requireValidIndexAndFreeze({
	FOLDER_NAME = "RobberyFolder",
	DATA_ROBBERY = robberyDataByEnum,
	LIST_ROBBERY = robberyKeys,
	ENUM_ROBBERY = RobberyEnum,
	PRETTY_NAME = prettyNamesByEnum,

	STATUS_ATTR_NAME = "RobberyStatus",
	ENUM_STATUS = Enumer({ "OPENED", "STARTED", "CLOSED" }),
	DISABLE_AUTO_OPEN_ATTR_NAME = "RobberyDisableAutoOpen",

	IGNORE_STATUS = {
		RobberyEnum.STORE_GAS,
		RobberyEnum.STORE_DONUT,
		RobberyEnum.HOME_VAULT,
	},

	ROUND_MIN_DURATION = 180,
	ROUND_MAX_DURATION = 420,
	ROBBERY_STARTED_ROUND_PROTECTION_DURATION = 240,
	IN_BETWEEN_ROUND_DURATION = 20,
	NON_BOSS_DELAY = 5,
	OPEN_DELAY = 30,

	KEYCARD_DROP_CHANCE = 0.6,
	CRIME_KEYCARD_DROP_CHANCE = 0.33,

	ROBBERY_STATE_FOLDER_NAME = "RobberyState",
})