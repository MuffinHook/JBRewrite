local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1) --[[ Line: 6 ]]
		return ("Take down %d police without dying."):format(p1:GetGoal())
	end,
	goal = 5,
	rewardExp = 50
}