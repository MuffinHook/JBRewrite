-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1)
		return ("Use road spikes to pop %d tires."):format(p1:GetGoal())
	end,
	goal = 3,
	rewardExp = 50
}
