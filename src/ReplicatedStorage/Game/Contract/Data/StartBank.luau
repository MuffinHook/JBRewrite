local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Start a bank robbery %d times!"):format(contract:GetGoal())
	end,
	goal = 2,
	rewardExp = 35
}
