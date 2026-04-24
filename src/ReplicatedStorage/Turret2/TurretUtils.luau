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
		local cframe = (p2.Part1.CFrame * p2.C0:Inverse()):PointToObjectSpace(p3)
		local cframe2 = Base.Root.CFrame:PointToObjectSpace(Arm.Tip.Position)
		local var4 = math.sqrt(cframe.x * cframe.x + cframe.z * cframe.z)
		local var6 = math.atan2(-cframe.z, cframe.x)
		local v7, v8
		if cframe2.x < var4 then
			v7 = math.asin(cframe2.x / var4)
			if not v7 then
				v8 = var4 / cframe2.x
				v7 = math.asin(v8)
			end
		else
			v8 = var4 / cframe2.x
			v7 = math.asin(v8)
		end
		return var6 + v7
	end,
	computeVerticalAngle = function(p1, p2, p3)
		assert(p3)
		local Arm = p1:FindFirstChild("Arm")
		assert(Arm)
		assert(p2.Part1)
		local cframe = (p2.Part1.CFrame * p2.C0:Inverse()):PointToObjectSpace(p3)
		return math.atan2(cframe.y, -cframe.z)
	end,
	updateModel = function(p1, p2, p3, p4)
		p1.C1 = p1.C0:Inverse() * CFrame.Angles(0, p3 - 1.5707963267948966, 0) * p1.C0
		p2.C1 = p2.C0:Inverse() * CFrame.Angles(p4, 0, 0) * p2.C0
	end
}
