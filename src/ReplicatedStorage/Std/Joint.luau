-- Reviewed by Claude
-- variables reassigned
local _ = Vector3.new
local identityCFrame = CFrame.new(0, 0, 0)
local toObjectSpace = identityCFrame.toObjectSpace
local function Custom(jointType, part0, part1, c0, c1)
	local joint = Instance.new(jointType)
	joint.Part0 = part0
	joint.Part1 = part1
	joint.C0 = c0
	joint.C1 = c1
	joint.Parent = part0
	return joint
end
local function CustomWeld(part0, part1, c0, c1)
	local Weld = Instance.new("Weld")
	Weld.Part0 = part0
	Weld.Part1 = part1
	Weld.C0 = c0
	Weld.C1 = c1
	Weld.Parent = part0
	return Weld
end
local function CustomMotor(part0, part1, c0, c1)
	local Motor = Instance.new("Motor")
	Motor.Part0 = part0
	Motor.Part1 = part1
	Motor.C0 = c0
	Motor.C1 = c1
	Motor.Parent = part0
	return Motor
end
local function CustomMotor6D(part0, part1, c0, c1)
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = part0
	Motor6D.Part1 = part1
	Motor6D.C0 = c0
	Motor6D.C1 = c1
	Motor6D.Parent = part0
	return Motor6D
end
local function BlankWeld(part0, part1)
	local Weld = Instance.new("Weld")
	Weld.Part0 = part0
	Weld.Part1 = part1
	Weld.C0 = identityCFrame
	Weld.C1 = identityCFrame
	Weld.Parent = part0
	return Weld
end
local function BlankMotor(part0, part1)
	local Motor = Instance.new("Motor")
	Motor.Part0 = part0
	Motor.Part1 = part1
	Motor.C0 = identityCFrame
	Motor.C1 = identityCFrame
	Motor.Parent = part0
	return Motor
end
local function BlankMotor6D(part0, part1)
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = part0
	Motor6D.Part1 = part1
	Motor6D.C0 = identityCFrame
	Motor6D.C1 = identityCFrame
	Motor6D.Parent = part0
	return Motor6D
end
local function Weld(part0, part1)
	local relativeCFrame = toObjectSpace(part0.CFrame, part1.CFrame)
	local Weld = Instance.new("Weld")
	Weld.Part0 = part0
	Weld.Part1 = part1
	Weld.C0 = relativeCFrame
	Weld.C1 = identityCFrame
	Weld.Parent = part0
	return Weld
end
local function Motor(part0, part1)
	local relativeCFrame = toObjectSpace(part0.CFrame, part1.CFrame)
	local Motor = Instance.new("Motor")
	Motor.Part0 = part0
	Motor.Part1 = part1
	Motor.C0 = relativeCFrame
	Motor.C1 = identityCFrame
	Motor.Parent = part0
	return Motor
end
local function Motor6D(part0, part1)
	local relativeCFrame = toObjectSpace(part0.CFrame, part1.CFrame)
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = part0
	Motor6D.Part1 = part1
	Motor6D.C0 = relativeCFrame
	Motor6D.C1 = identityCFrame
	Motor6D.Parent = part0
	return Motor6D
end
local function WeldAllTo(rootPart, targetPart, skipRoot)
	local nextFunc = next
	local children = rootPart:GetChildren()
	local welds = {}
	for i, child in nextFunc, children do
		if not skipRoot then
			local childNextFunc = next
			local childWelds, state = WeldAllTo(child, targetPart, skipRoot)
			for j, childWeld in childNextFunc, childWelds, state do
				table.insert(welds, childWeld)
			end
		end
		if child:IsA("BasePart") and child ~= targetPart then
			local relativeCFrame = toObjectSpace(child.CFrame, targetPart.CFrame)
			local Weld = Instance.new("Weld")
			Weld.Part0 = child
			Weld.Part1 = targetPart
			Weld.C0 = relativeCFrame
			Weld.C1 = identityCFrame
			Weld.Parent = child
			table.insert(welds, Weld)
			child.Anchored = false
		end
	end
	targetPart.Anchored = false
	return welds
end
return {
	CustomWeld = CustomWeld,
	CustomMotor = CustomMotor,
	CustomMotor6D = CustomMotor6D,
	BlankWeld = BlankWeld,
	BlankMotor = BlankMotor,
	BlankMotor6D = BlankMotor6D,
	Weld = Weld,
	Motor = Motor,
	Motor6D = Motor6D,
	WeldAllTo = WeldAllTo
}
