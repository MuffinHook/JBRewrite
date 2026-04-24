-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(script.Parent.Promise)
local t = {}
local t2 = {}
function t.promiseNameFromUserId(p1)
	if p1 < 0 then
		return Promise.resolve("[USERNAME]")
	elseif t2[p1] then
		return Promise.resolve(t2[p1])
	else
		return Promise.new(function(p12)
			local v1 = Players:GetNameFromUserIdAsync(p1)
			t2[p1] = v1
			p12(v1)
		end)
	end
end
function t.promiseUserIdFromName(p1)
	return Promise.new(function(p12, p2, p3)
		local v1 = Players:GetUserIdFromNameAsync(p1)
		if not p3() then
			p12(v1)
		end
	end)
end
function t.promiseUserThumbnail(p1, p2, p3)
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	assert(p3 ~= nil)
	return Promise.new(function(p12, p22, p32)
		local v1, v2 = Players:GetUserThumbnailAsync(p1, p2, p3)
		if v2 then
			p12(v1)
		else
			p22()
		end
	end)
end
function t.getHeadShot(p1)
	return ("rbxthumb://type=AvatarHeadShot&id=%*&w=180&h=180"):format(p1)
end
local v1 = Maid.new()
function t.getPlayerMaid(p1)
	assert(p1.Parent == Players, "player must be a Player")
	local v12 = v1[p1]
	if not v12 then
		v1[p1] = Maid.new()
		v12 = v1[p1]
	end
	local v2 = Maid.new()
	v12:GiveTask(v2)
	return v2
end
local function playerRemoving(p1)
	v1[p1] = nil
end
Players.PlayerRemoving:Connect(playerRemoving)
function t.observePlayerAdded(p1)
	local v1 = Maid.new()
	local t = {}
	local function onPlayerAdded(p12)
		t[p12] = Maid.new()
		p1(p12, t[p12])
	end
	local function onPlayerRemoving(p1)
		local v1 = t[p1]
		if v1 then
			t[p1] = nil
			v1:DoCleaning()
		end
	end
	v1:GiveTask(function()
		for k, v in pairs(t) do
			local v1 = t[k]
			if v1 then
				t[k] = nil
				v1:DoCleaning()
			end
		end
	end)
	for v2, v3 in Players:GetPlayers() do
		task.spawn(onPlayerAdded, v3)
	end
	v1:GiveTask(Players.PlayerAdded:Connect(onPlayerAdded))
	v1:GiveTask(Players.PlayerRemoving:Connect(onPlayerRemoving))
	return v1
end
return t
