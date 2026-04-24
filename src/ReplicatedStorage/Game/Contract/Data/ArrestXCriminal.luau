-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1)
		return ("Arrest %d criminals."):format(p1:GetGoal())
	end,
	goal = function()
		return math.random(12, 15)
	end,
	rewardExp = 50
}
