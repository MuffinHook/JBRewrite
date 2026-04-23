local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(script.Parent.Promise)
local t = {}
local t2 = {}
function t.promiseNameFromUserId(p1) --[[ Line: 11 | Upvalues: Promise (copy), t2 (copy), Players (copy) ]]
	if p1 < 0 then
		return Promise.resolve("[USERNAME]")
	elseif t2[p1] then
		return Promise.resolve(t2[p1])
	else
		return Promise.new(function(p12) --[[ Line: 17 | Upvalues: Players (ref), p1 (copy), t2 (ref) ]]
			local v1 = Players:GetNameFromUserIdAsync(p1)
			t2[p1] = v1
			p12(v1)
		end)
	end
end
function t.promiseUserIdFromName(p1) --[[ Line: 23 | Upvalues: Promise (copy), Players (copy) ]]
	return Promise.new(function(p12, p2, p3) --[[ Line: 24 | Upvalues: Players (ref), p1 (copy) ]]
		local v1 = Players:GetUserIdFromNameAsync(p1)
		if not p3() then
			p12(v1)
		end
	end)
end
function t.promiseUserThumbnail(p1, p2, p3) --[[ Line: 32 | Upvalues: Promise (copy), Players (copy) ]]
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	assert(p3 ~= nil)
	return Promise.new(function(p12, p22, p32) --[[ Line: 36 | Upvalues: Players (ref), p1 (copy), p2 (copy), p3 (copy) ]]
		local v1, v2 = Players:GetUserThumbnailAsync(p1, p2, p3)
		if v2 then
			p12(v1)
		else
			p22()
		end
	end)
end
function t.getHeadShot(p1) --[[ Line: 47 ]]
	return ("rbxthumb://type=AvatarHeadShot&id=%*&w=180&h=180"):format(p1)
end
local v1 = Maid.new()
function t.getPlayerMaid(p1) --[[ Line: 54 | Upvalues: Players (copy), v1 (copy), Maid (copy) ]]
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
local function playerRemoving(p1) --[[ Line: 65 | Upvalues: v1 (copy) ]]
	v1[p1] = nil
end
Players.PlayerRemoving:Connect(playerRemoving)
function t.observePlayerAdded(p1) --[[ Line: 71 | Upvalues: Maid (copy), Players (copy) ]]
	local v1 = Maid.new()
	local t = {}
	local function onPlayerAdded(p12) --[[ Line: 74 | Upvalues: t (copy), Maid (ref), p1 (copy) ]]
		t[p12] = Maid.new()
		p1(p12, t[p12])
	end
	local function onPlayerRemoving(p1) --[[ Line: 78 | Upvalues: t (copy) ]]
		local v1 = t[p1]
		if v1 then
			t[p1] = nil
			v1:DoCleaning()
		end
	end
	v1:GiveTask(function() --[[ Line: 85 | Upvalues: t (copy) ]]
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