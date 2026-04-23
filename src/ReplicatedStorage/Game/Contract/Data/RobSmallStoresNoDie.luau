local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = "Rob two small stores (gas station, donut) without dying!",
	goal = 2,
	rewardExp = 30
}