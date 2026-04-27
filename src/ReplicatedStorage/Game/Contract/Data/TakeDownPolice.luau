local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Take down %d police without dying."):format(contract:GetGoal())
	end,
	goal = 5,
	rewardExp = 50
}
