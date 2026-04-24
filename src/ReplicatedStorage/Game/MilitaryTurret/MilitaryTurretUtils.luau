-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
return {
	shortAngleDist = function(p1, p2)
		local v1 = (p2 - p1) % 6.283185307179586
		return 2 * v1 % 6.283185307179586 - v1
	end,
	getNearestNonPolice = function(p1, p2)
		local v1 = p2 or (1 / 0)
		local v2 = nil
		for i, v in ipairs(Players:GetPlayers()) do
			local v3 = PlayerUtils.getTeam(v)
			if v3 and v3 ~= Settings.Team.Police then
				local v4 = PlayerUtils.getRootPart(v)
				if v4 then
					local Magnitude = (v4.Position - p1).Magnitude
					if Magnitude < v1 then
						v1 = Magnitude
						v2 = v
					end
				end
			end
		end
		return v2
	end
}
