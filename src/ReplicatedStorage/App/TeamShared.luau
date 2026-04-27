local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local module = {
	promiseIsTeamSwitchingEnabled = function()
		if RunUtils.isMainWorld() then
			return PrivateServerUtils.promiseGetIsBattleServer():andThen(function(isBattleServer)
				return not isBattleServer
			end)
		else
			return Promise.resolve(false)
		end
	end
}
function module.isTeamSwitchingEnabled()
	local succeeded, isEnabled = module.promiseIsTeamSwitchingEnabled():await()
	return succeeded and isEnabled
end
function module.isTeamFull(teamToCheck)
	local playersList = Players:GetPlayers()
	local count = 0
	local count_2 = 0
	for i, player in playersList do
		local ChoosingTeam = player:FindFirstChild("ChoosingTeam")
		if ChoosingTeam and not (ChoosingTeam and ChoosingTeam.Value) then
			local teamName = player.Team and player.Team.Name
			if teamName == "Police" then
				count_2 = count_2 + 1
			elseif teamName == "Prisoner" or teamName == "Criminal" then
				count = count + 1
			end
		end
	end
	local VipOwnerId = ReplicatedStorage:FindFirstChild("VipOwnerId")
	if RunUtils.isStudio() or (VipOwnerId or teamToCheck ~= Settings.EnumTeam.Prisoner and teamToCheck ~= Settings.EnumTeam.Criminal) then
		return false
	else
		if math.max(math.ceil(#playersList * 0.8), 1) <= count then
			return true
		else
			return false
		end
	end
end
return module
