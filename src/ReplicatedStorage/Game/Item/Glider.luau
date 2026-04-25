-- Reviewed by Claude
-- variables reassigned
local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1, 1, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.Angles(0, 1.5707963267948966, 0),
		LeftWristRotation = CFrame.new()
	}
}
local eventSignal = nil
local t2 = {
	__ClassName = "Glider"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(eventData)
	eventSignal = eventData.Event
end
function t2.new(itemId, p2, p3)
	local instance = Basic.new(itemId, p2, t, p3)
	setmetatable(instance, t2)
	return instance
end
function t2.GetLeftArmPosition(self)
	return nil
end
function t2.ShootBegin(self, input)
	eventSignal:FireServer("k" .. ("ialwnl1sco"):sub(4, 7):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("r5gc0"):sub(2, 3):reverse():reverse():reverse() .. "x")
end
function t2.InputBegan(self, inputObject, gameProcessed)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:ShootBegin(inputObject)
	end
	Basic.InputBegan(self, inputObject, gameProcessed)
end
function t2.InputEnded(self)  end
return t2
