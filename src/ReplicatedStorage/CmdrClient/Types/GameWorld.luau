-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local t = {}
for v1, v2 in RunConsts.PLACE_ID_TO_WORLD_MAP do
	if table.find(t, v2) == nil then
		table.insert(t, v2)
	end
end
local v3 = Util.MakeFuzzyFinder(t)
local t2 = {
	Transform = function(p1)
		return v3(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid world with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("world", t2)
end
