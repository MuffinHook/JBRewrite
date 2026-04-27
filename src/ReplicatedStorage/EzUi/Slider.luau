local ContextActionService = game:GetService("ContextActionService")
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local EzUiFolder = script:FindFirstAncestor("EzUi")
local Roact = require(EzUiFolder.Parent.Roact)
local createElement = Roact.createElement
local Maid = require(EzUiFolder.Parent.Std.Maid)
local RunService = game:GetService("RunService")
local SliderComponent = Roact.PureComponent:extend("Slider")
SliderComponent.defaultProps = {
	backgroundColor = Color3.new(255/255, 0/255, 0/255),
	handleColor = Color3.new(255/255, 255/255, 255/255),
	min = 0,
	max = 1,
	step = 0
}
function SliderComponent.init(self)
	self.sliderRef = Roact.createRef()
	self.handleRef = Roact.createRef()
	self.maid = Maid.new()
	self:setState({
		sliderAbsoluteSize = Vector2.new(1, 1)
	})
end
function SliderComponent.render(self)
	local aspectRatio = self.state.sliderAbsoluteSize.Y / self.state.sliderAbsoluteSize.X
	return createElement("Frame", {
		BackgroundColor3 = self.props.backgroundColor,
		BorderSizePixel = 0,
		Position = self.props.position,
		Size = self.props.size,
		LayoutOrder = self.props.layoutOrder,
		[Roact.Ref] = self.sliderRef,
		[Roact.Change.AbsoluteSize] = function(inputObject)
			self:setState({
				sliderAbsoluteSize = inputObject.AbsoluteSize
			})
		end
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}),
		Handle = createElement("TextButton", {
			BackgroundTransparency = 0,
			BackgroundColor3 = self.props.handleColor,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 3 * self.state.sliderAbsoluteSize.Y * 0.8, 0, self.state.sliderAbsoluteSize.Y * 0.8),
			Position = self.props.value:map(function(normalizedValue)
				local marginX = 1.3000000000000003 * aspectRatio
				return UDim2.new((normalizedValue - self.props.min) / (self.props.max - self.props.min) * (1 - 2 * marginX) + marginX, 0, 0.5, 0)
			end),
			Font = Enum.Font.SourceSansBold,
			Text = self.props.text,
			TextScaled = true,
			TextColor3 = Color3.new(0.1, 0.1, 0.1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			[Roact.Event.InputBegan] = function(handleButton, inputEvent)
				if (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch) and inputEvent.UserInputState == Enum.UserInputState.Begin then
					self.maid.waitForEnd = inputEvent:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if inputEvent.UserInputState == Enum.UserInputState.End then
							self.maid.waitForEnd = nil
							self.maid.dragHeartbeat = nil
						end
					end)
					local sliderFrame = self.sliderRef:getValue()
					self.maid.dragHeartbeat = RunService.Heartbeat:Connect(function()
						if self._mouseMovementInput then
							local AbsoluteSize = sliderFrame.AbsoluteSize
							local marginX = 1.3000000000000003 * aspectRatio
							self:_setValue((self._mouseMovementInput.Position.X - sliderFrame.AbsolutePosition.X - AbsoluteSize.X * marginX) / (AbsoluteSize.X * (1 - 2 * marginX)))
						end
					end)
				end
				if inputEvent.UserInputType == Enum.UserInputType.MouseMovement or inputEvent.UserInputType == Enum.UserInputType.Touch then
					self._mouseMovementInput = inputEvent
				end
				if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.ButtonA then
					local SelectedObject = GuiService.SelectedObject
					self.isGamepadDragging = true
					GuiService.SelectedObject = nil
					self.maid.waitForEnd = inputEvent:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if inputEvent.UserInputState == Enum.UserInputState.End then
							self.maid.waitForEnd = nil
							GuiService.SelectedObject = SelectedObject
							self.isGamepadDragging = false
						end
					end)
				end
			end,
			[Roact.Event.SelectionGained] = function()
				if not (GamepadService.GamepadCursorEnabled or self.isGamepadDragging) then
					self:_hookSelection(true)
					ContextActionService:BindActionAtPriority("sinkThumb1", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
					ContextActionService:BindActionAtPriority("sinkThumb2", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
				end
			end,
			[Roact.Event.SelectionLost] = function()
				if not (GamepadService.GamepadCursorEnabled or self.isGamepadDragging) then
					ContextActionService:UnbindAction("sinkThumb1")
					ContextActionService:UnbindAction("sinkThumb2")
					self:_hookSelection(false)
				end
			end,
			[Roact.Ref] = self.handleRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		})
	})
end
function SliderComponent._setValue(self, normalizedValue)
	local clampedValue = math.clamp(normalizedValue, 0, 1)
	local step = self.props.step
	local rangeSize = self.props.max - self.props.min
	local steppedValue
	if step > 0 then
		local stepRatio = rangeSize / step
		steppedValue = math.floor(clampedValue * stepRatio + 0.5) / stepRatio
	else
		steppedValue = clampedValue
	end
	local finalValue = steppedValue * rangeSize + self.props.min
	if self.props.value:getValue() ~= finalValue then
		self.props.updateValue(finalValue)
	end
end
function SliderComponent._hookSelection(self, shouldHook)
	if shouldHook then
		local lastInputEvent = nil
		self.maid.selectionDragListen = UserInputService.InputChanged:Connect(function(inputEvent)
			if not GamepadService.GamepadCursorEnabled and (inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.Thumbstick2) then
				lastInputEvent = inputEvent
			end
		end)
		self.maid.dragHeartbeat = RunService.Heartbeat:Connect(function(deltaTime)
			if lastInputEvent then
				local X = lastInputEvent.Position.X
				if math.abs(X) > 0.1 then
					self:_setValue((self.props.value:getValue() - self.props.min) / (self.props.max - self.props.min) + X * deltaTime)
				end
			end
		end)
	else
		self.maid.selectionDragListen = nil
		self.maid.dragHeartbeat = nil
	end
end
function SliderComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return SliderComponent
