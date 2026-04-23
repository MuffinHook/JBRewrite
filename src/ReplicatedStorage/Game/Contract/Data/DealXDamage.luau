local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Format = require(ReplicatedStorage.Module.Format)
return {
	teamId = Settings.EnumTeam.Criminal,
	message = function(p1) --[[ Line: 7 | Upvalues: Format (copy) ]]
		return ("Deal %s damage"):format(Format.Comma(p1:GetGoal()))
	end,
	goal = function() --[[ Line: 10 ]]
		return math.random(18, 22) * 100
	end,
	rewardExp = 40
}