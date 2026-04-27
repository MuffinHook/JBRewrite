local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contractData)
		return ("Rob the Bank %d times."):format(contractData:GetGoal())
	end,
	goal = function()
		return math.random(3, 4)
	end,
	rewardExp = 60
}
