local Basic = require(script.Parent.Basic)
local GLIDER_CONFIG = {
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
local Glider = {
	__ClassName = "Glider"
}
Glider.__index = Glider
setmetatable(Glider, Basic)
function Glider.Init(initData)
	eventSignal = initData.Event
end
function Glider.new(itemId, parent, attackPower)
	local instance = Basic.new(itemId, parent, GLIDER_CONFIG, attackPower)
	setmetatable(instance, Glider)
	return instance
end
function Glider.GetLeftArmPosition(self)
	return nil
end
function Glider.ShootBegin(self, input)
	eventSignal:FireServer("k1lnwg5x")
end
function Glider.InputBegan(self, inputEvent, gameProcessed)
	if if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then inputEvent.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:ShootBegin(inputEvent)
	end
	Basic.InputBegan(self, inputEvent, gameProcessed)
end
function Glider.InputEnded(self)  end
return Glider
