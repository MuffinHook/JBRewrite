local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local setupAnimations = require(ReplicatedStorage.NPC.setupAnimations)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local NPCShared = require(ReplicatedStorage.NPC.NPCShared)
local NPC = {}
NPC.__index = NPC
function NPC.new(npcObject, manifest)
	local instance = {}
	setmetatable(instance, NPC)
	instance.maid = Maid.new()
	instance._maid = instance.maid
	instance.obj = npcObject
	instance.manifest = manifest
	instance.humanoid = manifest.humanoid
	instance._humanoid = instance.humanoid
	instance.maid:GiveTask(task.delay(0.5, function()
		instance.maid:GiveTask(setupAnimations(npcObject))
	end))
	NPCShared.setup(instance)
	return instance
end
function NPC.IsLocallyOwned(self)
	local isLocalPlayer = NPCUtils.getNetworkOwner(self.obj) == Players.LocalPlayer
	return isLocalPlayer
end
function NPC.GetTargetType(self)
	return NPCUtils.getTargetType(self.obj)
end
function NPC.SetTargetType(self, targetType)
	NPCUtils.setTargetType(self.obj, targetType)
end
function NPC.GetTarget(self)
	return NPCUtils.getTarget(self.obj)
end
function NPC.SetLookAt(self, targetPosition, lookAtTime)
	NPCUtils.setLookAt(self.obj, targetPosition, lookAtTime)
end
function NPC.Destroy(self)
	self.maid:Destroy()
	setmetatable(self, nil)
end
return NPC
