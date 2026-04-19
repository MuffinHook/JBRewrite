local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)

local Constants = {
	AUTO_SAVE_INTERVAL = 30,
	SEMAPHORE_SORTED_MAP_NUM_SHARDS = 20,
	TIMES_TO_RETRY_SEMAPHORE_OPERATION = 60,
	DELAY_BETWEEN_SEMAPHORE_OPERATION_RETRIES = 1,

	VEHICLE_ITEM_TYPE = "Vehicle",
	VEHICLE_CUSTOMIZATION_ITEM_TYPE = "VehicleCustomization",
	HOME_ITEM_TYPE = "HomeItem",
	ITEM_SKIN_ITEM_TYPE = "ItemSkin",
	SAFE_ITEM_TYPE = "Safe",
	CONSUMABLE_ITEM_TYPE = "Consumable",
}

Constants.SEMAPHORE_EXPIRATION_TIME = Constants.AUTO_SAVE_INTERVAL * 2 + 60

Constants.FUNCTION_TYPES = {
	"Defaults",
	Constants.VEHICLE_ITEM_TYPE,
	Constants.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
	Constants.HOME_ITEM_TYPE,
	Constants.ITEM_SKIN_ITEM_TYPE,
	Constants.SAFE_ITEM_TYPE,
	Constants.CONSUMABLE_ITEM_TYPE,
}

Constants.FUNCTION_TYPE_TO_INDEX = {}
for index, functionType in ipairs(Constants.FUNCTION_TYPES) do
	Constants.FUNCTION_TYPE_TO_INDEX[functionType] = index
end

Constants.ITEM_TYPE_SET = {}
for _, functionType in ipairs(Constants.FUNCTION_TYPES) do
	if functionType ~= "Defaults" then
		Constants.ITEM_TYPE_SET[functionType] = true
	end
end

return TableUtils.requireValidIndexAndFreeze(Constants)