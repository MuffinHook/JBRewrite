-- Reviewed by Claude
-- variables reassigned
local Basic = require(script.Parent.Basic)
local t = {
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
local t2 = {
	__ClassName = "Flashlight"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3)
	local instance = Basic.new(p1, p2, t, p3)
	setmetatable(instance, t2)
	instance.Enabled = false
	instance.SpringItemOffset:SetTarget(Vector3.new(1, 0.6, -1.5))
	return instance
end
function t2.GetLeftArmPosition(p1)
	return nil
end
function t2.Toggle(p1)
	p1.Enabled = not p1.Enabled
	local Model = p1.Model
	Model.Model.Light.Material = p1.Enabled and Enum.Material.Neon or Enum.Material.Plastic
	for v2, descendant in Model.Model:GetDescendants() do
		if descendant:IsA("SpotLight") then
			descendant.Enabled = p1.Enabled
		end
	end
end
function t2.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:Toggle()
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1)  end
return t2
