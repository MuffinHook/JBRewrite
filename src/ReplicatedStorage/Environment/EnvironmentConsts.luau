local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.App.RunUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
return TableUtils.requireValidIndexAndFreeze({
	TIME_OF_DAY_ATTR_NAME = "TimeOfDay",
	TIME_OF_DAY_ENUM = Enumer({ "Day", "Night" }),
	PRECIPITATION_ATTR_NAME = "Precipitation",
	PRECIPITATION_ENUM = Enumer({ "Rain", "None" }),
	SNOW = false
})
