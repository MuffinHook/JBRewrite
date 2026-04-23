local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = function(p1) --[[ Line: 6 ]]
		return ("Arrest %d criminals."):format(p1:GetGoal())
	end,
	goal = function() --[[ Line: 9 ]]
		return math.random(12, 15)
	end,
	rewardExp = 50
}