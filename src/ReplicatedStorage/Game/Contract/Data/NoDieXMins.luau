-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1)
		return ("Survive %d minutes without dying."):format(p1:GetGoal())
	end,
	goal = 7,
	rewardExp = 25
}
