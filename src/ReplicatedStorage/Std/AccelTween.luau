
local AccelTween = {}

function AccelTween.new(acceleration)
	return setmetatable({
		_accel = acceleration or 1,
		_t0 = 0,
		_y0 = 0,
		_a0 = 0,
		_t1 = 0,
		_y1 = 0,
		_a1 = 0
	}, AccelTween)
end

function AccelTween.__index(self, index)
	if AccelTween[index] then
		return AccelTween[index]
	end

	if index == "p" then
		local position = self:_getstate(os.clock())
		return position
	elseif index == "v" then
		local _, velocity = self:_getstate(os.clock())
		return velocity
	elseif index == "a" then
		return self._accel
	elseif index == "t" then
		return self._y1
	elseif index == "rtime" then
		local currentTime = os.clock()
		return currentTime < self._t1 and self._t1 - currentTime or 0
	end

	error(("Bad index %q"):format(tostring(index)))
end

function AccelTween.__newindex(self, index, value)
	if index == "p" then
		self:_setstate(value, nil, nil, nil)
	elseif index == "v" then
		self:_setstate(nil, value, nil, nil)
	elseif index == "a" then
		self:_setstate(nil, nil, value, nil)
	elseif index == "t" then
		self:_setstate(nil, nil, nil, value)
	elseif index == "pt" then
		self:_setstate(value, 0, nil, value)
	else
		error(("Bad index %q"):format(tostring(index)))
	end
end

function AccelTween._getstate(self, queryTime)
	if queryTime < (self._t0 + self._t1) / 2 then
		local elapsedTime = queryTime - self._t0
		return self._y0 + elapsedTime * elapsedTime / 2 * self._a0, elapsedTime * self._a0
	elseif queryTime < self._t1 then
		local remainingAccelTime = queryTime - self._t1
		return self._y1 + remainingAccelTime * remainingAccelTime / 2 * self._a1, remainingAccelTime * self._a1
	else
		return self._y1, 0
	end
end

function AccelTween._setstate(self, targetPosition, currentVelocity, newAcceleration, endPosition)
	local currentTime = os.clock()
	local currentPos, currentVel = self:_getstate(currentTime)

	local position = if targetPosition ~= nil then targetPosition else currentPos
	local velocity = if currentVelocity ~= nil then currentVelocity else currentVel

	self._accel = if newAcceleration ~= nil then newAcceleration else self._accel

	local finalPosition = if endPosition ~= nil then endPosition else self._y1

	if self._accel * self._accel < 1e-8 then
		self._t0 = 0
		self._y0 = position
		self._a0 = 0
		self._t1 = math.huge
		self._y1 = finalPosition
		self._a1 = 0
	else
		local isMovingUp = finalPosition < position
		local isVelocityNegative = velocity < 0
		local exceededTarget = position + velocity * velocity / (2 * self._accel) < finalPosition

		if isMovingUp and (isVelocityNegative and position - velocity * velocity / (2 * self._accel) < finalPosition) then
			self._a0 = self._accel
			self._t1 = currentTime + ((2 * velocity * velocity + 4 * self._accel * (finalPosition - position)) ^ 0.5 - velocity) / self._accel
		elseif isMovingUp or not isVelocityNegative and (isVelocityNegative or not exceededTarget) then
			self._a0 = -self._accel
			self._t1 = currentTime + ((2 * velocity * velocity - 4 * self._accel * (finalPosition - position)) ^ 0.5 + velocity) / self._accel
		else
			self._a0 = self._accel
			self._t1 = currentTime + ((2 * velocity * velocity + 4 * self._accel * (finalPosition - position)) ^ 0.5 - velocity) / self._accel
		end

		self._t0 = currentTime - velocity / self._a0
		self._y0 = position - velocity * velocity / (2 * self._a0)
		self._y1 = finalPosition
		self._a1 = -self._a0
	end
end

return AccelTween
