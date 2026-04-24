-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Format = require(ReplicatedStorage.Module.Format)
return {
	teamId = Settings.EnumTeam.Police,
	message = function(p1)
		return ("Arrest a criminal with a %s+ bounty."):format(Format.Currency(p1:GetGoal()))
	end,
	goal = function()
		return math.random(5, 6) * 500
	end,
	rewardExp = 30
}
