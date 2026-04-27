local Basic = require(script.Parent.Basic)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, -0.4, -1.5),
				ItemRotation = Vector3.new(-0.1, 0, 0),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local CrateClass = {
	__ClassName = "Crate"
}
CrateClass.__index = CrateClass
setmetatable(CrateClass, Basic)
function CrateClass.new(item, itemInstance, motionSettings)
	local crateInstance = Basic.new(item, itemInstance, motionConfig, motionSettings)
	setmetatable(crateInstance, CrateClass)
	crateInstance.SpringNeckRotation:SetTarget(Vector3.new(-0.2, 0, 0))
	crateInstance.SpringWaistRotation:SetTarget(Vector3.new(0.2, 0, 0))
	crateInstance:DefaultDisableCamLock()
	return crateInstance
end
function CrateClass.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function CrateClass.InputEnded(self) end
return CrateClass
