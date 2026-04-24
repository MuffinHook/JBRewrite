-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local LIST_BREED = require(ReplicatedStorage.Game.Dog.DogConsts).LIST_BREED
local v1 = Util.MakeFuzzyFinder(LIST_BREED)
local t = {
	Transform = function(p1)
		return v1(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid breeds with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("dogbreed", t)
end
