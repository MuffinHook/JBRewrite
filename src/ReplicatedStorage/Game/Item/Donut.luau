-- Reviewed by Claude
local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.8, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		Eat = {
			Springs = {
				ItemOffset = Vector3.new(0, 1.2, -1.3),
				ItemRotation = Vector3.new(0.9424778, 0, 0),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local v2 = nil
local t2 = {
	__ClassName = "Donut"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(p1)
	v2 = p1.Event
end
function t2.new(p1, p2, p3)
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1:DefaultDisableCamLock()
	return v1
end
function t2.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Eat.Springs.ItemRotation)
		delay(0.3, function()
			p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
			if p1.Local then
				local v1 = tick()
				local v22 = p1.LastConsumed or 0
				p1.LastConsumed = v1
				if v1 - v22 < 5 then
					return false
				end
				v2:FireServer("o" .. ("ftcjupr"):sub(3, 4):reverse() .. "" .. "" .. ("z1rdcuc"):sub(2, 5):reverse():reverse():reverse():reverse():reverse() .. "3")
			end
		end)
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1)  end
return t2
