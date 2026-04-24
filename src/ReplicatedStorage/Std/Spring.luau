-- Reviewed by Claude
-- variables reassigned
local exp = math.exp
local cos = math.cos
local sin = math.sin
local Spring = {}
Spring.__index = Spring
function Spring.new(initialPosition, initialVelocity, dampingRatio, frequency)
	assert(initialPosition)
	assert(initialVelocity)
	assert(dampingRatio)
	assert(frequency)
	local spring = setmetatable({}, Spring)
	spring.p = initialPosition
	spring.v = initialVelocity
	spring.Target = spring.p
	spring.Freq = frequency
	spring.Damp = dampingRatio
	spring.t = tick()
	return spring
end
function Spring.Update(self)
	local elapsedTime = tick() - self.t
	local Freq = self.Freq
	local Damp = self.Damp
	local v = self.v
	local Target = self.Target
	local positionDelta = self.p - Target
	if Damp > 1 then
		local lambda1 = -Freq * Damp
		local lambda2 = Freq * (Damp * Damp - 1) ^ 0.5
		local root1 = lambda1 - lambda2
		local root2 = lambda1 + lambda2
		local exp1 = exp(root1 * elapsedTime)
		local exp2 = exp(root2 * elapsedTime)
		local c1 = (v - positionDelta * root2) / (-2 * lambda2)
		local c2 = positionDelta - c1
		return Target + c1 * exp1 + c2 * exp2, c1 * root1 * exp1 + c2 * root2 * exp2
	elseif Damp == 1 then
		local expDecay = exp(-Freq * elapsedTime)
		local velocityTerm = v + Freq * positionDelta
		local positionTerm = (velocityTerm * elapsedTime + positionDelta) * expDecay
		return Target + positionTerm, velocityTerm * expDecay - positionTerm * Freq
	else
		local dampingCoeff = Freq * Damp
		local oscillationFreq = Freq * (1 - Damp * Damp) ^ 0.5
		local expDecay = exp(-dampingCoeff * elapsedTime)
		local cosComponent = cos(oscillationFreq * elapsedTime)
		local sinComponent = sin(oscillationFreq * elapsedTime)
		local amplitudeTerm = (v + dampingCoeff * positionDelta) / oscillationFreq
		return Target + expDecay * (positionDelta * cosComponent + amplitudeTerm * sinComponent), -expDecay * ((positionDelta * dampingCoeff - amplitudeTerm * oscillationFreq) * cosComponent + (positionDelta * oscillationFreq + amplitudeTerm * dampingCoeff) * sinComponent)
	end
end
function Spring.SetTarget(self, newTarget)
	local position, velocity = self:Update()
	self.p = position
	self.v = velocity
	self.Target = newTarget
	self.t = tick()
	return position, velocity
end
function Spring.Accelerate(self, acceleration)
	local position, velocity = self:Update()
	self.t = tick()
	self.p = position
	self.v = velocity + acceleration
end
function Spring.ForceTarget(self, newTarget)
	self.p = newTarget
	self.v = newTarget * 0
	self.Target = self.p
	self.t = tick()
end
function Spring.SetConsts(self, newDamping, newFrequency)
	local position, velocity = self:Update()
	self.p = position
	self.v = velocity
	self.Damp = newDamping
	self.Freq = newFrequency
	self.t = tick()
	return position, velocity
end
return Spring
