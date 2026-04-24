-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local FriendsConsts = require(ReplicatedStorage.Friends.FriendsConsts)
local Interval = require(ReplicatedStorage.Std.Interval)
local FriendsService = {
	friendsUpdated = require(ReplicatedStorage.Std.Signal).new(),
	_cachedLocal = {}
}
function FriendsService.init()
	FriendsService.monitorPlayer(Players.LocalPlayer)
end
function FriendsService.monitorPlayer(player)
	Interval.every(FriendsConsts.FRIEND_UPDATE_INTERVAL):Connect(function()
		FriendsService.updateFriends(player)
	end)
	task.spawn(FriendsService.updateFriends, player)
	pcall(function()
		StarterGui:GetCore("PlayerFriendedEvent").Event:Connect(function(otherPlayer)
			local playerFriendsCache = FriendsService._cachedLocal[player.UserId]
			if playerFriendsCache and not playerFriendsCache[otherPlayer.UserId] then
				playerFriendsCache[otherPlayer.UserId] = true
				FriendsService.friendsUpdated:Fire()
			end
		end)
		StarterGui:GetCore("PlayerUnfriendedEvent").Event:Connect(function(otherPlayer)
			local playerFriendsCache = FriendsService._cachedLocal[player.UserId]
			if playerFriendsCache and playerFriendsCache[otherPlayer.UserId] then
				playerFriendsCache[otherPlayer.UserId] = nil
				FriendsService.friendsUpdated:Fire()
			end
		end)
	end)
end
function FriendsService.updateFriends(player)
	if player == Players.LocalPlayer then
		local isSuccess, friendsPageResult = pcall(function()
			return Players:GetFriendsAsync(player.UserId)
		end)
		if isSuccess or FriendsService._cachedLocal[player.UserId] ~= nil then
			local friendsTable = {}
			while true do
				for _index, friendInfo in friendsPageResult:GetCurrentPage() do
					friendstable[friendInfo.Id] = true
				end
				if friendsPageResult.IsFinished then
					FriendsService._cachedLocal[player.UserId] = friendsTable
					FriendsService.friendsUpdated:Fire()
					return FriendsService._cachedLocal[player.UserId]
				end
				friendspageResult:AdvanceToNextPageAsync()
			end
		else
			FriendsService._cachedLocal[player.UserId] = {}
			return FriendsService._cachedLocal[player.UserId]
		end
	else
		error("Not meant to update friends for other players")
	end
end
function FriendsService.getIsFriendsWith(player, friendUserId, skipUpdate)
	if player then
		if not FriendsService._cachedLocal[player.UserId] then
			if skipUpdate then
				return false
			end
			FriendsService.updateFriends(player)
		end
		return FriendsService._cachedLocal[player.UserId][friendUserId] == true
	else
		warn("No player")
		return false
	end
end
return FriendsService
