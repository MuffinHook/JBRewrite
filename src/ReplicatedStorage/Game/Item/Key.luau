-- Reviewed by Claude
local Basic = require(script.Parent.Basic)
local defaultMotion = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1, 0.6, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local Key = {
	__ClassName = "Key"
}
Key.__index = Key
setmetatable(Key, Basic)
function Key.new(self, itemInstance, motionConfig)
	local newInstance = Basic.new(self, itemInstance, defaultMotion, motionConfig)
	setmetatable(newInstance, Key)
	newInstance:DefaultDisableCamLock()
	return newInstance
end
function Key.GetLeftArmPosition(self)
	return nil
end
function Key.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function Key.InputEnded(self) end
return Key