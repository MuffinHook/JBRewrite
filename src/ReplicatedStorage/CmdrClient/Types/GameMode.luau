-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local v2 = Util.MakeFuzzyFinder((require(ReplicatedStorage.GameMode.GameModeUtils).getGameModeNames()))
local t = {
	Transform = function(p1)
		return v2(p1)
	end,
	Validate = function(p1)
		return #p1 > 0, "No valid gamemode with that name could be found."
	end,
	Autocomplete = function(p1)
		return p1
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("gamemode", t)
end
