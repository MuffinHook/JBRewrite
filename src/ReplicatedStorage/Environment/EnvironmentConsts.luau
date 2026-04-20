local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    TIME_OF_DAY_ATTR_NAME = "TimeOfDay";
    TIME_OF_DAY_ENUM = Enumer({"Day", "Night"});
    PRECIPITATION_ATTR_NAME = "Precipitation";
    PRECIPITATION_ENUM = Enumer({"Rain", "None"});
    SNOW = false;
})