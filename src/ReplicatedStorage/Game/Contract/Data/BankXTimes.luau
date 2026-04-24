-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1)
		return ("Rob the Bank %d times."):format(p1:GetGoal())
	end,
	goal = function()
		return math.random(3, 4)
	end,
	rewardExp = 60
}
