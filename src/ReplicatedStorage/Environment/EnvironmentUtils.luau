local Lighting_upvr = game:GetService("Lighting")
local EnvironmentConsts_upvr = require(game:GetService("ReplicatedStorage").Environment.EnvironmentConsts)
return {
    setTimeOfDay = function(arg1) -- Line 7, Named "setTimeOfDay"
        Lighting_upvr:SetAttribute(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME, arg1)
        return true
    end;
    getTimeOfDay = function() -- Line 11, Named "getTimeOfDay"
        return Lighting_upvr:GetAttribute(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME)
    end;
    getTimeOfDayChangedSignal = function() -- Line 14, Named "getTimeOfDayChangedSignal"
        return Lighting_upvr:GetAttributeChangedSignal(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME)
    end;
    setPrecipitation = function(arg1) -- Line 17, Named "setPrecipitation"
        Lighting_upvr:SetAttribute(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME, arg1)
        return true
    end;
    getPrecipitation = function() -- Line 21, Named "getPrecipitation"
        return Lighting_upvr:GetAttribute(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME)
    end;
    getPrecipitationChangedSignal = function() -- Line 24, Named "getPrecipitationChangedSignal"
        return Lighting_upvr:GetAttributeChangedSignal(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME)
    end;
}