local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(script.Parent.Promise)
local PlayerUtils = {}
local usernameCache = {}
function PlayerUtils.promiseNameFromUserId(userId)
	if userId < 0 then
		return Promise.resolve("[USERNAME]")
	elseif usernameCache[userId] then
		return Promise.resolve(usernameCache[userId])
	else
		return Promise.new(function(resolve)
			local username = Players:GetNameFromUserIdAsync(userId)
			usernameCache[userId] = username
			resolve(username)
		end)
	end
end
function PlayerUtils.promiseUserIdFromName(username)
	return Promise.new(function(resolve, reject, onCancel)
		local userId = Players:GetUserIdFromNameAsync(username)
		if not onCancel() then
			resolve(userId)
		end
	end)
end
function PlayerUtils.promiseUserThumbnail(userId, size, thumbnailType)
	assert(userId ~= nil)
	assert(size ~= nil)
	assert(thumbnailType ~= nil)
	return Promise.new(function(resolve, reject, onCancel)
		local thumbnailUrl, isSuccess = Players:GetUserThumbnailAsync(userId, size, thumbnailType)
		if isSuccess then
			resolve(thumbnailUrl)
		else
			reject()
		end
	end)
end
function PlayerUtils.getHeadShot(userId)
	return ("rbxthumb://type=AvatarHeadShot&id=%*&w=180&h=180"):format(userId)
end
local globalPlayerMaids = Maid.new()
function PlayerUtils.getPlayerMaid(player)
	assert(player.Parent == Players, "player must be a Player")
	local playerMaid = globalPlayerMaids[player]
	if not playerMaid then
		globalPlayerMaids[player] = Maid.new()
		playerMaid = globalPlayerMaids[player]
	end
	local taskMaid = Maid.new()
	playerMaid:GiveTask(taskMaid)
	return taskMaid
end
local function playerRemoving(player)
	globalPlayerMaids[player] = nil
end
Players.PlayerRemoving:Connect(playerRemoving)
function PlayerUtils.observePlayerAdded(onPlayerAdded)
	local observerMaid = Maid.new()
	local playerMaids = {}
	local function onPlayerAddedHandler(player)
		playerMaids[player] = Maid.new()
		onPlayerAdded(player, playerMaids[player])
	end
	local function onPlayerRemovingHandler(player)
		local maid = playerMaids[player]
		if maid then
			playerMaids[player] = nil
			maid:DoCleaning()
		end
	end
	observerMaid:GiveTask(function()
		for player, _ in pairs(playerMaids) do
			local maid = playerMaids[player]
			if maid then
				playerMaids[player] = nil
				maid:DoCleaning()
			end
		end
	end)
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAddedHandler, player)
	end
	observerMaid:GiveTask(Players.PlayerAdded:Connect(onPlayerAddedHandler))
	observerMaid:GiveTask(Players.PlayerRemoving:Connect(onPlayerRemovingHandler))
	return observerMaid
end
return PlayerUtils
