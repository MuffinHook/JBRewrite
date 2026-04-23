local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1) --[[ Line: 6 ]]
		return ("Knock over %d items."):format(p1:GetGoal())
	end,
	goal = function() --[[ Line: 9 ]]
		return 400 + math.random(0, 10)
	end,
	rewardExp = 45
}