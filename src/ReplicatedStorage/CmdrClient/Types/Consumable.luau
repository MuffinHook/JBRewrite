-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local t = {}
for v1, v2 in require(ReplicatedStorage.Consumables.ConsumablesData) do
	table.insert(t, v1)
end
local v3 = Util.MakeFuzzyFinder(t)
local t2 = {
	Transform = function(p1)
		return v3(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid consumable with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("consumable", t2)
end
