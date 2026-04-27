local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Drive or fly %d miles."):format(contract:GetGoal())
	end,
	goal = 25,
	rewardExp = 30
}
