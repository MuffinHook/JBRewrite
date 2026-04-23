local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(p1) --[[ Line: 6 ]]
		return ("Rob the Bank %d times."):format(p1:GetGoal())
	end,
	goal = function() --[[ Line: 9 ]]
		return math.random(3, 4)
	end,
	rewardExp = 60
}