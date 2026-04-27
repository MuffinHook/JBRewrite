local Basic = require(script.Parent.Basic)
local MOTION_CONFIG = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.7, -0.5, 0),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local Flashlight = {
	__ClassName = "Flashlight"
}
Flashlight.__index = Flashlight
setmetatable(Flashlight, Basic)
function Flashlight.new(parent, otherArg2, otherArg3)
	local instance = Basic.new(parent, otherArg2, MOTION_CONFIG, otherArg3)
	setmetatable(instance, Flashlight)
	instance.Enabled = false
	instance.SpringItemOffset:SetTarget(Vector3.new(1, 0.6, -1.5))
	return instance
end
function Flashlight.GetLeftArmPosition(self)
	return nil
end
function Flashlight.Toggle(self)
	self.Enabled = not self.Enabled
	local Model = self.Model
	Model.Model.Light.Material = self.Enabled and Enum.Material.Neon or Enum.Material.Plastic
	for index, descendant in Model.Model:GetDescendants() do
		if descendant:IsA("SpotLight") then
			descendant.Enabled = self.Enabled
		end
	end
end
function Flashlight.InputBegan(self, inputObject, otherArg3)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:Toggle()
		if self.Local then
			self:BroadcastInputBegan(inputObject)
		end
	end
	Basic.InputBegan(self, inputObject, otherArg3)
end
function Flashlight.InputEnded(self)  end
return Flashlight
