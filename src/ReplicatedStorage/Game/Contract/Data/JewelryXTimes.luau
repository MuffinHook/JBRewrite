-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1)
		return ("Rob the Jewelry Store %d times"):format(p1:GetGoal())
	end,
	goal = 5,
	rewardExp = 50
}
