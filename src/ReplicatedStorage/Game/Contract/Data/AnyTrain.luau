local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Rob the Train %d times."):format(contract:GetGoal())
	end,
	goal = 6,
	rewardExp = 50
}
