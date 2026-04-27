return {
	computeHorizontalAngle = function(turretModel, joint, targetPosition)
		assert(targetPosition)
		assert(joint)
		assert(joint.Part1)
		local Base = turretModel:FindFirstChild("Base")
		assert(Base)
		local Arm = turretModel:FindFirstChild("Arm")
		assert(Arm)
		local positionObjectSpace = (joint.Part1.CFrame * joint.C0:Inverse()):PointToObjectSpace(targetPosition)
		local armTipObjectSpace = Base.Root.CFrame:PointToObjectSpace(Arm.Tip.Position)
		local horizontalDistance = math.sqrt(positionObjectSpace.x * positionObjectSpace.x + positionObjectSpace.z * positionObjectSpace.z)
		local baseAngle = math.atan2(-positionObjectSpace.z, positionObjectSpace.x)
		local calculatedAngle, distanceRatio
		if armTipObjectSpace.x < horizontalDistance then
			calculatedAngle = math.asin(armTipObjectSpace.x / horizontalDistance)
			if not calculatedAngle then
				distanceRatio = horizontalDistance / armTipObjectSpace.x
				calculatedAngle = math.asin(distanceRatio)
			end
		else
			distanceRatio = horizontalDistance / armTipObjectSpace.x
			calculatedAngle = math.asin(distanceRatio)
		end
		return baseAngle + calculatedAngle
	end,
	computeVerticalAngle = function(turretModel, joint, targetPosition)
		assert(targetPosition)
		local Arm = turretModel:FindFirstChild("Arm")
		assert(Arm)
		assert(joint.Part1)
		local positionObjectSpace = (joint.Part1.CFrame * joint.C0:Inverse()):PointToObjectSpace(targetPosition)
		return math.atan2(positionObjectSpace.y, -positionObjectSpace.z)
	end,
	updateModel = function(joint, joint2, horizontalAngle, verticalAngle)
		joint.C1 = joint.C0:Inverse() * CFrame.Angles(0, horizontalAngle - 1.5707963267948966, 0) * joint.C0
		joint2.C1 = joint2.C0:Inverse() * CFrame.Angles(verticalAngle, 0, 0) * joint2.C0
	end
}
