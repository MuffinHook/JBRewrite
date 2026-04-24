-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetworkOwnedBinder = require(ReplicatedStorage.NetworkOwned.NetworkOwnedBinder)
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local SeekingMissileShared = require(ReplicatedStorage.SeekingMissile.SeekingMissileShared)
local SeekingMissileUtils = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local instance = BaseObject.new(p1)
	setmetatable(instance, t)
	instance.alignOrientation = p2.alignOrientation
	instance.vectorForce = p2.vectorForce
	instance.targetPartObj = p2.targetPartObj
	instance.runMaid = Maid.new()
	instance.maid:GiveTask(instance.runMaid)
	SeekingMissileShared._init(instance)
	instance.maid:GiveTask(instance.onApplyingThrustChanged:Connect(function()
		p2.applyingThrustRemote:FireServer(instance.flagApplyingThrust)
	end))
	instance.maid:GiveTask(instance.onExploded:Connect(function(...)
		p2.explodeRemote:FireServer(...)
	end))
	instance.maid:GiveTask(p2.explodeRemote.OnClientEvent:Connect(function(...)
		instance.onExploded:Fire(...)
	end))
	instance.maid:GivePromise(NetworkOwnedBinder:Promise(p1):andThen(function(p12)
		local function handle()
			instance.runMaid:DoCleaning()
			if p2.targetPartObj.Value or SeekingMissileUtils.getTargetPos(p1) then
				if p12:GetOwner() then
					SeekingMissileShared._run(instance)
				end
			end
		end
		instance.runMaid:DoCleaning()
		if (p2.targetPartObj.Value or SeekingMissileUtils.getTargetPos(p1)) and p12:GetOwner() then
			SeekingMissileShared._run(instance)
		end
		instance.maid:GiveTask(p2.targetPartObj.Changed:Connect(handle))
		instance.maid:GiveTask(SeekingMissileUtils.getTargetPosChangedSignal(p1):Connect(handle))
		instance.maid:GiveTask(p12:GetOwnerChangedSignal():Connect(handle))
	end))
	return instance
end
function t.SetTargetPart(p1, p2)
	p1.targetPartObj.Value = p2
end
function t.SetTargetPos(p1, p2)
	SeekingMissileUtils.setTargetPos(p1.obj, p2)
end
return ManifestBinder.new(SeekingMissileConsts.TAG_NAME, {
	alignOrientation = SeekingMissileConsts.ALIGN_ORIENTATION_NAME,
	vectorForce = SeekingMissileConsts.VECTOR_FORCE_NAME,
	targetPartObj = SeekingMissileConsts.TARGET_PART_OBJ_NAME,
	applyingThrustRemote = SeekingMissileConsts.APPLYING_THRUST_REMOTE_NAME,
	explodeRemote = SeekingMissileConsts.EXPLODE_REMOTE_NAME
}, t)
