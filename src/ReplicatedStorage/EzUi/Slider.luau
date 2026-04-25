-- Reviewed by Claude
-- variables reassigned
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
function SliderComponent.init(p1)
	p1.sliderRef = Roact.createRef()
	p1.handleRef = Roact.createRef()
	p1.maid = Maid.new()
	p1:setState({
		sliderAbsoluteSize = Vector2.new(1, 1)
	})
end
function SliderComponent.render(p1)
	local aspectRatio = p1.state.sliderAbsoluteSize.Y / p1.state.sliderAbsoluteSize.X
	return createElement("Frame", {
		BackgroundColor3 = p1.props.backgroundColor,
		BorderSizePixel = 0,
		Position = p1.props.position,
		Size = p1.props.size,
		LayoutOrder = p1.props.layoutOrder,
		[Roact.Ref] = p1.sliderRef,
		[Roact.Change.AbsoluteSize] = function(inputObject)
			p1:setState({
				sliderAbsoluteSize = inputObject.AbsoluteSize
			})
		end
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}),
		Handle = createElement("TextButton", {
			BackgroundTransparency = 0,
			BackgroundColor3 = p1.props.handleColor,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 3 * p1.state.sliderAbsoluteSize.Y * 0.8, 0, p1.state.sliderAbsoluteSize.Y * 0.8),
			Position = p1.props.value:map(function(normalizedValue)
				local marginX = 1.3000000000000003 * aspectRatio
				return UDim2.new((normalizedValue - p1.props.min) / (p1.props.max - p1.props.min) * (1 - 2 * marginX) + marginX, 0, 0.5, 0)
			end),
			Font = Enum.Font.SourceSansBold,
			Text = p1.props.text,
			TextScaled = true,
			TextColor3 = Color3.new(0.1, 0.1, 0.1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			[Roact.Event.InputBegan] = function(handleButton, inputEvent)
				if (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch) and inputEvent.UserInputState == Enum.UserInputState.Begin then
					p1.maid.waitForEnd = inputEvent:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if inputEvent.UserInputState == Enum.UserInputState.End then
							p1.maid.waitForEnd = nil
							p1.maid.dragHeartbeat = nil
						end
					end)
					local sliderFrame = p1.sliderRef:getValue()
					p1.maid.dragHeartbeat = RunService.Heartbeat:Connect(function()
						if p1._mouseMovementInput then
							local AbsoluteSize = sliderFrame.AbsoluteSize
							local marginX = 1.3000000000000003 * aspectRatio
							p1:_setValue((p1._mouseMovementInput.Position.X - sliderFrame.AbsolutePosition.X - AbsoluteSize.X * marginX) / (AbsoluteSize.X * (1 - 2 * marginX)))
						end
					end)
				end
				if inputEvent.UserInputType == Enum.UserInputType.MouseMovement or inputEvent.UserInputType == Enum.UserInputType.Touch then
					p1._mouseMovementInput = inputEvent
				end
				if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.ButtonA then
					local SelectedObject = GuiService.SelectedObject
					p1.isGamepadDragging = true
					GuiService.SelectedObject = nil
					p1.maid.waitForEnd = inputEvent:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if inputEvent.UserInputState == Enum.UserInputState.End then
							p1.maid.waitForEnd = nil
							GuiService.SelectedObject = SelectedObject
							p1.isGamepadDragging = false
						end
					end)
				end
			end,
			[Roact.Event.SelectionGained] = function()
				if not (GamepadService.GamepadCursorEnabled or p1.isGamepadDragging) then
					p1:_hookSelection(true)
					ContextActionService:BindActionAtPriority("sinkThumb1", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
					ContextActionService:BindActionAtPriority("sinkThumb2", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
				end
			end,
			[Roact.Event.SelectionLost] = function()
				if not (GamepadService.GamepadCursorEnabled or p1.isGamepadDragging) then
					ContextActionService:UnbindAction("sinkThumb1")
					ContextActionService:UnbindAction("sinkThumb2")
					p1:_hookSelection(false)
				end
			end,
			[Roact.Ref] = p1.handleRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		})
	})
end
function SliderComponent._setValue(p1, normalizedValue)
	local clampedValue = math.clamp(normalizedValue, 0, 1)
	local step = p1.props.step
	local rangeSize = p1.props.max - p1.props.min
	local steppedValue
	if step > 0 then
		local stepRatio = rangeSize / step
		steppedValue = math.floor(clampedValue * stepRatio + 0.5) / stepRatio
	else
		steppedValue = clampedValue
	end
	local finalValue = steppedValue * rangeSize + p1.props.min
	if p1.props.value:getValue() ~= finalValue then
		p1.props.updateValue(finalValue)
	end
end
function SliderComponent._hookSelection(p1, shouldHook)
	if shouldHook then
		local lastInputEvent = nil
		p1.maid.selectionDragListen = UserInputService.InputChanged:Connect(function(inputEvent)
			if not GamepadService.GamepadCursorEnabled and (inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.Thumbstick2) then
				lastInputEvent = inputEvent
			end
		end)
		p1.maid.dragHeartbeat = RunService.Heartbeat:Connect(function(deltaTime)
			if lastInputEvent then
				local X = lastInputEvent.Position.X
				if math.abs(X) > 0.1 then
					p1:_setValue((p1.props.value:getValue() - p1.props.min) / (p1.props.max - p1.props.min) + X * deltaTime)
				end
			end
		end)
	else
		p1.maid.selectionDragListen = nil
		p1.maid.dragHeartbeat = nil
	end
end
function SliderComponent.willUnmount(p1)
	p1.maid:DoCleaning()
end
return SliderComponent
