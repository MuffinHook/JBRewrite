local Basic = require(script.Parent.Basic)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.6, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local ShieldSWAT = {
	__ClassName = "ShieldSWAT"
}
ShieldSWAT.__index = ShieldSWAT
setmetatable(ShieldSWAT, Basic)
function ShieldSWAT.new(itemInstance, userData, customConfig)
	local shieldInstance = Basic.new(itemInstance, userData, motionConfig, customConfig)
	setmetatable(shieldInstance, ShieldSWAT)
	return shieldInstance
end
function ShieldSWAT.InputBegan(itemInstance, ...)
	Basic.InputBegan(itemInstance, ...)
end
function ShieldSWAT.InputEnded(itemInstance)  end
return ShieldSWAT
