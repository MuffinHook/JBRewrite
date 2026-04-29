local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	shortAngleDist = function(angle1, angle2)
		local angleDifference = (angle2 - angle1) % math.tau
		return 2 * angleDifference % math.tau - angleDifference
	end,
	getNearestNonPolice = function(searchPosition, maxDistance)
		local minDistance = maxDistance or (1 / 0)
		local nearestPlayer = nil
		for i, player in ipairs(Players:GetPlayers()) do
			local playerTeam = PlayerUtils.getTeam(player)
			if playerTeam and playerTeam ~= Settings.Team.Police then
				local playerRootPart = PlayerUtils.getRootPart(player)
				if playerRootPart then
					local distance = (playerRootPart.Position - searchPosition).Magnitude
					if distance < minDistance then
						minDistance = distance
						nearestPlayer = player
					end
				end
			end
		end
		return nearestPlayer
	end
}
