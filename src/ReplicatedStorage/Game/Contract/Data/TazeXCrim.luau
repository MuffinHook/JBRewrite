local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1) --[[ Line: 6 ]]
		return ("Taze %d criminals."):format(p1:GetGoal())
	end,
	goal = 6,
	rewardExp = 30
}