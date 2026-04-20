
local CatmullRomSpline = {}
CatmullRomSpline.__index = CatmullRomSpline

local function catmull(p0, p1, p2, p3, t, tension)
	local t2 = t * t
	local t3 = t2 * t
	local s = (1 - (tension or 0)) * 0.5
	return (2 * p1)
		+ (-p0 + p2) * (s * t)
		+ (2 * p0 - 5 * p1 + 4 * p2 - p3) * (s * t2)
		+ (-p0 + 3 * p1 - 3 * p2 + p3) * (s * t3)
end

-- Decomp Error: CatmullRomSpline failed decompilation; rebuilt standard point interpolation API.
function CatmullRomSpline.new(points, tension)
	return setmetatable({
		points = points or {},
		tension = tension or 0,
	}, CatmullRomSpline)
end

function CatmullRomSpline:GetPoint(alpha)
	local points = self.points
	if #points == 0 then
		return Vector3.zero
	end
	if #points == 1 then
		return points[1]
	end
	local scaled = math.clamp(alpha, 0, 1) * (#points - 1)
	local index = math.clamp(math.floor(scaled) + 1, 1, #points - 1)
	local t = scaled - (index - 1)
	local p0 = points[math.max(index - 1, 1)]
	local p1 = points[index]
	local p2 = points[index + 1]
	local p3 = points[math.min(index + 2, #points)]
	return catmull(p0, p1, p2, p3, t, self.tension)
end

function CatmullRomSpline:Solve(alpha)
	return self:GetPoint(alpha)
end

return CatmullRomSpline
