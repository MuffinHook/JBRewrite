-- Reviewed by Claude
local function v1(p1)
	local var12 = next
	local table2, var3 = p1:GetChildren()
	local sum = 0
	for v4, v5 in var12, table2, var3 do
		if v5:IsA("BasePart") then
			sum = sum + v5:GetMass()
		end
		sum = sum + v1(v5)
	end
	return sum
end
local t = {}
t.__index = t
function t.new()
	local table2 = setmetatable({}, t)
	table2.Model = nil
	table2.Wheels = {}
	return table2
end
function t.SetModel(p1, p2)
	p1.Model = p2
end
function t.AddWheel(p1, p2)
	assert(p2)
	table.insert(p1.Wheels, p2)
	p1:Calculate()
end
function t.GetEffWheelCount(p1)
	local count = 0
	for i, v in ipairs(p1.Wheels) do
		if v._applyForces then
			count = count + 1
		end
	end
	return count
end
function t.Calculate(p1)
	local var12 = if p1.Model == nil then 0 else v1(p1.Model)
	local var3 = var12 * (1 / p1:GetEffWheelCount())
	for i = 1, #p1.Wheels do
		p1.Wheels[i].EffectiveMass = var3
		p1.Wheels[i].IgnoreModel = p1.Model
	end
	p1.Mass = var12
end
function t.Destroy(p1)
	for i = 1, #p1.Wheels do
		p1.Wheels[i]:Destroy()
	end
	p1.Wheels = {}
end
return t
