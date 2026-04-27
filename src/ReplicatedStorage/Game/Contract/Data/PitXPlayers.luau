local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(contract)
		return ("Pit maneuver %d different criminals."):format(contract:GetGoal())
	end,
	goal = function()
		return math.random(5, 7)
	end,
	rewardExp = 40
}
