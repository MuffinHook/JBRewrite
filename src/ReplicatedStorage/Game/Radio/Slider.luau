-- Reviewed by Claude
-- variables reassigned
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local SliderClass = {}
SliderClass.__index = SliderClass
function SliderClass.new(self)
	assert(self)
	local sliderInstance = {}
	setmetatable(sliderInstance, SliderClass)
	sliderInstance.Gui = self
	sliderInstance.Maid = Maid.new()
	sliderInstance.Value = 0
	sliderInstance.SpringSlider = Spring.new(sliderInstance.Value, 0, 0.8, 50)
	sliderInstance.OnValueChanged = Signal.new()
	sliderInstance:Setup()
	sliderInstance:UpdatePosition(sliderInstance.Value)
	return sliderInstance
end
function SliderClass.Setup(self)
	local function StartDragger(p12)
		self.Maid.DragHeartbeat = RunService.Heartbeat:Connect(function()
			local v1 = self.Value
			self.Value = self:GetMouseValue()
			if v1 ~= self.Value then
				self.OnValueChanged:Fire(self.Value)
				if self.Maid.PositionHeartbeat == nil then
					self:StartUpdateThread()
				end
			end
		end)
		if p12 then
			self.Maid.DragEnd = p12:GetPropertyChangedSignal("UserInputState"):Connect(function()
				if p12.UserInputState == Enum.UserInputState.End then
					self.Maid.DragHeartbeat = nil
					self.Maid.DragEnd = nil
				end
			end)
		else
			self.Maid.DragEnd = UserInputService.InputEnded:Connect(function(p12)
				if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch then
					self.Maid.DragHeartbeat = nil
					self.Maid.DragEnd = nil
				end
			end)
		end
	end
	self.Maid:GiveTask(self.Gui.ContainerKnob.Knob.InputBegan:Connect(function(p12, p2)
		if not p2 and (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) then
			self.Value = self:GetMouseValue()
			self.OnValueChanged:Fire(self.Value)
			if self.Maid.PositionHeartbeat == nil then
				self:StartUpdateThread()
			end
			StartDragger(p12)
		end
	end))
end
function SliderClass.GetMouseValue(self)
	local ContainerKnob = self.Gui.ContainerKnob
	return math.clamp(math.floor(((UserInputService:GetMouseLocation() - ContainerKnob.AbsolutePosition - GuiService:GetGuiInset()) / ContainerKnob.AbsoluteSize).X * 24 + 0.5) / 24, 0, 1)
end
function SliderClass.SetValue(self, p2)
	self.Value = p2
	self.SpringSlider.p = p2
	self.SpringSlider:SetTarget(p2)
	self:UpdatePosition(p2)
	self.OnValueChanged:Fire(p2)
end
function SliderClass.StartUpdateThread(self)
	assert(self.Maid.PositionHeartbeat == nil)
	self.Maid.PositionHeartbeat = RunService.Heartbeat:Connect(function()
		local v1, velocity = self.SpringSlider:SetTarget(self.Value)
		self:UpdatePosition(v1)
		if math.abs(self.Value - v1) < 0.001 and math.abs(velocity) < 0.001 then
			self.Maid.PositionHeartbeat = nil
		end
	end)
end
function SliderClass.UpdatePosition(self, p2)
	self.Gui.ContainerKnob.Knob.Position = UDim2.new(p2, 0, 0.5, 0)
end
function SliderClass.Destroy(self)
	self.Gui = nil
	self.Maid:Destroy()
	self.Maid = nil
end
return SliderClass
