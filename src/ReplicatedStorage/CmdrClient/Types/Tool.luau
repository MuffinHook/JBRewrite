local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local v2 = Util.MakeFuzzyFinder((TableUtils.map(ReplicatedStorage.Resource.ItemSystem.Models:GetChildren(), function(p1) --[[ Line: 5 ]]
	return p1.Name
end)))
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 11 | Upvalues: v2 (copy) ]]
		return v2(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 15 ]]
		return #p1 > 0, "No valid vehicle makes with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 19 ]]
		return p1
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 23 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 28 | Upvalues: t (copy), Util (copy) ]]
	p1:RegisterType("tool", t)
	p1:RegisterType("tools", Util.MakeListableType(t))
end