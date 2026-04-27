local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contract)
		return ("Rob the Oil Rig %d times!"):format(contract:GetGoal())
	end,
	goal = 3,
	rewardExp = 60
}
