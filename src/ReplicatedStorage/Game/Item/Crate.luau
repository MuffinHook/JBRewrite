local Basic = require(script.Parent.Basic)
local t = {
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
local t2 = {
	__ClassName = "Crate"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3) --[[ Line: 23 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1.SpringNeckRotation:SetTarget(Vector3.new(-0.2, 0, 0))
	v1.SpringWaistRotation:SetTarget(Vector3.new(0.2, 0, 0))
	v1:DefaultDisableCamLock()
	return v1
end
function t2.InputBegan(p1, ...) --[[ Line: 34 | Upvalues: Basic (copy) ]]
	Basic.InputBegan(p1, ...)
end
function t2.InputEnded(p1) --[[ Line: 37 ]] end
return t2