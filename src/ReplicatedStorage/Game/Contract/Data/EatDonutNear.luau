-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police,
	message = "Eat a donut next to a Criminal, 10 times.",
	goal = 10,
	rewardExp = 25
}
