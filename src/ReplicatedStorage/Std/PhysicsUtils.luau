local PhysicsUtils = {
	calculateVelocityForDesiredDistance = function(distance, initialVelocity, acceleration)
		assert(typeof(distance) == "number")
		assert(typeof(initialVelocity) == "number")
		assert(typeof(acceleration) == "number")
		if initialVelocity / acceleration < 0 then
			return -initialVelocity + math.sqrt(-acceleration * 2 * (initialVelocity ^ 2 / (-acceleration * 2) + distance))
		else
			return -initialVelocity + math.sqrt(-acceleration * 2 * distance)
		end
	end
}
function PhysicsUtils.calculateVelocityForDesiredHeight(height, gravity)
	return PhysicsUtils.calculateVelocityForDesiredDistance(height, gravity, -workspace.Gravity)
end
function PhysicsUtils.calculateTimeForDesiredHeight(height)
	return math.sqrt(height * 2 / workspace.Gravity)
end
return PhysicsUtils
