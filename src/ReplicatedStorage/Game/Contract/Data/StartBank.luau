local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1) --[[ Line: 6 ]]
		return ("Start a bank robbery %d times!"):format(p1:GetGoal())
	end,
	goal = 2,
	rewardExp = 35
}