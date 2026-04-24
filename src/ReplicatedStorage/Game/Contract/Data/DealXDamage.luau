-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Format = require(ReplicatedStorage.Module.Format)
return {
	teamId = Settings.EnumTeam.Criminal,
	message = function(p1)
		return ("Deal %s damage"):format(Format.Comma(p1:GetGoal()))
	end,
	goal = function()
		return math.random(18, 22) * 100
	end,
	rewardExp = 40
}
