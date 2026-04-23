local _ = Vector3.new
local v1 = CFrame.new(0, 0, 0)
local toObjectSpace = v1.toObjectSpace
local function Custom(p1, p2, p3, p4, p5) --[[ Line: 10 ]]
	local v1 = Instance.new(p1)
	v1.Part0 = p2
	v1.Part1 = p3
	v1.C0 = p4
	v1.C1 = p5
	v1.Parent = p2
	return v1
end
local function CustomWeld(p1, p2, p3, p4) --[[ Line: 19 ]]
	local Weld = Instance.new("Weld")
	Weld.Part0 = p1
	Weld.Part1 = p2
	Weld.C0 = p3
	Weld.C1 = p4
	Weld.Parent = p1
	return Weld
end
local function CustomMotor(p1, p2, p3, p4) --[[ Line: 22 ]]
	local Motor = Instance.new("Motor")
	Motor.Part0 = p1
	Motor.Part1 = p2
	Motor.C0 = p3
	Motor.C1 = p4
	Motor.Parent = p1
	return Motor
end
local function CustomMotor6D(p1, p2, p3, p4) --[[ Line: 25 ]]
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = p1
	Motor6D.Part1 = p2
	Motor6D.C0 = p3
	Motor6D.C1 = p4
	Motor6D.Parent = p1
	return Motor6D
end
local function BlankWeld(p1, p2) --[[ Line: 28 | Upvalues: v1 (copy) ]]
	local Weld = Instance.new("Weld")
	Weld.Part0 = p1
	Weld.Part1 = p2
	Weld.C0 = v1
	Weld.C1 = v1
	Weld.Parent = p1
	return Weld
end
local function BlankMotor(p1, p2) --[[ Line: 31 | Upvalues: v1 (copy) ]]
	local Motor = Instance.new("Motor")
	Motor.Part0 = p1
	Motor.Part1 = p2
	Motor.C0 = v1
	Motor.C1 = v1
	Motor.Parent = p1
	return Motor
end
local function BlankMotor6D(p1, p2) --[[ Line: 34 | Upvalues: v1 (copy) ]]
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = p1
	Motor6D.Part1 = p2
	Motor6D.C0 = v1
	Motor6D.C1 = v1
	Motor6D.Parent = p1
	return Motor6D
end
local function Weld(p1, p2) --[[ Line: 37 | Upvalues: toObjectSpace (copy), v1 (copy) ]]
	local v12 = toObjectSpace(p1.CFrame, p2.CFrame)
	local Weld = Instance.new("Weld")
	Weld.Part0 = p1
	Weld.Part1 = p2
	Weld.C0 = v12
	Weld.C1 = v1
	Weld.Parent = p1
	return Weld
end
local function Motor(p1, p2) --[[ Line: 40 | Upvalues: toObjectSpace (copy), v1 (copy) ]]
	local v12 = toObjectSpace(p1.CFrame, p2.CFrame)
	local Motor = Instance.new("Motor")
	Motor.Part0 = p1
	Motor.Part1 = p2
	Motor.C0 = v12
	Motor.C1 = v1
	Motor.Parent = p1
	return Motor
end
local function Motor6D(p1, p2) --[[ Line: 43 | Upvalues: toObjectSpace (copy), v1 (copy) ]]
	local v12 = toObjectSpace(p1.CFrame, p2.CFrame)
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Part0 = p1
	Motor6D.Part1 = p2
	Motor6D.C0 = v12
	Motor6D.C1 = v1
	Motor6D.Parent = p1
	return Motor6D
end
local function v2(p1, p2, p3) --[[ Line: 46 | Upvalues: v2 (copy), toObjectSpace (copy), v1 (copy) ]]
	local v12 = next
	local v22, v3 = p1:GetChildren()
	local t = {}
	for v4, v5 in v12, v22, v3 do
		if not p3 then
			local v6 = next
			local v7, v8 = v2(v5, p2, p3)
			for v9, v10 in v6, v7, v8 do
				table.insert(t, v10)
			end
		end
		if v5:IsA("BasePart") and v5 ~= p2 then
			local v11 = toObjectSpace(v5.CFrame, p2.CFrame)
			local Weld = Instance.new("Weld")
			Weld.Part0 = v5
			Weld.Part1 = p2
			Weld.C0 = v11
			Weld.C1 = v1
			Weld.Parent = v5
			table.insert(t, Weld)
			v5.Anchored = false
		end
	end
	p2.Anchored = false
	return t
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
	WeldAllTo = v2
}