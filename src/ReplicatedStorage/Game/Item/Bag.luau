local Basic = require(script.Parent.Basic)
local t = {
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
local t2 = {
	__ClassName = "Bag"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3) --[[ Line: 23 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1.SpringItemOffset:SetTarget(Vector3.new(1, 2, 0))
	v1.SpringNeckRotation:SetTarget(Vector3.new(0.35, 0, 0))
	v1.SpringWaistRotation:SetTarget(Vector3.new(-0.35, 0, 0))
	v1:DefaultDisableCamLock()
	return v1
end
function t2.GetLeftArmPosition(p1) --[[ Line: 35 ]]
	return nil
end
function t2.InputBegan(p1, ...) --[[ Line: 38 | Upvalues: Basic (copy) ]]
	Basic.InputBegan(p1, ...)
end
function t2.InputEnded(p1) --[[ Line: 41 ]] end
return t2