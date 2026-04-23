local function v1(p1) --[[ Line: 7 | Upvalues: v1 (copy) ]]
	local v12 = next
	local v2, v3 = p1:GetChildren()
	local sum = 0
	for v4, v5 in v12, v2, v3 do
		if v5:IsA("BasePart") then
			sum = sum + v5:GetMass()
		end
		sum = sum + v1(v5)
	end
	return sum
end
local t = {}
t.__index = t
function t.new() --[[ Line: 20 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Model = nil
	v2.Wheels = {}
	return v2
end
function t.SetModel(p1, p2) --[[ Line: 26 ]]
	p1.Model = p2
end
function t.AddWheel(p1, p2) --[[ Line: 29 ]]
	assert(p2)
	table.insert(p1.Wheels, p2)
	p1:Calculate()
end
function t.GetEffWheelCount(p1) --[[ Line: 34 ]]
	local count = 0
	for i, v in ipairs(p1.Wheels) do
		if v._applyForces then
			count = count + 1
		end
	end
	return count
end
function t.Calculate(p1) --[[ Line: 43 | Upvalues: v1 (copy) ]]
	local v12 = if p1.Model == nil then 0 else v1(p1.Model)
	local v3 = v12 * (1 / p1:GetEffWheelCount())
	for i = 1, #p1.Wheels do
		p1.Wheels[i].EffectiveMass = v3
		p1.Wheels[i].IgnoreModel = p1.Model
	end
	p1.Mass = v12
end
function t.Destroy(p1) --[[ Line: 58 ]]
	for i = 1, #p1.Wheels do
		p1.Wheels[i]:Destroy()
	end
	p1.Wheels = {}
end
return t