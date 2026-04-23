local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1) --[[ Line: 6 ]]
		return ("Drive or fly %d miles."):format(p1:GetGoal())
	end,
	goal = 25,
	rewardExp = 30
}