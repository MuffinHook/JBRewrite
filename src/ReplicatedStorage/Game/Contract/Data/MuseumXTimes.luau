local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Rob the Museum %d times"):format(contract:GetGoal())
	end,
	goal = 4,
	rewardExp = 50
}
