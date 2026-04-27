local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
Binder.new("ShootingRangeTarget", function(shootingRangeTarget)
	local cleanupMaid = Maid.new()
	local isEnabled = true
	local togglePromise = nil
	cleanupMaid:GiveTask(function()
		isEnabled = false
		if togglePromise then
			togglePromise:cancel()
		end
	end)
	cleanupMaid:GivePromise(DoorUtils.promiseInnerModel(shootingRangeTarget):andThen(function(innerModel)
		task.wait(0.5)
		local ShootingRangePart = innerModel:FindFirstChild("ShootingRangePart")
		if ShootingRangePart then
			ShootingRangePart.CanCollide = true
		end
		while isEnabled do
			togglePromise = Promise.resolve():andThenCall(DoorUtils.setOpen, shootingRangeTarget, not DoorUtils.getOpen(shootingRangeTarget)):andThenCall(Promise.delay, DoorUtils.getDuration(shootingRangeTarget) or 1)
			togglePromise:await()
		end
	end))
	return cleanupMaid
end):Start()
