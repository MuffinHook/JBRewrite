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
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.alignOrientation = p2.alignOrientation
	v1.vectorForce = p2.vectorForce
	v1.targetPartObj = p2.targetPartObj
	v1.runMaid = Maid.new()
	v1.maid:GiveTask(v1.runMaid)
	SeekingMissileShared._init(v1)
	v1.maid:GiveTask(v1.onApplyingThrustChanged:Connect(function()
		p2.applyingThrustRemote:FireServer(v1.flagApplyingThrust)
	end))
	v1.maid:GiveTask(v1.onExploded:Connect(function(...)
		p2.explodeRemote:FireServer(...)
	end))
	v1.maid:GiveTask(p2.explodeRemote.OnClientEvent:Connect(function(...)
		v1.onExploded:Fire(...)
	end))
	v1.maid:GivePromise(NetworkOwnedBinder:Promise(p1):andThen(function(p12)
		local function handle()
			v1.runMaid:DoCleaning()
			if p2.targetPartObj.Value or SeekingMissileUtils.getTargetPos(p1) then
				if p12:GetOwner() then
					SeekingMissileShared._run(v1)
				end
			end
		end
		v1.runMaid:DoCleaning()
		if (p2.targetPartObj.Value or SeekingMissileUtils.getTargetPos(p1)) and p12:GetOwner() then
			SeekingMissileShared._run(v1)
		end
		v1.maid:GiveTask(p2.targetPartObj.Changed:Connect(handle))
		v1.maid:GiveTask(SeekingMissileUtils.getTargetPosChangedSignal(p1):Connect(handle))
		v1.maid:GiveTask(p12:GetOwnerChangedSignal():Connect(handle))
	end))
	return v1
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
