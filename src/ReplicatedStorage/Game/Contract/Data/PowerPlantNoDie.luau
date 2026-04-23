local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = "Rob the Power Plant twice in one life.",
	goal = 2,
	rewardExp = 60
}