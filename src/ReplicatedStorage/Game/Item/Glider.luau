local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(1, 1, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.Angles(0, 1.5707963267948966, 0),
		LeftWristRotation = CFrame.new()
	}
}
local v2 = nil
local t2 = {
	__ClassName = "Glider"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(p1) --[[ Line: 25 | Upvalues: v2 (ref) ]]
	v2 = p1.Event
end
function t2.new(p1, p2, p3) --[[ Line: 28 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	return v1
end
function t2.GetLeftArmPosition(p1) --[[ Line: 34 ]]
	return nil
end
function t2.ShootBegin(p1, p2) --[[ Line: 37 | Upvalues: v2 (ref) ]]
	v2:FireServer("k" .. ("ialwnl1sco"):sub(4, 7):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("r5gc0"):sub(2, 3):reverse():reverse():reverse() .. "x")
end
function t2.InputBegan(p1, p2, p3) --[[ Line: 40 | Upvalues: Basic (copy) ]]
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:ShootBegin(p2)
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1) --[[ Line: 50 ]] end
return t2