local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = "Bust some criminals in a bank robbery!",
	goal = 1,
	rewardExp = 50
}
