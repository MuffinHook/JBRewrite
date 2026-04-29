local module = {}
local cos = math.cos
local sin = math.sin
local tick = tick
local vector3 = Vector3.new
module.Spring = {}
module.NumberSpring = {}
module.VectorSpring = {}
local function New(targetValue)
	local lastUpdateTime = tick()
	local targetPosition = targetValue or 0
	local currentPosition = targetValue or 0
	local currentVelocity = targetValue and 0 * targetValue or 0
	local damper = 1
	local speed = 1
	local springObject = nil
	local function PositionVelocity(currentTime)
		local elapsedTime = currentTime - lastUpdateTime
		local offsetFromTarget = currentPosition - targetPosition
		if speed == 0 then
			return currentPosition, 0
		elseif damper < 1 then
			local dampingRatio = (1 - damper * damper) ^ 0.5
			local scaledAcceleration = (currentVelocity / speed + damper * offsetFromTarget) / dampingRatio
			local cosineValue = cos(dampingRatio * speed * elapsedTime)
			local sineValue = sin(dampingRatio * speed * elapsedTime)
			local exponentialDecay = math.exp(1) ^ (damper * speed * elapsedTime)
			return targetPosition + (offsetFromTarget * cosineValue + scaledAcceleration * sineValue) / exponentialDecay, speed * ((dampingRatio * scaledAcceleration - damper * offsetFromTarget) * cosineValue - (dampingRatio * offsetFromTarget + damper * scaledAcceleration) * sineValue) / exponentialDecay
		else
			local adjustedVelocity = currentVelocity / speed + offsetFromTarget
			local exponentialDecay = math.exp(1) ^ (speed * elapsedTime)
			return targetPosition + (offsetFromTarget + adjustedVelocity * speed * elapsedTime) / exponentialDecay, speed * (adjustedVelocity - offsetFromTarget - adjustedVelocity * speed * elapsedTime) / exponentialDecay
		end
	end
	springObject = setmetatable({
		Impulse = function(self, impulseForce)
			springObject.Velocity = springObject.Velocity + impulseForce
		end,
		TimeSkip = function(self, skipDuration)
			local currentTime = tick()
			local newPosition, newVelocity = PositionVelocity(currentTime + skipDuration)
			currentPosition = newPosition
			currentVelocity = newVelocity
			lastUpdateTime = currentTime
		end
	}, {
		__index = function(self, propertyName)
			if propertyName == "Value" or (propertyName == "Position" or propertyName == "p") then
				local position, _ = PositionVelocity(tick())
				return position
			end
			if propertyName == "Velocity" or propertyName == "v" then
				local _, velocity = PositionVelocity(tick())
				return velocity
			end
			if propertyName == "Target" or propertyName == "t" then
				return targetPosition
			end
			if propertyName == "Damper" or propertyName == "d" then
				return damper
			end
			if propertyName == "Speed" or propertyName == "s" then
				return speed
			end
			error(propertyName .. " is not a valid member of Spring")
		end,
		__newindex = function(self, propertyName, newValue)
			local currentTime = tick()
			if propertyName == "Value" or (propertyName == "Position" or propertyName == "p") then
				local _, velocity = PositionVelocity(currentTime)
				currentPosition = newValue
				currentVelocity = velocity
			elseif propertyName == "Velocity" or propertyName == "v" then
				local position, _ = PositionVelocity(currentTime)
				currentPosition = position
				currentVelocity = newValue
			elseif propertyName == "Target" or propertyName == "t" then
				local position, velocity = PositionVelocity(currentTime)
				currentPosition = position
				currentVelocity = velocity
				targetPosition = newValue
			elseif propertyName == "Damper" or propertyName == "d" then
				local position, velocity = PositionVelocity(currentTime)
				currentPosition = position
				currentVelocity = velocity
				damper = if newValue < 0 then 0 elseif newValue < 1 then newValue else 1
			elseif propertyName == "Speed" or propertyName == "s" then
				local position, velocity = PositionVelocity(currentTime)
				currentPosition = position
				currentVelocity = velocity
				speed = if newValue < 0 then 0 else newValue
			else
				error(propertyName .. " is not a valid member of Spring")
			end
			lastUpdateTime = currentTime
		end
	})
	return springObject
end
module.Spring.New = New
local function New_2(targetValue)
	return module.Spring.New(targetValue)
end
module.NumberSpring.New = New_2
local function New_3(targetValue)
	return module.Spring.New(targetValue or vector3())
end
module.VectorSpring.New = New_3
return module
