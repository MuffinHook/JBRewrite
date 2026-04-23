local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Format = require(ReplicatedStorage.Module.Format)
return {
	teamId = Settings.EnumTeam.Police,
	message = function(p1) --[[ Line: 7 | Upvalues: Format (copy) ]]
		return ("Arrest %s worth of criminal bounty."):format(Format.Currency(p1:GetGoal()))
	end,
	goal = function() --[[ Line: 10 ]]
		return 5000 + math.random(0, 4) * 250
	end,
	rewardExp = 60
}