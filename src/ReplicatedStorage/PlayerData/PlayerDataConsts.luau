local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	AUTO_SAVE_INTERVAL = 30,
	SEMAPHORE_SORTED_MAP_NUM_SHARDS = 20,
	TIMES_TO_RETRY_SEMAPHORE_OPERATION = 60,
	DELAY_BETWEEN_SEMAPHORE_OPERATION_RETRIES = 1,
	VEHICLE_ITEM_TYPE = "Vehicle",
	VEHICLE_CUSTOMIZATION_ITEM_TYPE = "VehicleCustomization",
	HOME_ITEM_ITEM_TYPE = "HomeItem",
	ITEM_SKIN_ITEM_TYPE = "ItemSkin",
	SAFE_ITEM_TYPE = "Safe",
	CONSUMABLE_ITEM_TYPE = "Consumable"
}
t.SEMAPHORE_EXPIRATION_TIME = t.AUTO_SAVE_INTERVAL * 2 + 60
t.FUNCTION_TYPES = {
	"Defaults",
	t.VEHICLE_ITEM_TYPE,
	t.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
	t.HOME_ITEM_ITEM_TYPE,
	t.ITEM_SKIN_ITEM_TYPE,
	t.SAFE_ITEM_TYPE,
	t.CONSUMABLE_ITEM_TYPE
}
t.FUNCTION_TYPE_TO_INDEX = {}
for i, v in ipairs(t.FUNCTION_TYPES) do
	t.FUNCTION_TYPE_TO_INDEX[v] = i
end
t.ITEM_TYPE_SET = {}
for i, v in ipairs(t.FUNCTION_TYPES) do
	if v ~= "Defaults" then
		t.ITEM_TYPE_SET[v] = true
	end
end
return TableUtils.requireValidIndexAndFreeze(t)