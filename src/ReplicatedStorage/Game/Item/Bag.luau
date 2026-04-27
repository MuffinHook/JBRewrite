local Basic = require(script.Parent.Basic)
local defaultMotionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1, 1.5, -1),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local BagClass = {
	__ClassName = "Bag"
}
BagClass.__index = BagClass
setmetatable(BagClass, Basic)
function BagClass.new(itemModel, parent, bagConfig)
	local bagInstance = Basic.new(itemModel, parent, defaultMotionConfig, bagConfig)
	setmetatable(bagInstance, BagClass)
	bagInstance.SpringItemOffset:SetTarget(Vector3.new(1, 2, 0))
	bagInstance.SpringNeckRotation:SetTarget(Vector3.new(0.35, 0, 0))
	bagInstance.SpringWaistRotation:SetTarget(Vector3.new(-0.35, 0, 0))
	bagInstance:DefaultDisableCamLock()
	return bagInstance
end
function BagClass.GetLeftArmPosition(self)
	return nil
end
function BagClass.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function BagClass.InputEnded(self) end
return BagClass
