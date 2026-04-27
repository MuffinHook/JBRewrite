local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Format = require(ReplicatedStorage.Module.Format)
return {
	teamId = Settings.EnumTeam.Police,
	message = function(contract)
		return ("Arrest %s worth of criminal bounty."):format(Format.Currency(contract:GetGoal()))
	end,
	goal = function()
		return 5000 + math.random(0, 4) * 250
	end,
	rewardExp = 60
}
