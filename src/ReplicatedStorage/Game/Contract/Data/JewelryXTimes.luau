local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Rob the Jewelry Store %d times"):format(contract:GetGoal())
	end,
	goal = 5,
	rewardExp = 50
}
