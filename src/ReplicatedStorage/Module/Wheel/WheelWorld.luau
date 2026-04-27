local function calculateTotalMass(instance)
	local nextIterator = next
	local children, index = instance:GetChildren()
	local sum = 0
	for childIndex, child in nextIterator, children, index do
		if child:IsA("BasePart") then
			sum = sum + child:GetMass()
		end
		sum = sum + calculateTotalMass(child)
	end
	return sum
end
local WheelWorldModule = {}
WheelWorldModule.__index = WheelWorldModule
function WheelWorldModule.new()
	local self = setmetatable({}, WheelWorldModule)
	self.Model = nil
	self.Wheels = {}
	return self
end
function WheelWorldModule.SetModel(self, model)
	self.Model = model
end
function WheelWorldModule.AddWheel(self, wheel)
	assert(wheel)
	table.insert(self.Wheels, wheel)
	self:Calculate()
end
function WheelWorldModule.GetEffWheelCount(self)
	local count = 0
	for i, wheel in ipairs(self.Wheels) do
		if wheel._applyForces then
			count = count + 1
		end
	end
	return count
end
function WheelWorldModule.Calculate(self)
	local totalMass = if self.Model == nil then 0 else calculateTotalMass(self.Model)
	local massPerWheel = totalMass * (1 / self:GetEffWheelCount())
	for i = 1, #self.Wheels do
		self.Wheels[i].EffectiveMass = massPerWheel
		self.Wheels[i].IgnoreModel = self.Model
	end
	self.Mass = totalMass
end
function WheelWorldModule.Destroy(self)
	for i = 1, #self.Wheels do
		self.Wheels[i]:Destroy()
	end
	self.Wheels = {}
end
return WheelWorldModule
