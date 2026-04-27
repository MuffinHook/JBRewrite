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
local MansionInvite = {
	__ClassName = "MansionInvite"
}
MansionInvite.__index = MansionInvite
setmetatable(MansionInvite, Basic)
function MansionInvite.new(self, itemInstance, motionConfig)
	local newInstance = Basic.new(self, itemInstance, defaultMotion, motionConfig)
	setmetatable(newInstance, MansionInvite)
	newInstance:DefaultDisableCamLock()
	return newInstance
end
function MansionInvite.GetLeftArmPosition(self)
	return nil
end
function MansionInvite.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function MansionInvite.InputEnded(self) end
return MansionInvite
