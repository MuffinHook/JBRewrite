-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local gamepassTitles = {}
for v1, v2 in require(ReplicatedStorage.Gamepass.GamepassData) do
	table.insert(gamepassTitles, v2.Title)
end
local gamepassFinder = Util.MakeFuzzyFinder(gamepassTitles)
local gamepassType = {
	Transform = function(p1)
		return gamepassFinder(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid robbery with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("gamepass", gamepassType)
end
