local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local RunService = game:GetService("RunService")
local SeekingMissileUtils = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
require(ReplicatedStorage.Std.Raycast)
local t = {
	_init = function(missile)
		missile._throttle = 1
		missile.forwardDrag = SeekingMissileUtils.getForwardDrag(missile.obj)
		missile.lateralDrag = SeekingMissileUtils.getLateralDrag(missile.obj)
		missile.ignoreList = { missile.obj }
		missile.raycastParams = RaycastParams.new()
		missile.raycastParams.FilterDescendantsInstances = missile.ignoreList
		missile._lastTargetPosition = nil
		missile._seeking = false
		missile._onFireExplodeRemote = Signal.new()
		missile.maid:GiveTask(missile._onFireExplodeRemote)
		missile.onExploded = Signal.new()
		missile.maid:GiveTask(missile.onExploded)
		missile.flagApplyingThrust = false
		missile.onApplyingThrustChanged = Signal.new()
		missile.maid:GiveTask(missile.onApplyingThrustChanged)
	end,
	_getTargetPosition = function(missile)
		local targetPosition = SeekingMissileUtils.getTargetPos(missile.obj)
		local targetPartObj = missile.targetPartObj.Value
		if targetPartObj then
			targetPosition = targetPartObj.Position
		end
		return targetPosition
	end
}
function t._run(missile)
	missile.lastDistance = (1 / 0)
	missile.lastDistanceImprovement = 0
	local hasReachedLifespan = false
	local hasConnected = false
	local isSeeking = false
	local launchTime = os.clock()
	local targetVelocityMagnitude = 0
	local Position = missile.obj.Position
	missile.runMaid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
		local currentTime = os.clock()
		local obj = missile.obj
		local AssemblyMass = obj.AssemblyMass
		local targetPosition = t._getTargetPosition(missile)
		assert(targetPosition ~= nil, "missing targetPosition")
		local previousTargetPosition = missile._lastTargetPosition or targetPosition
		missile._lastTargetPosition = targetPosition
		local localVelocity = obj.CFrame:VectorToObjectSpace(obj.AssemblyLinearVelocity)
		local forwardVelocity = Vector3.new(0, 0, localVelocity.Z)
		local lateralVelocity = localVelocity - forwardVelocity
		local forwardSpeed = math.abs(localVelocity.Z)
		local forwardVelocityMagnitude = localVelocity.Magnitude
		local targetPositionDelta = targetPosition - previousTargetPosition
		local distanceToTarget = (targetPosition - obj.Position).Magnitude
		targetVelocityMagnitude = (targetVelocityMagnitude * 24 + targetPositionDelta.Magnitude / deltaTime) / 25
		local _throttle = missile._throttle
		local var11 = 1
		local Position_2 = obj.Position
		local interceptPosition
		if targetPositionDelta.Magnitude > 0.1 then
			local var13 = targetVelocityMagnitude
			local Unit = targetPositionDelta.Unit
			if distanceToTarget < 500 then
				var11 = if math.max(400, targetVelocityMagnitude * 5 / 3) < forwardVelocityMagnitude then _throttle * 0.95 else _throttle * 1.05
			end
			local var15 = GeomUtils.getTrajectoryInterceptTime(Position_2, forwardSpeed, targetPosition, var13, Unit) or 0
			interceptPosition = if var15 > 0 then targetPosition + Unit * var13 * var15 else targetPosition
		else
			interceptPosition = targetPosition
		end
		local var16 = math.clamp(_throttle + (var11 - _throttle) * 0.9, 0, 1)
		missile._throttle = var16
		if missile._seeking then
			missile.alignOrientation.CFrame = CFrame.lookAt(obj.Position, interceptPosition)
		else
			missile.alignOrientation.CFrame = obj.CFrame
		end
		local throttleValue, shouldApplyThrust
		if currentTime - launchTime > SeekingMissileUtils.getDropDuration(obj) then
			throttleValue = var16
			shouldApplyThrust = true
		else
			throttleValue = var16
			shouldApplyThrust = false
		end
		if shouldApplyThrust ~= missile.flagApplyingThrust then
			missile.flagApplyingThrust = shouldApplyThrust
			missile.onApplyingThrustChanged:Fire(shouldApplyThrust)
		end
		local forceVector
		if shouldApplyThrust then
			local var20 = -missile.lateralDrag * lateralVelocity
			if not missile._currentLateralForce then
				missile._currentLateralForce = var20
			end
			missile._currentLateralForce = missile._currentLateralForce:Lerp(var20, if deltaTime <= 0.02 then 1 elseif deltaTime <= 0.05 then 0.3 else 0.1)
			local var23 = -missile.forwardDrag * forwardVelocity * math.abs(forwardVelocity.Magnitude)
			forceVector = Vector3.new(0, 0, -1) * AssemblyMass * 9.81 * 20 * SeekingMissileUtils.getAccel(obj) * throttleValue + var23 + missile._currentLateralForce
		else
			forceVector = Vector3.new(0, 0, 0)
		end
		missile.vectorForce.Force = forceVector
		local Magnitude_3 = (targetPosition - obj.Position).Magnitude
		local var24 = SeekingMissileUtils.getLifeSpan(obj)
		if missile._seeking then
			if Magnitude_3 < missile.lastDistance - 0.1 then
				missile.lastDistanceImprovement = currentTime
			end
			if currentTime - missile.lastDistanceImprovement > SeekingMissileUtils.getNoImprovementExplodeDuration(obj) then
				t._explode(missile)
			end
			missile.lastDistance = Magnitude_3
			local var27 = math.min(1, (currentTime - launchTime) / var24)
			local var28 = var27 * 12 + (1 - var27) * 3
			if Magnitude_3 <= var28 then
				t._explode(missile)
			end
			if GeomUtils.calcRayIntersectSphere(Position, Position_2, targetPosition, var28) then
				t._explode(missile)
			end
		end
		if not hasReachedLifespan and var24 <= currentTime - launchTime then
			hasReachedLifespan = true
			t._explode(missile)
		end
		if not hasConnected and currentTime - launchTime > SeekingMissileUtils.getConnectHitAfterDuration(obj) then
			hasConnected = true
			t._detectHit(missile)
		end
		if not isSeeking and currentTime - launchTime > SeekingMissileUtils.getSeekAfterDuration(obj) then
			isSeeking = true
			t._enableSeeking(missile)
		end
		Position = Position_2
	end))
	missile.alignOrientation.MaxTorque = 10000000000000
	missile.runMaid:GiveTask(function()
		missile.vectorForce.Force = Vector3.new()
		missile.alignOrientation.MaxTorque = 0
	end)
end
function t._explode(missile)
	if not missile._didExplode then
		missile._didExplode = true
		local targetPartObj = missile.targetPartObj.Value
		missile.onExploded:Fire(missile.obj.Position, targetPartObj, if targetPartObj then targetPartObj.CFrame:PointToObjectSpace(missile.obj.Position) else nil)
		task.defer(missile.runMaid.DoCleaning, missile.runMaid)
	end
end
function t._detectHit(missile)
	if not missile._didExplode then
		missile.runMaid:GiveTask(missile.obj.Touched:Connect(function(touchedPart)
			if not (touchedPart.Transparency > 0.5) then
				for ignorePartIndex, ignorePart in missile.ignoreList do
					if touchedPart:IsDescendantOf(ignorePart) then
						return false
					end
				end
				t._explode(missile)
			end
		end))
	end
end
function t._enableSeeking(missile)
	missile._seeking = true
end
return t
