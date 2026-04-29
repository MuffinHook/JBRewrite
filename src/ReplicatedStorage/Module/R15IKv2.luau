local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SolveIK = require(ReplicatedStorage.Module.Logic).SolveIK
CFrame.new()
local cframe = CFrame.new(-0.1, -0.2, -0.05)
local cframe2 = CFrame.new(0.1, -0.2, -0.05)
local cframe3 = CFrame.Angles(math.pi / 2, 0, 0)
local function isNanV3(vector)
	return if vector.x == vector.x and vector.y == vector.y then vector.z ~= vector.z else true
end
local function isNanCf(cframeInput)
	local lookVector = cframeInput.lookVector
	local isNaN = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
	if not isNaN then
		local rightVector = cframeInput.rightVector
		isNaN = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
		if not isNaN then
			local upVector = cframeInput.upVector
			isNaN = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
		end
	end
	return isNaN
end
local function ComputeRawArm(shoulderJoint, elbowJoint, wristJoint, armTarget, armAngle, armOffset)
	local Part0 = shoulderJoint.Part0
	local shoulderCFrame = Part0.CFrame * shoulderJoint.C0 * shoulderJoint.C1:inverse()
	local elbowCFrame = shoulderCFrame * elbowJoint.C0 * elbowJoint.C1:inverse()
	local targetCFrame = shoulderCFrame * CFrame.new(0, shoulderJoint.Part1.Size.Y * 0.5, 0) * armOffset
	local midpointPosition = (shoulderCFrame.p + elbowCFrame.p) * 0.5
	local wristPosition = (elbowCFrame * wristJoint.C0 * wristJoint.C1:inverse()).p
	local upperArmLength = (targetCFrame.p - midpointPosition).Magnitude
	local lowerArmLength = (midpointPosition - wristPosition).Magnitude
	local upperCFrame, lowerCFrame = SolveIK(upperArmLength, lowerArmLength, targetCFrame, armTarget, armAngle)
	if lowerCFrame then
		local lookVector = lowerCFrame.lookVector
		local lowerIsNaN = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
		if not lowerIsNaN then
			local rightVector = lowerCFrame.rightVector
			lowerIsNaN = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
			if not lowerIsNaN then
				local upVector = lowerCFrame.upVector
				lowerIsNaN = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
			end
		end
		if lowerIsNaN then
		elseif upperCFrame then
			local lookVector_2 = upperCFrame.lookVector
			local upperIsNaN = if lookVector_2.x == lookVector_2.x and lookVector_2.y == lookVector_2.y then lookVector_2.z ~= lookVector_2.z else true
			if not upperIsNaN then
				local rightVector = upperCFrame.rightVector
				upperIsNaN = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
				if not upperIsNaN then
					local upVector = upperCFrame.upVector
					upperIsNaN = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
				end
			end
			if not upperIsNaN then
				local shoulderTransform = shoulderJoint.C0:inverse() * Part0.CFrame:inverse() * (lowerCFrame * CFrame.new(0, 0, -upperArmLength * 0.5) * cframe3) * shoulderJoint.C1
				local shoulderCFrameAdjusted = Part0.CFrame * shoulderJoint.C0 * shoulderTransform * shoulderJoint.C1:inverse()
				return shoulderTransform, elbowJoint.C0:inverse() * shoulderCFrameAdjusted:inverse() * (upperCFrame * CFrame.new(0, 0, -lowerArmLength * 0.5) * cframe3) * elbowJoint.C1
			end
		end
	end
end
local function BuildPacketArms(humanoid)
	return {
		RightShoulder = humanoid.RightUpperArm.RightShoulder,
		RightElbow = humanoid.RightLowerArm.RightElbow,
		RightWrist = humanoid.RightHand.RightWrist,
		LeftShoulder = humanoid.LeftUpperArm.LeftShoulder,
		LeftElbow = humanoid.LeftLowerArm.LeftElbow,
		LeftWrist = humanoid.LeftHand.LeftWrist
	}
end
local function ComputeArms(humanoid)
	local RightArm = humanoid.RightArm
	if RightArm then
		local rightShoulderTransform, rightElbowTransform = ComputeRawArm(humanoid.RightShoulder, humanoid.RightElbow, humanoid.RightWrist, RightArm, humanoid.RightAngle, cframe)
		if rightShoulderTransform then
			humanoid.RightShoulderTransform = rightShoulderTransform
		end
		if rightElbowTransform then
			humanoid.RightElbowTransform = rightElbowTransform
		end
	else
		humanoid.RightShoulderTransform = nil
		humanoid.RightElbowTransform = nil
	end
	local LeftArm = humanoid.LeftArm
	if LeftArm then
		local leftShoulderTransform, leftElbowTransform = ComputeRawArm(humanoid.LeftShoulder, humanoid.LeftElbow, humanoid.LeftWrist, LeftArm, humanoid.LeftAngle, cframe2)
		if leftShoulderTransform then
			humanoid.LeftShoulderTransform = leftShoulderTransform
		end
		if leftElbowTransform then
			humanoid.LeftElbowTransform = leftElbowTransform
		end
	else
		humanoid.LeftShoulderTransform = nil
		humanoid.LeftElbowTransform = nil
	end
end
local function ApplyArms(humanoid)
	if humanoid.RightShoulderTransform then
		humanoid.RightShoulder.Transform = humanoid.RightShoulderTransform
		humanoid.RightElbow.Transform = humanoid.RightElbowTransform
	end
	if humanoid.LeftShoulderTransform then
		humanoid.LeftShoulder.Transform = humanoid.LeftShoulderTransform
		humanoid.LeftElbow.Transform = humanoid.LeftElbowTransform
	end
end
return {
	BuildPacketArms = BuildPacketArms,
	Arms = function(humanoid)
		ComputeArms(humanoid)
		if humanoid.RightShoulderTransform then
			humanoid.RightShoulder.Transform = humanoid.RightShoulderTransform
			humanoid.RightElbow.Transform = humanoid.RightElbowTransform
		end
		if humanoid.LeftShoulderTransform then
			humanoid.LeftShoulder.Transform = humanoid.LeftShoulderTransform
			humanoid.LeftElbow.Transform = humanoid.LeftElbowTransform
		end
	end,
	ComputeArms = ComputeArms,
	ApplyArms = ApplyArms
}
