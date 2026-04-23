local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
return {
	setTimeOfDay = function(p1) --[[ Name: setTimeOfDay | Line: 7 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		Lighting:SetAttribute(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME, p1)
		return true
	end,
	getTimeOfDay = function() --[[ Name: getTimeOfDay | Line: 11 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		return Lighting:GetAttribute(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME)
	end,
	getTimeOfDayChangedSignal = function() --[[ Name: getTimeOfDayChangedSignal | Line: 14 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		return Lighting:GetAttributeChangedSignal(EnvironmentConsts.TIME_OF_DAY_ATTR_NAME)
	end,
	setPrecipitation = function(p1) --[[ Name: setPrecipitation | Line: 17 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		Lighting:SetAttribute(EnvironmentConsts.PRECIPITATION_ATTR_NAME, p1)
		return true
	end,
	getPrecipitation = function() --[[ Name: getPrecipitation | Line: 21 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		return Lighting:GetAttribute(EnvironmentConsts.PRECIPITATION_ATTR_NAME)
	end,
	getPrecipitationChangedSignal = function() --[[ Name: getPrecipitationChangedSignal | Line: 24 | Upvalues: Lighting (copy), EnvironmentConsts (copy) ]]
		return Lighting:GetAttributeChangedSignal(EnvironmentConsts.PRECIPITATION_ATTR_NAME)
	end
}