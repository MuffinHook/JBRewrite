-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal,
	message = "Drop 2 helicopters into the criminal base volcano.",
	goal = 2,
	rewardExp = 25
}
