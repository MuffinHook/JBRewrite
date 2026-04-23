local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local t = {}
for v1, v2 in require(ReplicatedStorage.Gamepass.GamepassData) do
	table.insert(t, v2.Title)
end
local v3 = Util.MakeFuzzyFinder(t)
local t2 = {
	Transform = function(p1) --[[ Name: Transform | Line: 16 | Upvalues: v3 (copy) ]]
		return v3(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 20 ]]
		return #p1 > 0, "No valid robbery with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 24 ]]
		return p1
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 28 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 33 | Upvalues: t2 (copy) ]]
	p1:RegisterType("gamepass", t2)
end