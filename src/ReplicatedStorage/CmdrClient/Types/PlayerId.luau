local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local userIdCache = {}
local function getUserId(playerName)
	if userIdCache[playerName] then
		return userIdCache[playerName]
	elseif Players:FindFirstChild(playerName) then
		userIdCache[playerName] = Players[playerName].UserId
		return Players[playerName].UserId
	else
		local success, userId = pcall(Players.GetUserIdFromNameAsync, Players, playerName)
		if success then
			userIdCache[playerName] = userId
			return userId
		else
			return nil
		end
	end
end
local playerIdType = {
	DisplayName = "Full Player Name",
	Prefixes = "# positiveInteger",
	Transform = function(playerName)
		return playerName, Util.MakeFuzzyFinder(Players:GetPlayers())(playerName)
	end,
	ValidateOnce = function(playerName)
		local userId
		if userIdCache[playerName] then
			userId = userIdCache[playerName]
		elseif Players:FindFirstChild(playerName) then
			userIdCache[playerName] = Players[playerName].UserId
			userId = Players[playerName].UserId
		else
			local success, resultId = pcall(Players.GetUserIdFromNameAsync, Players, playerName)
			if success then
				userIdCache[playerName] = resultId
				userId = resultId
			else
				userId = nil
			end
		end
		return userId ~= nil, "No player with that name could be found."
	end,
	Autocomplete = function(playerName, playerList)
		return Util.GetNames(playerList)
	end,
	Parse = function(playerName)
		if userIdCache[playerName] then
			return userIdCache[playerName]
		elseif Players:FindFirstChild(playerName) then
			userIdCache[playerName] = Players[playerName].UserId
			return Players[playerName].UserId
		else
			local success, userId = pcall(Players.GetUserIdFromNameAsync, Players, playerName)
			if success then
				userIdCache[playerName] = userId
				return userId
			else
				return nil
			end
		end
	end,
	Default = function(playerName)
		return playerName.Name
	end,
	ArgumentOperatorAliases = {
		me = ".",
		all = "*",
		others = "**",
		random = "?"
	}
}
return function(playerName)
	playerName:RegisterType("playerId", playerIdType)
	playerName:RegisterType("playerIds", Util.MakeListableType(playerIdType, {
		Prefixes = "# positiveIntegers"
	}))
end
