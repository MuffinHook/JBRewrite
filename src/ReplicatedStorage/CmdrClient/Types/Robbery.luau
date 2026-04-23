local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local LIST_ROBBERY = require(ReplicatedStorage.Robbery.RobberyConsts).LIST_ROBBERY
local v1 = Util.MakeFuzzyFinder(LIST_ROBBERY)
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 11 | Upvalues: v1 (copy) ]]
		return v1(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 15 ]]
		return #p1 > 0, "No valid robbery with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 19 ]]
		return p1
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 23 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 28 | Upvalues: t (copy), Util (copy) ]]
	p1:RegisterType("robbery", t)
	p1:RegisterType("robberies", Util.MakeListableType(t))
end