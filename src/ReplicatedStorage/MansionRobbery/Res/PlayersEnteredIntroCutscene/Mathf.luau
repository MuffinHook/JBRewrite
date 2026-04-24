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
			local cframe = 1 - p3
			return Color3.new((p1.R ^ 2 * cframe + p2.R ^ 2 * p3) ^ 0.5, (p1.G ^ 2 * cframe + p2.G ^ 2 * p3) ^ 0.5, (p1.B ^ 2 * cframe + p2.B ^ 2 * p3) ^ 0.5)
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
		local cframe = 1 - math.pow(1 - p3, p4)
		if type(p1) == "number" then
			return (1 - cframe) * p1 + p2 * cframe
		else
			return p1:Lerp(p2, cframe)
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
		local cframe = p4 - p3 - (p1 - p2)
		return cframe * p5 ^ 3 + (p1 - p2 - cframe) * p5 ^ 2 + (p3 - p1) * p5 + p2
	end,
	SlerpVector = function(p1, p2, p3)
		return CFrame.new(Vector3.new(0, 0, 0), p1):Lerp(CFrame.new(Vector3.new(0, 0, 0), p2), p3).LookVector
	end,
	RandomizeVector = function(p1, p2, p3)
		local cframe = CFrame.new(Vector3.new(), p2) * CFrame.Angles(0, 0, p1:NextNumber(0, 6.283185307179586))
		local Angles = CFrame.Angles
		return (cframe * Angles(math.acos((p1:NextNumber(math.cos(p3), 1))), 0, 0)).LookVector * p2.Magnitude
	end,
	LerpColor3 = function(p1, p2, p3)
		local cframe = 1 - p3
		return Color3.new((p1.R ^ 2 * cframe + p2.R ^ 2 * p3) ^ 0.5, (p1.G ^ 2 * cframe + p2.G ^ 2 * p3) ^ 0.5, (p1.B ^ 2 * cframe + p2.B ^ 2 * p3) ^ 0.5)
	end,
	InPart = function(p1, p2, p3)
		local cframe = p1.CFrame:PointToObjectSpace(p2)
		local v2 = p1.Size * (p3 or 1)
		if math.abs(cframe.x) <= v2.x / 2 and (math.abs(cframe.y) <= v2.y / 2 and math.abs(cframe.z) <= v2.z / 2) then
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
			local cframe = CFrame.new(p1, p2)
			local v2 = cframe:pointToObjectSpace(p2)
			local var3 = (v2.z ^ 2 - p4 ^ 2 + p3 ^ 2) / (2 * v2.z)
			local var4 = math.sqrt(1 - (var3 / p3) ^ 2) * p3
			local var5 = -math.asin(var4 / (var3 ^ 2 + var4 ^ 2) ^ 0.5)
			local v6, v7
			if var3 < v2.z then
				v6 = -3.141592653589793 + math.asin(-var4 / ((v2.z - var3) ^ 2 + var4 ^ 2) ^ 0.5)
				if not v6 then
					v7 = -var4 / ((v2.z - var3) ^ 2 + var4 ^ 2) ^ 0.5
					v6 = -math.asin(v7)
				end
			else
				v7 = -var4 / ((v2.z - var3) ^ 2 + var4 ^ 2) ^ 0.5
				v6 = -math.asin(v7)
			end
			return cframe, var5, v6 - var5
		end
	end,
	Vector3ToPixel = function(p1, p2, p3)
		local X = p3.AbsoluteSize.X
		local Y = p3.AbsoluteSize.Y
		local cframe = (p2.CoordinateFrame * CFrame.Angles(0, 0, -p2:GetRoll())):inverse() * p1
		local var3 = 1 / math.tan(math.rad(p2.FieldOfView) / 2)
		local var4 = X / 2 * (1 + cframe.x / -cframe.z * var3 * Y / X)
		local var5 = Y / 2 * (1 + cframe.y / -cframe.z * var3)
		if cframe.z > 0 then
			var4 = 20000
			var5 = 20000
		end
		return var4, Y - var5 - 36
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
	local cframe = math.deg(p1)
	local v2 = math.deg(p2)
	difference = math.abs(v2 - cframe)
	local var3, var4
	if difference > 180 then
		if v2 < cframe then
			var3 = cframe
			var4 = v2 + 360
		else
			var3 = cframe + 360
			var4 = v2
		end
	else
		var3 = cframe
		var4 = v2
	end
	return math.rad(var3 - var4)
end
function t.InterpolateCFrame(p1, p2, p3)
	return if p3 < 0.001 and p1 then p1 elseif p3 > 0.999 and p2 then p2 else p1:lerp(p2, p3)
end
return t
