-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local setupAnimations = require(ReplicatedStorage.NPC.setupAnimations)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local NPCShared = require(ReplicatedStorage.NPC.NPCShared)
local t = {}
t.__index = t
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2.maid = Maid.new()
	t2._maid = t2.maid
	t2.obj = p1
	t2.manifest = p2
	t2.humanoid = p2.humanoid
	t2._humanoid = t2.humanoid
	t2.maid:GiveTask(task.delay(0.5, function()
		t2.maid:GiveTask(setupAnimations(p1))
	end))
	NPCShared.setup(t2)
	return t2
end
function t.IsLocallyOwned(p1)
	local isLocalPlayer = NPCUtils.getNetworkOwner(p1.obj) == Players.LocalPlayer
	return isLocalPlayer
end
function t.GetTargetType(p1)
	return NPCUtils.getTargetType(p1.obj)
end
function t.SetTargetType(p1, p2)
	NPCUtils.setTargetType(p1.obj, p2)
end
function t.GetTarget(p1)
	return NPCUtils.getTarget(p1.obj)
end
function t.SetLookAt(p1, p2, p3)
	NPCUtils.setLookAt(p1.obj, p2, p3)
end
function t.Destroy(p1)
	p1.maid:Destroy()
	setmetatable(p1, nil)
end
return t
