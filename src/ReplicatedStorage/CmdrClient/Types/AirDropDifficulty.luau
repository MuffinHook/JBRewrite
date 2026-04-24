-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local TYPE_ENUM_TO_NAME = require(ReplicatedStorage.AirDrop.AirDropConsts).TYPE_ENUM_TO_NAME
local v1 = Util.MakeFuzzyFinder(TYPE_ENUM_TO_NAME)
local t = {
	Transform = function(p1)
		return v1(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid airDropDifficulty with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("airDropDifficulty", t)
end
