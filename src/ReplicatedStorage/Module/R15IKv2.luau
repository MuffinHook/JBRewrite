local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SolveIK = require(ReplicatedStorage.Module.Logic).SolveIK
CFrame.new()
local v1 = CFrame.new(-0.1, -0.2, -0.05)
local v2 = CFrame.new(0.1, -0.2, -0.05)
local v3 = CFrame.Angles(1.5707963267948966, 0, 0)
local function isNanV3(p1) --[[ Line: 10 ]]
	return if p1.x == p1.x and p1.y == p1.y then p1.z ~= p1.z else true
end
local function isNanCf(p1) --[[ Line: 13 ]]
	local lookVector = p1.lookVector
	local v1 = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
	if not v1 then
		local rightVector = p1.rightVector
		v1 = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
		if not v1 then
			local upVector = p1.upVector
			v1 = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
		end
	end
	return v1
end
local function ComputeRawArm(p1, p2, p3, p4, p5, p6) --[[ Line: 16 | Upvalues: SolveIK (copy), v3 (copy) ]]
	local Part0 = p1.Part0
	local v1 = Part0.CFrame * p1.C0 * p1.C1:inverse()
	local v2 = v1 * p2.C0 * p2.C1:inverse()
	local v32 = v1 * CFrame.new(0, p1.Part1.Size.Y * 0.5, 0) * p6
	local v4 = (v1.p + v2.p) * 0.5
	local p_2 = (v2 * p3.C0 * p3.C1:inverse()).p
	local Magnitude = (v32.p - v4).Magnitude
	local Magnitude_2 = (v4 - p_2).Magnitude
	local v5, v6 = SolveIK(Magnitude, Magnitude_2, v32, p4, p5)
	if v6 then
		local lookVector = v6.lookVector
		local v7 = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
		if not v7 then
			local rightVector = v6.rightVector
			v7 = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
			if not v7 then
				local upVector = v6.upVector
				v7 = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
			end
		end
		if v7 then
		elseif v5 then
			local lookVector_2 = v5.lookVector
			local v8 = if lookVector_2.x == lookVector_2.x and lookVector_2.y == lookVector_2.y then lookVector_2.z ~= lookVector_2.z else true
			if not v8 then
				local rightVector = v5.rightVector
				v8 = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
				if not v8 then
					local upVector = v5.upVector
					v8 = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
				end
			end
			if not v8 then
				local v9 = p1.C0:inverse() * Part0.CFrame:inverse() * (v6 * CFrame.new(0, 0, -Magnitude * 0.5) * v3) * p1.C1
				local v10 = Part0.CFrame * p1.C0 * v9 * p1.C1:inverse()
				return v9, p2.C0:inverse() * v10:inverse() * (v5 * CFrame.new(0, 0, -Magnitude_2 * 0.5) * v3) * p2.C1
			end
		end
	end
end
local function BuildPacketArms(p1) --[[ Line: 49 ]]
	return {
		RightShoulder = p1.RightUpperArm.RightShoulder,
		RightElbow = p1.RightLowerArm.RightElbow,
		RightWrist = p1.RightHand.RightWrist,
		LeftShoulder = p1.LeftUpperArm.LeftShoulder,
		LeftElbow = p1.LeftLowerArm.LeftElbow,
		LeftWrist = p1.LeftHand.LeftWrist
	}
end
local function ComputeArms(p1) --[[ Line: 61 | Upvalues: ComputeRawArm (copy), v1 (copy), v2 (copy) ]]
	local RightArm = p1.RightArm
	if RightArm then
		local v12, v22 = ComputeRawArm(p1.RightShoulder, p1.RightElbow, p1.RightWrist, RightArm, p1.RightAngle, v1)
		if v12 then
			p1.RightShoulderTransform = v12
		end
		if v22 then
			p1.RightElbowTransform = v22
		end
	else
		p1.RightShoulderTransform = nil
		p1.RightElbowTransform = nil
	end
	local LeftArm = p1.LeftArm
	if LeftArm then
		local v3, v4 = ComputeRawArm(p1.LeftShoulder, p1.LeftElbow, p1.LeftWrist, LeftArm, p1.LeftAngle, v2)
		if v3 then
			p1.LeftShoulderTransform = v3
		end
		if v4 then
			p1.LeftElbowTransform = v4
		end
	else
		p1.LeftShoulderTransform = nil
		p1.LeftElbowTransform = nil
	end
end
local function ApplyArms(p1) --[[ Line: 104 ]]
	if p1.RightShoulderTransform then
		p1.RightShoulder.Transform = p1.RightShoulderTransform
		p1.RightElbow.Transform = p1.RightElbowTransform
	end
	if p1.LeftShoulderTransform then
		p1.LeftShoulder.Transform = p1.LeftShoulderTransform
		p1.LeftElbow.Transform = p1.LeftElbowTransform
	end
end
return {
	BuildPacketArms = BuildPacketArms,
	Arms = function(p1) --[[ Name: ArmsFull | Line: 116 | Upvalues: ComputeArms (copy) ]]
		ComputeArms(p1)
		if p1.RightShoulderTransform then
			p1.RightShoulder.Transform = p1.RightShoulderTransform
			p1.RightElbow.Transform = p1.RightElbowTransform
		end
		if p1.LeftShoulderTransform then
			p1.LeftShoulder.Transform = p1.LeftShoulderTransform
			p1.LeftElbow.Transform = p1.LeftElbowTransform
		end
	end,
	ComputeArms = ComputeArms,
	ApplyArms = ApplyArms
}