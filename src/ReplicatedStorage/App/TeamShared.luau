-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {
	promiseIsTeamSwitchingEnabled = function()
		if RunUtils.isMainWorld() then
			return PrivateServerUtils.promiseGetIsBattleServer():andThen(function(p1)
				return not p1
			end)
		else
			return Promise.resolve(false)
		end
	end
}
function t.isTeamSwitchingEnabled()
	local v1, v2 = t.promiseIsTeamSwitchingEnabled():await()
	return v1 and v2
end
function t.isTeamFull(p1)
	local v1 = Players:GetPlayers()
	local count = 0
	local count_2 = 0
	for v2, v3 in v1 do
		local ChoosingTeam = v3:FindFirstChild("ChoosingTeam")
		if ChoosingTeam and not (ChoosingTeam and ChoosingTeam.Value) then
			local v4 = v3.Team and v3.Team.Name
			if v4 == "Police" then
				count_2 = count_2 + 1
			elseif v4 == "Prisoner" or v4 == "Criminal" then
				count = count + 1
			end
		end
	end
	local VipOwnerId = ReplicatedStorage:FindFirstChild("VipOwnerId")
	if RunUtils.isStudio() or (VipOwnerId or p1 ~= Settings.EnumTeam.Prisoner and p1 ~= Settings.EnumTeam.Criminal) then
		return false
	else
		if math.max(math.ceil(#v1 * 0.8), 1) <= count then
			return true
		else
			return false
		end
	end
end
return t