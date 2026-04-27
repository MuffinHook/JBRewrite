local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contractData)
		return ("Survive %d minutes without dying."):format(contractData:GetGoal())
	end,
	goal = 7,
	rewardExp = 25
}
