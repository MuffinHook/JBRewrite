local Basic = require(script.Parent.Basic)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 2, -1.9),
				ItemRotation = Vector3.new(-0.1, 0, 0),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local gemClass = {
	__ClassName = "Gem"
}
gemClass.__index = gemClass
setmetatable(gemClass, Basic)
function gemClass.new(self, item, config)
	local gemInstance = Basic.new(self, item, motionConfig, config)
	setmetatable(gemInstance, gemClass)
	gemInstance.SpringNeckRotation:SetTarget(Vector3.new(-0.4, 0, 0))
	gemInstance.SpringWaistRotation:SetTarget(Vector3.new(0.4, 0, 0))
	gemInstance:DefaultDisableCamLock()
	return gemInstance
end
function gemClass.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function gemClass.InputEnded(self)  end
return gemClass
