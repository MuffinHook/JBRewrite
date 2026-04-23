local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	year = 2023,
	month = 7,
	day = 27,
	hour = 17
}
local UnixTimestamp = DateTime.fromUniversalTime(t.year, t.month, t.day, t.hour - -4).UnixTimestamp
return TableUtils.requireValidIndexAndFreeze({
	FIRST_SALE_START_TIMESTAMP = UnixTimestamp,
	SALE_DURATION_SECONDS = 604800,
	NUM_VEHICLE_CUSTOMIZATIONS = 6,
	VEHICLE_CUSTOMIZATION_PRICE_MULTIPLIER = 0.75,
	NUM_VEHICLES = 1,
	VEHICLE_PRICE_MULTIPLIER = 0.9,
	CATEGORY_NAME = "Featured"
})