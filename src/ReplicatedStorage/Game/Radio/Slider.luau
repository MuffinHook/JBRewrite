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
	local function StartDragger(inputObject)
		self.Maid.DragHeartbeat = RunService.Heartbeat:Connect(function()
			local actualValue = self.Value
			self.Value = self:GetMouseValue()
			if actualValue ~= self.Value then
				self.OnValueChanged:Fire(self.Value)
				if self.Maid.PositionHeartbeat == nil then
					self:StartUpdateThread()
				end
			end
		end)
		if inputObject then
			self.Maid.DragEnd = inputObject:GetPropertyChangedSignal("UserInputState"):Connect(function()
				if inputObject.UserInputState == Enum.UserInputState.End then
					self.Maid.DragHeartbeat = nil
					self.Maid.DragEnd = nil
				end
			end)
		else
			self.Maid.DragEnd = UserInputService.InputEnded:Connect(function(inputEvent)
				if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch then
					self.Maid.DragHeartbeat = nil
					self.Maid.DragEnd = nil
				end
			end)
		end
	end
	self.Maid:GiveTask(self.Gui.ContainerKnob.Knob.InputBegan:Connect(function(inputObject, gameProcessed)
		if not gameProcessed and (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch) then
			self.Value = self:GetMouseValue()
			self.OnValueChanged:Fire(self.Value)
			if self.Maid.PositionHeartbeat == nil then
				self:StartUpdateThread()
			end
			StartDragger(inputObject)
		end
	end))
end
function SliderClass.GetMouseValue(self)
	local ContainerKnob = self.Gui.ContainerKnob
	return math.clamp(math.floor(((UserInputService:GetMouseLocation() - ContainerKnob.AbsolutePosition - GuiService:GetGuiInset()) / ContainerKnob.AbsoluteSize).X * 24 + 0.5) / 24, 0, 1)
end
function SliderClass.SetValue(self, position)
	self.Value = position
	self.SpringSlider.p = position
	self.SpringSlider:SetTarget(position)
	self:UpdatePosition(position)
	self.OnValueChanged:Fire(position)
end
function SliderClass.StartUpdateThread(self)
	assert(self.Maid.PositionHeartbeat == nil)
	self.Maid.PositionHeartbeat = RunService.Heartbeat:Connect(function()
		local actualPosition, velocity = self.SpringSlider:SetTarget(self.Value)
		self:UpdatePosition(actualPosition)
		if math.abs(self.Value - actualPosition) < 0.001 and math.abs(velocity) < 0.001 then
			self.Maid.PositionHeartbeat = nil
		end
	end)
end
function SliderClass.UpdatePosition(self, position)
	self.Gui.ContainerKnob.Knob.Position = UDim2.new(position, 0, 0.5, 0)
end
function SliderClass.Destroy(self)
	self.Gui = nil
	self.Maid:Destroy()
	self.Maid = nil
end
return SliderClass
