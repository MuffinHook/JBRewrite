local t = {
	customWeld = function(basePart, targetPart, c0Offset, c1Offset)
		local Weld = Instance.new("Weld")
		Weld.Name = ("%s->%s"):format(basePart.Name, targetPart.Name)
		Weld.Part0 = basePart
		Weld.Part1 = targetPart
		if c0Offset then
			Weld.C0 = c0Offset
		end
		if c1Offset then
			Weld.C1 = c1Offset
		end
		Weld.Parent = basePart
		return Weld
	end
}
function t.blankWeld(basePart, targetPart)
	return t.customWeld(basePart, targetPart, nil, nil)
end
function t.weld(basePart, targetPart)
	return t.customWeld(basePart, targetPart, basePart.CFrame:ToObjectSpace(targetPart.CFrame), nil)
end
function t.weldModel(basePart, skipChildren)
	local PrimaryPart = basePart.PrimaryPart
	if PrimaryPart == nil then
		error("Missing `PrimaryPart` of root model.")
	end
	for i, v in ipairs(basePart:GetChildren()) do
		if v:IsA("BasePart") then
			if v ~= PrimaryPart then
				t.weld(v, PrimaryPart)
				v.Anchored = false
			end
		elseif v:IsA("Model") and not skipChildren then
			if v.PrimaryPart then
				t.weldModel(v)
				t.weld(v.PrimaryPart, PrimaryPart)
			else
				warn(("Skipping %s, no primary part"):format(v.Name))
			end
		end
	end
	PrimaryPart.Anchored = false
end
function t.customMotor(basePart, targetPart, c0Offset, c1Offset)
	local Motor = Instance.new("Motor")
	Motor.Name = ("%s->%s"):format(basePart.Name, targetPart.Name)
	Motor.Part0 = basePart
	Motor.Part1 = targetPart
	if c0Offset then
		Motor.C0 = c0Offset
	end
	if c1Offset then
		Motor.C1 = c1Offset
	end
	Motor.Parent = basePart
	return Motor
end
function t.blankMotor(basePart, targetPart)
	return t.customMotor(basePart, targetPart, nil, nil)
end
function t.motor(basePart, targetPart)
	return t.customMotor(basePart, targetPart, basePart.CFrame:ToObjectSpace(targetPart.CFrame), nil)
end
local function setJointOffset(joint, axisIndex, offsetCFrame)
	if joint.ClassName == "AnimationConstraint" then
		joint["Attachment" .. axisIndex].CFrame = offsetCFrame
	else
		joint["C" .. axisIndex] = offsetCFrame
	end
end
function t.setJointC0(joint, offsetCFrame)
	return setJointOffset(joint, "0", offsetCFrame)
end
function t.setJointC1(joint, offsetCFrame)
	return setJointOffset(joint, "1", offsetCFrame)
end
return t
