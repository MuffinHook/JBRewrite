local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local FriendsConsts = require(ReplicatedStorage.Friends.FriendsConsts)
local Interval = require(ReplicatedStorage.Std.Interval)
local t = {
	friendsUpdated = require(ReplicatedStorage.Std.Signal).new(),
	_cachedLocal = {}
}
function t.init() --[[ Line: 12 | Upvalues: t (copy), Players (copy) ]]
	t.monitorPlayer(Players.LocalPlayer)
end
function t.monitorPlayer(p1) --[[ Line: 15 | Upvalues: Interval (copy), FriendsConsts (copy), t (copy), StarterGui (copy) ]]
	Interval.every(FriendsConsts.FRIEND_UPDATE_INTERVAL):Connect(function() --[[ Line: 18 | Upvalues: t (ref), p1 (copy) ]]
		t.updateFriends(p1)
	end)
	task.spawn(t.updateFriends, p1)
	pcall(function() --[[ Line: 23 | Upvalues: StarterGui (ref), t (ref), p1 (copy) ]]
		StarterGui:GetCore("PlayerFriendedEvent").Event:Connect(function(p12) --[[ Line: 24 | Upvalues: t (ref), p1 (ref) ]]
			local v1 = t._cachedLocal[p1.UserId]
			if v1 and not v1[p12.UserId] then
				v1[p12.UserId] = true
				t.friendsUpdated:Fire()
			end
		end)
		StarterGui:GetCore("PlayerUnfriendedEvent").Event:Connect(function(p12) --[[ Line: 31 | Upvalues: t (ref), p1 (ref) ]]
			local v1 = t._cachedLocal[p1.UserId]
			if v1 and v1[p12.UserId] then
				v1[p12.UserId] = nil
				t.friendsUpdated:Fire()
			end
		end)
	end)
end
function t.updateFriends(p1) --[[ Line: 40 | Upvalues: Players (copy), t (copy) ]]
	if p1 == Players.LocalPlayer then
		local v1, v2 = pcall(function() --[[ Line: 46 | Upvalues: Players (ref), p1 (copy) ]]
			return Players:GetFriendsAsync(p1.UserId)
		end)
		if v1 or t._cachedLocal[p1.UserId] ~= nil then
			local t2 = {}
			while true do
				for v3, v4 in v2:GetCurrentPage() do
					t2[v4.Id] = true
				end
				if v2.IsFinished then
					t._cachedLocal[p1.UserId] = t2
					t.friendsUpdated:Fire()
					return t._cachedLocal[p1.UserId]
				end
				v2:AdvanceToNextPageAsync()
			end
		else
			t._cachedLocal[p1.UserId] = {}
			return t._cachedLocal[p1.UserId]
		end
	else
		error("Not meant to update friends for other players")
	end
end
function t.getIsFriendsWith(p1, p2, p3) --[[ Line: 66 | Upvalues: t (copy) ]]
	if p1 then
		if not t._cachedLocal[p1.UserId] then
			if p3 then
				return false
			end
			t.updateFriends(p1)
		end
		return t._cachedLocal[p1.UserId][p2] == true
	else
		warn("No player")
		return false
	end
end
return t