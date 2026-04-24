-- Reviewed by Claude
-- variables reassigned
local t = {
	calculateVelocityForDesiredDistance = function(p1, p2, p3)
		assert(typeof(p1) == "number")
		assert(typeof(p2) == "number")
		assert(typeof(p3) == "number")
		if p2 / p3 < 0 then
			return -p2 + math.sqrt(-p3 * 2 * (p2 ^ 2 / (-p3 * 2) + p1))
		else
			return -p2 + math.sqrt(-p3 * 2 * p1)
		end
	end
}
function t.calculateVelocityForDesiredHeight(p1, p2)
	return t.calculateVelocityForDesiredDistance(p1, p2, -workspace.Gravity)
end
function t.calculateTimeForDesiredHeight(p1)
	return math.sqrt(p1 * 2 / workspace.Gravity)
end
return t
