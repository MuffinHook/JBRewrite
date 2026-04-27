local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local SimulatedPhysicsProjectile = {}
SimulatedPhysicsProjectile.__index = SimulatedPhysicsProjectile
function SimulatedPhysicsProjectile.new(initialOrigin)
	local instance = setmetatable({}, SimulatedPhysicsProjectile)
	instance.Origin = initialOrigin
	instance.Target = nil
	instance.Velocity = nil
	instance._PrevUpdatePosition = instance.Origin
	instance._GetNow = os.clock
	instance.Birthdate = instance:_GetNow()
	instance.Gravity = workspace.Gravity
	instance.CollidableFunc = nil
	instance._GravityVector = Vector3.new(0, -instance.Gravity, 0)
	instance.IgnoreList = {}
	return instance
end
function SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(originPosition, targetPosition, initialSpeed, gravityMagnitude, preferHigherAngle)
	local positionDelta = targetPosition - originPosition
	local horizontalDistance = (positionDelta.x * positionDelta.x + positionDelta.z * positionDelta.z) ^ 0.5
	local discriminant = initialSpeed * initialSpeed * initialSpeed * initialSpeed - gravityMagnitude * (gravityMagnitude * horizontalDistance * horizontalDistance + 2 * positionDelta.y * initialSpeed * initialSpeed)
	local launchAngle
	if discriminant >= 0 then
		local discriminantSqrt = discriminant ^ 0.5
		local higherAngle = math.atan((initialSpeed * initialSpeed + discriminantSqrt) / (gravityMagnitude * horizontalDistance))
		local lowerAngle = math.atan((initialSpeed * initialSpeed - discriminantSqrt) / (gravityMagnitude * horizontalDistance))
		launchAngle = if preferHigherAngle then math.max(higherAngle, lowerAngle) else math.min(higherAngle, lowerAngle)
	else
		launchAngle = math.pi / 4
	end
	local velocityX = initialSpeed * positionDelta.x / horizontalDistance * math.cos(launchAngle)
	local velocityY = initialSpeed * math.sin(launchAngle)
	return Vector3.new(velocityX, velocityY, initialSpeed * positionDelta.z / horizontalDistance * math.cos(launchAngle)), horizontalDistance / (initialSpeed * math.cos(launchAngle))
end
function SimulatedPhysicsProjectile.HitTargetWithSpeed(self, targetPosition, desiredSpeed, preferHigherAngle)
	self.Target = targetPosition
	local calculatedVelocity, timeToHit = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(self.Origin, targetPosition, desiredSpeed, self.Gravity, preferHigherAngle)
	self.Velocity = calculatedVelocity
	self.Duration = timeToHit
	return true
end
function SimulatedPhysicsProjectile.CalculateElapsedPosition(self, elapsedTime)
	assert(elapsedTime ~= nil)
	return self.Origin + self.Velocity * elapsedTime + 0.5 * self._GravityVector * elapsedTime * elapsedTime
end
function SimulatedPhysicsProjectile.Step(self, currentTime, previousPosition)
	assert(currentTime)
	assert(self.Velocity)
	local projectedPosition = self:CalculateElapsedPosition(currentTime - self.Birthdate)
	local rayDirection = projectedPosition - previousPosition
	local hitInstance, hitPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(previousPosition, rayDirection.Unit, rayDirection.Magnitude, self.IgnoreList, nil, nil, self.CollidableFunc)
	if hitInstance then
		return hitPosition, true, hitInstance
	else
		return projectedPosition, false
	end
end
function SimulatedPhysicsProjectile.Update(self)
	local currentPosition, collided = self:Step(self:_GetNow(), self._PrevUpdatePosition)
	self._PrevUpdatePosition = currentPosition
	return currentPosition, collided
end
function SimulatedPhysicsProjectile.CalculateNextInstantCollision(self, timestep)
	local currentPosition, collided = self:Update()
	if collided then
		return currentPosition, 0
	else
		local FallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
		local currentTime = self:_GetNow()
		local startTime = currentTime
		local stepPosition
		while true do
			currentTime = currentTime + timestep
			local hasHit
			stepPosition, hasHit = self:Step(currentTime, currentPosition)
			if hasHit or stepPosition.y <= FallenPartsDestroyHeight then
				break
			end
			currentPosition = stepPosition
		end
		return stepPosition, currentTime - startTime
	end
end
function SimulatedPhysicsProjectile.GetElapsed(self)
	return self:_GetNow() - self.Birthdate
end
return SimulatedPhysicsProjectile
