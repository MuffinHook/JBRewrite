local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contract)
		return ("Pop the tires of %d criminal vehicles!"):format(contract:GetGoal())
	end,
	goal = 4,
	rewardExp = 40
}
