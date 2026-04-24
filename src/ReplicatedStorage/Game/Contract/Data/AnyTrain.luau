-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1)
		return ("Rob the Train %d times."):format(p1:GetGoal())
	end,
	goal = 6,
	rewardExp = 50
}
