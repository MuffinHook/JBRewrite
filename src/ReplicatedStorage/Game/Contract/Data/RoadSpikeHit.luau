local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contractData)
		return ("Use road spikes to pop %d tires."):format(contractData:GetGoal())
	end,
	goal = 3,
	rewardExp = 50
}
