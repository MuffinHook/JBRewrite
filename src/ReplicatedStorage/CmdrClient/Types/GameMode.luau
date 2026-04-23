local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local v2 = Util.MakeFuzzyFinder((require(ReplicatedStorage.GameMode.GameModeUtils).getGameModeNames()))
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 9 | Upvalues: v2 (copy) ]]
		return v2(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 13 ]]
		return #p1 > 0, "No valid gamemode with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 17 ]]
		return p1
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 21 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 26 | Upvalues: t (copy) ]]
	p1:RegisterType("gamemode", t)
end