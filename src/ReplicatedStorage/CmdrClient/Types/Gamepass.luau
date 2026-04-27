local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local gamepassTitles = {}
for gamepassId, gamepass in require(ReplicatedStorage.Gamepass.GamepassData) do
	table.insert(gamepassTitles, gamepass.Title)
end
local gamepassFinder = Util.MakeFuzzyFinder(gamepassTitles)
local gamepassType = {
	Transform = function(query)
		return gamepassFinder(query)
	end,
	Validate = function(query)
		return #query > 0, "No valid robbery with that name could be found."
	end,
	Autocomplete = function(query)
		return query
	end,
	Parse = function(results)
		return results[1]
	end
}
return function(cmdr)
	cmdr:RegisterType("gamepass", gamepassType)
end
