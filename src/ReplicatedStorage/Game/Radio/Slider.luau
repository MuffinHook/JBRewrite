local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 11 | Upvalues: t (copy), Maid (copy), Spring (copy), Signal (copy) ]]
	assert(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.Gui = p1
	t2.Maid = Maid.new()
	t2.Value = 0
	t2.SpringSlider = Spring.new(t2.Value, 0, 0.8, 50)
	t2.OnValueChanged = Signal.new()
	t2:Setup()
	t2:UpdatePosition(t2.Value)
	return t2
end
function t.Setup(p1) --[[ Line: 27 | Upvalues: RunService (copy), UserInputService (copy) ]]
	local function StartDragger(p12) --[[ Line: 29 | Upvalues: p1 (copy), RunService (ref), UserInputService (ref) ]]
		p1.Maid.DragHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 30 | Upvalues: p1 (ref) ]]
			local v1 = p1.Value
			p1.Value = p1:GetMouseValue()
			if v1 ~= p1.Value then
				p1.OnValueChanged:Fire(p1.Value)
				if p1.Maid.PositionHeartbeat == nil then
					p1:StartUpdateThread()
				end
			end
		end)
		if p12 then
			p1.Maid.DragEnd = p12:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 51 | Upvalues: p12 (copy), p1 (ref) ]]
				if p12.UserInputState == Enum.UserInputState.End then
					p1.Maid.DragHeartbeat = nil
					p1.Maid.DragEnd = nil
				end
			end)
		else
			p1.Maid.DragEnd = UserInputService.InputEnded:Connect(function(p12) --[[ Line: 41 | Upvalues: p1 (ref) ]]
				if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch then
					p1.Maid.DragHeartbeat = nil
					p1.Maid.DragEnd = nil
				end
			end)
		end
	end
	p1.Maid:GiveTask(p1.Gui.ContainerKnob.Knob.InputBegan:Connect(function(p12, p2) --[[ Line: 62 | Upvalues: p1 (copy), StartDragger (copy) ]]
		if not p2 and (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) then
			p1.Value = p1:GetMouseValue()
			p1.OnValueChanged:Fire(p1.Value)
			if p1.Maid.PositionHeartbeat == nil then
				p1:StartUpdateThread()
			end
			StartDragger(p12)
		end
	end))
end
function t.GetMouseValue(p1) --[[ Line: 76 | Upvalues: UserInputService (copy), GuiService (copy) ]]
	local ContainerKnob = p1.Gui.ContainerKnob
	return math.clamp(math.floor(((UserInputService:GetMouseLocation() - ContainerKnob.AbsolutePosition - GuiService:GetGuiInset()) / ContainerKnob.AbsoluteSize).X * 24 + 0.5) / 24, 0, 1)
end
function t.SetValue(p1, p2) --[[ Line: 86 ]]
	p1.Value = p2
	p1.SpringSlider.p = p2
	p1.SpringSlider:SetTarget(p2)
	p1:UpdatePosition(p2)
	p1.OnValueChanged:Fire(p2)
end
function t.StartUpdateThread(p1) --[[ Line: 93 | Upvalues: RunService (copy) ]]
	assert(p1.Maid.PositionHeartbeat == nil)
	p1.Maid.PositionHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 95 | Upvalues: p1 (copy) ]]
		local v1, v2 = p1.SpringSlider:SetTarget(p1.Value)
		p1:UpdatePosition(v1)
		if math.abs(p1.Value - v1) < 0.001 and math.abs(v2) < 0.001 then
			p1.Maid.PositionHeartbeat = nil
		end
	end)
end
function t.UpdatePosition(p1, p2) --[[ Line: 103 ]]
	p1.Gui.ContainerKnob.Knob.Position = UDim2.new(p2, 0, 0.5, 0)
end
function t.Destroy(p1) --[[ Line: 107 ]]
	p1.Gui = nil
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t