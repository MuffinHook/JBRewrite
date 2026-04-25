-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local itemScript = script.Parent
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local Basic = require(itemScript.Basic)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0, -1),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local classDefinition = {
	__ClassName = "Cuffed"
}
classDefinition.__index = classDefinition
setmetatable(classDefinition, Basic)
function classDefinition.new(item, tag, config)
	local instance = Basic.new(item, tag, motionConfig, config)
	setmetatable(instance, classDefinition)
	instance.SpringItemOffset.Damp = 0.5
	instance.SpringItemOffset.Freq = 7
	instance.SpringWaistRotation.Damp = 0.5
	instance.SpringWaistRotation.Freq = 7
	instance.SpringNeckRotation.Damp = 0.5
	instance.SpringNeckRotation.Freq = 7
	instance.SpringItemOffset:SetTarget(Vector3.new(0, 0, 0.2))
	instance.SpringWaistRotation:SetTarget(Vector3.new(-0.5, 0, 0))
	instance.SpringNeckRotation:SetTarget(Vector3.new(-0.5, 0, 0))
	instance:DefaultDisableCamLock()
	if instance.Local then
		HapticEffect.basic(1, 0.2)
	end
	return instance
end
function classDefinition.InputBegan(item, ...)
	Basic.InputBegan(item, ...)
end
function classDefinition.InputEnded(item) end
return classDefinition
