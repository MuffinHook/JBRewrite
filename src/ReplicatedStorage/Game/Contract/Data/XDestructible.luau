local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = function(contractData)
		return ("Knock over %d items."):format(contractData:GetGoal())
	end,
	goal = function()
		return 400 + math.random(0, 10)
	end,
	rewardExp = 45
}
