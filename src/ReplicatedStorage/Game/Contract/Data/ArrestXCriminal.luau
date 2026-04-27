local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contract)
		return ("Arrest %d criminals."):format(contract:GetGoal())
	end,
	goal = function()
		return math.random(12, 15)
	end,
	rewardExp = 50
}
