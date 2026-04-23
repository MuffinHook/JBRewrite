local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local setupAnimations = require(ReplicatedStorage.NPC.setupAnimations)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local NPCShared = require(ReplicatedStorage.NPC.NPCShared)
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 12 | Upvalues: t (copy), Maid (copy), setupAnimations (copy), NPCShared (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.maid = Maid.new()
	t2._maid = t2.maid
	t2.obj = p1
	t2.manifest = p2
	t2.humanoid = p2.humanoid
	t2._humanoid = t2.humanoid
	t2.maid:GiveTask(task.delay(0.5, function() --[[ Line: 28 | Upvalues: t2 (copy), setupAnimations (ref), p1 (copy) ]]
		t2.maid:GiveTask(setupAnimations(p1))
	end))
	NPCShared.setup(t2)
	return t2
end
function t.IsLocallyOwned(p1) --[[ Line: 35 | Upvalues: NPCUtils (copy), Players (copy) ]]
	local isLocalPlayer = NPCUtils.getNetworkOwner(p1.obj) == Players.LocalPlayer
	return isLocalPlayer
end
function t.GetTargetType(p1) --[[ Line: 38 | Upvalues: NPCUtils (copy) ]]
	return NPCUtils.getTargetType(p1.obj)
end
function t.SetTargetType(p1, p2) --[[ Line: 41 | Upvalues: NPCUtils (copy) ]]
	NPCUtils.setTargetType(p1.obj, p2)
end
function t.GetTarget(p1) --[[ Line: 44 | Upvalues: NPCUtils (copy) ]]
	return NPCUtils.getTarget(p1.obj)
end
function t.SetLookAt(p1, p2, p3) --[[ Line: 48 | Upvalues: NPCUtils (copy) ]]
	NPCUtils.setLookAt(p1.obj, p2, p3)
end
function t.Destroy(p1) --[[ Line: 51 ]]
	p1.maid:Destroy()
	setmetatable(p1, nil)
end
return t