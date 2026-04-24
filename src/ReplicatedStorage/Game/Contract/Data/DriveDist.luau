-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1)
		return ("Drive or fly %d miles."):format(p1:GetGoal())
	end,
	goal = 25,
	rewardExp = 30
}
