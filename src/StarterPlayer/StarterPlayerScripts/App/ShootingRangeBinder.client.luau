local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
Binder.new("ShootingRangeTarget", function(p1) --[[ Line: 8 | Upvalues: Maid (copy), DoorUtils (copy), Promise (copy) ]]
	local v1 = Maid.new()
	local v2 = true
	local v3 = nil
	v1:GiveTask(function() --[[ Line: 13 | Upvalues: v2 (ref), v3 (ref) ]]
		v2 = false
		if v3 then
			v3:cancel()
		end
	end)
	v1:GivePromise(DoorUtils.promiseInnerModel(p1):andThen(function(p12) --[[ Line: 19 | Upvalues: v2 (ref), v3 (ref), Promise (ref), DoorUtils (ref), p1 (copy) ]]
		task.wait(0.5)
		local ShootingRangePart = p12:FindFirstChild("ShootingRangePart")
		if ShootingRangePart then
			ShootingRangePart.CanCollide = true
		end
		while v2 do
			v3 = Promise.resolve():andThenCall(DoorUtils.setOpen, p1, not DoorUtils.getOpen(p1)):andThenCall(Promise.delay, DoorUtils.getDuration(p1) or 1)
			v3:await()
		end
	end))
	return v1
end):Start()