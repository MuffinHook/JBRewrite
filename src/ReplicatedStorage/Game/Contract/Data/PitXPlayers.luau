-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1)
		return ("Pit maneuver %d different criminals."):format(p1:GetGoal())
	end,
	goal = function()
		return math.random(5, 7)
	end,
	rewardExp = 40
}
