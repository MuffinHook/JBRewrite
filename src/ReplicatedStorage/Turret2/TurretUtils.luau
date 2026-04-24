-- Reviewed by Claude
return {
	computeHorizontalAngle = function(p1, p2, p3)
		assert(p3)
		assert(p2)
		assert(p2.Part1)
		local Base = p1:FindFirstChild("Base")
		assert(Base)
		local Arm = p1:FindFirstChild("Arm")
		assert(Arm)
		local v1 = (p2.Part1.CFrame * p2.C0:Inverse()):PointToObjectSpace(p3)
		local v2 = Base.Root.CFrame:PointToObjectSpace(Arm.Tip.Position)
		local v4 = math.sqrt(v1.x * v1.x + v1.z * v1.z)
		local v6 = math.atan2(-v1.z, v1.x)
		local v7, v8
		if v2.x < v4 then
			v7 = math.asin(v2.x / v4)
			if not v7 then
				v8 = v4 / v2.x
				v7 = math.asin(v8)
			end
		else
			v8 = v4 / v2.x
			v7 = math.asin(v8)
		end
		return v6 + v7
	end,
	computeVerticalAngle = function(p1, p2, p3)
		assert(p3)
		local Arm = p1:FindFirstChild("Arm")
		assert(Arm)
		assert(p2.Part1)
		local v1 = (p2.Part1.CFrame * p2.C0:Inverse()):PointToObjectSpace(p3)
		return math.atan2(v1.y, -v1.z)
	end,
	updateModel = function(p1, p2, p3, p4)
		p1.C1 = p1.C0:Inverse() * CFrame.Angles(0, p3 - 1.5707963267948966, 0) * p1.C0
		p2.C1 = p2.C0:Inverse() * CFrame.Angles(p4, 0, 0) * p2.C0
	end
}
