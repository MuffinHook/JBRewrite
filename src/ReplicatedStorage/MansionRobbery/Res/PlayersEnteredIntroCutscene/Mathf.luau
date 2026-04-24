-- Reviewed by Claude
local t = {
	FrameDelta = function(p1, p2)
		return 1 - (1 - p1) ^ (p2 * 60)
	end,
	SafeLerp = function(p1, p2, p3)
		if p1 == nil or p3 >= 1 then
			return p2
		elseif p2 == nil or p3 <= 0 then
			return p1
		elseif typeof(p1) == "Color3" then
			local v1 = 1 - p3
			return Color3.new((p1.R ^ 2 * v1 + p2.R ^ 2 * p3) ^ 0.5, (p1.G ^ 2 * v1 + p2.G ^ 2 * p3) ^ 0.5, (p1.B ^ 2 * v1 + p2.B ^ 2 * p3) ^ 0.5)
		else
			return p1 * (1 - p3) + p2 * p3
		end
	end,
	PercentBetween = function(p1, p2, p3)
		if p3 - p2 == 0 then
			return 1
		else
			return math.clamp((p1 - p2) / (p3 - p2), 0, 1)
		end
	end,
	Round = function(p1, p2, p3)
		return math.floor(p1 / p2 + (p3 or 0.5)) * p2
	end,
	RoundNumber = function(p1)
		return p1 >= 0 and math.floor(p1 + 0.5) or math.ceil(p1 - 0.5)
	end,
	Lerp = function(p1, p2, p3)
		return p1 * (1 - p3) + p2 * p3
	end,
	SmoothLerp = function(p1, p2, p3, p4)
		local v1 = 1 - math.pow(1 - p3, p4)
		if type(p1) == "number" then
			return (1 - v1) * p1 + p2 * v1
		else
			return p1:Lerp(p2, v1)
		end
	end,
	LerpTowards = function(p1, p2, p3)
		if p1 < p2 then
			return math.clamp(p1 + p3, p1, p2)
		else
			return math.clamp(p1 - p3, p2, p1)
		end
	end,
	Wrap = function(p1, p2, p3)
		return p2 + (p1 - p2) % (p3 - p2)
	end,
	Cubic_Interpolate = function(p1, p2, p3, p4, p5)
		local v1 = p4 - p3 - (p1 - p2)
		return v1 * p5 ^ 3 + (p1 - p2 - v1) * p5 ^ 2 + (p3 - p1) * p5 + p2
	end,
	SlerpVector = function(p1, p2, p3)
		return CFrame.new(Vector3.new(0, 0, 0), p1):Lerp(CFrame.new(Vector3.new(0, 0, 0), p2), p3).LookVector
	end,
	RandomizeVector = function(p1, p2, p3)
		local v1 = CFrame.new(Vector3.new(), p2) * CFrame.Angles(0, 0, p1:NextNumber(0, 6.283185307179586))
		local Angles = CFrame.Angles
		return (v1 * Angles(math.acos((p1:NextNumber(math.cos(p3), 1))), 0, 0)).LookVector * p2.Magnitude
	end,
	LerpColor3 = function(p1, p2, p3)
		local v1 = 1 - p3
		return Color3.new((p1.R ^ 2 * v1 + p2.R ^ 2 * p3) ^ 0.5, (p1.G ^ 2 * v1 + p2.G ^ 2 * p3) ^ 0.5, (p1.B ^ 2 * v1 + p2.B ^ 2 * p3) ^ 0.5)
	end,
	InPart = function(p1, p2, p3)
		local v1 = p1.CFrame:PointToObjectSpace(p2)
		local v2 = p1.Size * (p3 or 1)
		if math.abs(v1.x) <= v2.x / 2 and (math.abs(v1.y) <= v2.y / 2 and math.abs(v1.z) <= v2.z / 2) then
			return true
		else
			return false
		end
	end,
	IK = function(p1, p2, p3, p4)
		if p3 + p4 <= (p1 - p2).magnitude then
			return CFrame.new(p1, p2), 0, 0
		elseif (p1 - p2).magnitude < math.max(p3, p4) - math.min(p3, p4) then
			return CFrame.new(p1, p2), 0, math.pi
		else
			local v1 = CFrame.new(p1, p2)
			local v2 = v1:pointToObjectSpace(p2)
			local v3 = (v2.z ^ 2 - p4 ^ 2 + p3 ^ 2) / (2 * v2.z)
			local v4 = math.sqrt(1 - (v3 / p3) ^ 2) * p3
			local v5 = -math.asin(v4 / (v3 ^ 2 + v4 ^ 2) ^ 0.5)
			local v6, v7
			if v3 < v2.z then
				v6 = -3.141592653589793 + math.asin(-v4 / ((v2.z - v3) ^ 2 + v4 ^ 2) ^ 0.5)
				if not v6 then
					v7 = -v4 / ((v2.z - v3) ^ 2 + v4 ^ 2) ^ 0.5
					v6 = -math.asin(v7)
				end
			else
				v7 = -v4 / ((v2.z - v3) ^ 2 + v4 ^ 2) ^ 0.5
				v6 = -math.asin(v7)
			end
			return v1, v5, v6 - v5
		end
	end,
	Vector3ToPixel = function(p1, p2, p3)
		local X = p3.AbsoluteSize.X
		local Y = p3.AbsoluteSize.Y
		local v1 = (p2.CoordinateFrame * CFrame.Angles(0, 0, -p2:GetRoll())):inverse() * p1
		local v3 = 1 / math.tan(math.rad(p2.FieldOfView) / 2)
		local v4 = X / 2 * (1 + v1.x / -v1.z * v3 * Y / X)
		local v5 = Y / 2 * (1 + v1.y / -v1.z * v3)
		if v1.z > 0 then
			v4 = 20000
			v5 = 20000
		end
		return v4, Y - v5 - 36
	end,
	LerpAngle = function(p1, p2, p3)
		return (if p1 - p2 < 180 then p1 + (p2 - p1) * p3 else p1 + (360 + p2 - p1) * p3 - 180) % 360 - 180
	end
}
function t.LerpTowardsAngle(p1, p2, p3)
	if math.abs(p2 - p1) > 180 then
		if p2 < p1 then
			p1 = p1 + 360
		else
			p2 = p2 + 360
		end
	end
	return t.LerpTowards(p1, p2, p3)
end
function t.LerpAngle2(p1, p2, p3)
	local sum = p1 + 180
	local sum_2 = p2 + 180
	difference = math.abs(sum_2 - sum)
	if difference > 180 then
		if sum < sum_2 then
			sum_2 = sum_2 - 360
		else
			sum = sum - 360
		end
	end
	return t.Wrap(t.Lerp(sum - 180, sum_2 - 180, p3), -180, 180)
end
function t.AngleDistance(p1, p2)
	local v1 = math.deg(p1)
	local v2 = math.deg(p2)
	difference = math.abs(v2 - v1)
	local v3, v4
	if difference > 180 then
		if v2 < v1 then
			v3 = v1
			v4 = v2 + 360
		else
			v3 = v1 + 360
			v4 = v2
		end
	else
		v3 = v1
		v4 = v2
	end
	return math.rad(v3 - v4)
end
function t.InterpolateCFrame(p1, p2, p3)
	return if p3 < 0.001 and p1 then p1 elseif p3 > 0.999 and p2 then p2 else p1:lerp(p2, p3)
end
return t
