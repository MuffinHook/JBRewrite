local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local LIST_BREED = require(ReplicatedStorage.Game.Dog.DogConsts).LIST_BREED
local v1 = Util.MakeFuzzyFinder(LIST_BREED)
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 10 | Upvalues: v1 (copy) ]]
		return v1(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 14 ]]
		return #p1 > 0, "No valid breeds with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 18 ]]
		return p1
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 22 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 27 | Upvalues: t (copy) ]]
	p1:RegisterType("dogbreed", t)
end