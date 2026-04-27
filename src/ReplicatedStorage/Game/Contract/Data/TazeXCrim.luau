local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contract)
		return ("Taze %d criminals."):format(contract:GetGoal())
	end,
	goal = 6,
	rewardExp = 30
}
