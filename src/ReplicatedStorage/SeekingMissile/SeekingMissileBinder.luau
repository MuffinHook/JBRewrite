local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetworkOwnedBinder = require(ReplicatedStorage.NetworkOwned.NetworkOwnedBinder)
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local SeekingMissileShared = require(ReplicatedStorage.SeekingMissile.SeekingMissileShared)
local SeekingMissileUtils = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
local SeekingMissileBinder = {}
SeekingMissileBinder.__index = SeekingMissileBinder
setmetatable(SeekingMissileBinder, BaseObject)
function SeekingMissileBinder.new(missileInstance, config)
	local instance = BaseObject.new(missileInstance)
	setmetatable(instance, SeekingMissileBinder)
	instance.alignOrientation = config.alignOrientation
	instance.vectorForce = config.vectorForce
	instance.targetPartObj = config.targetPartObj
	instance.runMaid = Maid.new()
	instance.maid:GiveTask(instance.runMaid)
	SeekingMissileShared._init(instance)
	instance.maid:GiveTask(instance.onApplyingThrustChanged:Connect(function()
		config.applyingThrustRemote:FireServer(instance.flagApplyingThrust)
	end))
	instance.maid:GiveTask(instance.onExploded:Connect(function(...)
		config.explodeRemote:FireServer(...)
	end))
	instance.maid:GiveTask(config.explodeRemote.OnClientEvent:Connect(function(...)
		instance.onExploded:Fire(...)
	end))
	instance.maid:GivePromise(NetworkOwnedBinder:Promise(missileInstance):andThen(function(networkOwnedBinder)
		local function handle()
			instance.runMaid:DoCleaning()
			if config.targetPartObj.Value or SeekingMissileUtils.getTargetPos(missileInstance) then
				if networkOwnedBinder:GetOwner() then
					SeekingMissileShared._run(instance)
				end
			end
		end
		instance.runMaid:DoCleaning()
		if (config.targetPartObj.Value or SeekingMissileUtils.getTargetPos(missileInstance)) and networkOwnedBinder:GetOwner() then
			SeekingMissileShared._run(instance)
		end
		instance.maid:GiveTask(config.targetPartObj.Changed:Connect(handle))
		instance.maid:GiveTask(SeekingMissileUtils.getTargetPosChangedSignal(missileInstance):Connect(handle))
		instance.maid:GiveTask(networkOwnedBinder:GetOwnerChangedSignal():Connect(handle))
	end))
	return instance
end
function SeekingMissileBinder.SetTargetPart(instance, targetPart)
	instance.targetPartObj.Value = targetPart
end
function SeekingMissileBinder.SetTargetPos(instance, position)
	SeekingMissileUtils.setTargetPos(instance.obj, position)
end
return ManifestBinder.new(SeekingMissileConsts.TAG_NAME, {
	alignOrientation = SeekingMissileConsts.ALIGN_ORIENTATION_NAME,
	vectorForce = SeekingMissileConsts.VECTOR_FORCE_NAME,
	targetPartObj = SeekingMissileConsts.TARGET_PART_OBJ_NAME,
	applyingThrustRemote = SeekingMissileConsts.APPLYING_THRUST_REMOTE_NAME,
	explodeRemote = SeekingMissileConsts.EXPLODE_REMOTE_NAME
}, SeekingMissileBinder)
