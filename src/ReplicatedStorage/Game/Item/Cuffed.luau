local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = script.Parent
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local Basic = require(v1.Basic)
local t = {
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
local t2 = {
	__ClassName = "Cuffed"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3) --[[ Line: 25 | Upvalues: Basic (copy), t (copy), t2 (copy), HapticEffect (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1.SpringItemOffset.Damp = 0.5
	v1.SpringItemOffset.Freq = 7
	v1.SpringWaistRotation.Damp = 0.5
	v1.SpringWaistRotation.Freq = 7
	v1.SpringNeckRotation.Damp = 0.5
	v1.SpringNeckRotation.Freq = 7
	v1.SpringItemOffset:SetTarget(Vector3.new(0, 0, 0.2))
	v1.SpringWaistRotation:SetTarget(Vector3.new(-0.5, 0, 0))
	v1.SpringNeckRotation:SetTarget(Vector3.new(-0.5, 0, 0))
	v1:DefaultDisableCamLock()
	if v1.Local then
		HapticEffect.basic(1, 0.2)
	end
	return v1
end
function t2.InputBegan(p1, ...) --[[ Line: 48 | Upvalues: Basic (copy) ]]
	Basic.InputBegan(p1, ...)
end
function t2.InputEnded(p1) --[[ Line: 51 ]] end
return t2