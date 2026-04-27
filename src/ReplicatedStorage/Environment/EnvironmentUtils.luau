local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
return {
	setTimeOfDay = function(timeOfDay)
		Lighting:SetAttribute(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME, timeOfDay)
		return true
	end,
	getTimeOfDay = function()
		return Lighting:GetAttribute(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME)
	end,
	getTimeOfDayChangedSignal = function()
		return Lighting:GetAttributeChangedSignal(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME)
	end,
	setPrecipitation = function(precipitation)
		Lighting:SetAttribute(EnvironmentConsts.PRECIPITATION_ATTR_NAME, precipitation)
		return true
	end,
	getPrecipitation = function()
		return Lighting:GetAttribute(EnvironmentConsts.PRECIPITATION_ATTR_NAME)
	end,
	getPrecipitationChangedSignal = function()
		return Lighting:GetAttributeChangedSignal(EnvironmentConsts.PRECIPITATION_ATTR_NAME)
	end
}
