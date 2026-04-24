-- Reviewed by Claude
local t = {
	customWeld = function(p1, p2, p3, p4)
		local Weld = Instance.new("Weld")
		Weld.Name = ("%s->%s"):format(p1.Name, p2.Name)
		Weld.Part0 = p1
		Weld.Part1 = p2
		if p3 then
			Weld.C0 = p3
		end
		if p4 then
			Weld.C1 = p4
		end
		Weld.Parent = p1
		return Weld
	end
}
function t.blankWeld(p1, p2)
	return t.customWeld(p1, p2, nil, nil)
end
function t.weld(p1, p2)
	return t.customWeld(p1, p2, p1.CFrame:ToObjectSpace(p2.CFrame), nil)
end
function t.weldModel(p1, p2)
	local PrimaryPart = p1.PrimaryPart
	if PrimaryPart == nil then
		error("Missing `PrimaryPart` of root model.")
	end
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") then
			if v ~= PrimaryPart then
				t.weld(v, PrimaryPart)
				v.Anchored = false
			end
		elseif v:IsA("Model") and not p2 then
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
function t.customMotor(p1, p2, p3, p4)
	local Motor = Instance.new("Motor")
	Motor.Name = ("%s->%s"):format(p1.Name, p2.Name)
	Motor.Part0 = p1
	Motor.Part1 = p2
	if p3 then
		Motor.C0 = p3
	end
	if p4 then
		Motor.C1 = p4
	end
	Motor.Parent = p1
	return Motor
end
function t.blankMotor(p1, p2)
	return t.customMotor(p1, p2, nil, nil)
end
function t.motor(p1, p2)
	return t.customMotor(p1, p2, p1.CFrame:ToObjectSpace(p2.CFrame), nil)
end
local function setJointOffset(p1, p2, p3)
	if p1.ClassName == "AnimationConstraint" then
		p1["Attachment" .. p2].CFrame = p3
	else
		p1["C" .. p2] = p3
	end
end
function t.setJointC0(p1, p2)
	return setJointOffset(p1, "0", p2)
end
function t.setJointC1(p1, p2)
	return setJointOffset(p1, "1", p2)
end
return t
