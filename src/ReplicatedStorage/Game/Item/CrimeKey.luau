local Basic = require(script.Parent.Basic)
local itemConfig = {
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
local CrimeKeyClass = {
	__ClassName = "CrimeKey"
}
CrimeKeyClass.__index = CrimeKeyClass
setmetatable(CrimeKeyClass, Basic)
function CrimeKeyClass.new(model, instance, additional)
	local itemInstance = Basic.new(model, instance, itemConfig, additional)
	setmetatable(itemInstance, CrimeKeyClass)
	itemInstance:DefaultDisableCamLock()
	return itemInstance
end
function CrimeKeyClass.GetLeftArmPosition(self)
	return nil
end
function CrimeKeyClass.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function CrimeKeyClass.InputEnded(self) end
return CrimeKeyClass
