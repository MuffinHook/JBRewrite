-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1)
		return ("Pop the tires of %d criminal vehicles!"):format(p1:GetGoal())
	end,
	goal = 4,
	rewardExp = 40
}
