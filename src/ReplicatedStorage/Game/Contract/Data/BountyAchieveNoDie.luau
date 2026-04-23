local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = "Collect a bounty of $4,000 without dying.",
	goal = 4000,
	rewardExp = 25
}