local ContextActionService = game:GetService("ContextActionService")
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local v1 = script:FindFirstAncestor("EzUi")
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local Maid = require(v1.Parent.Std.Maid)
local RunService = game:GetService("RunService")
local v2 = Roact.PureComponent:extend("Slider")
v2.defaultProps = {
	backgroundColor = Color3.new(255/255, 0/255, 0/255),
	handleColor = Color3.new(255/255, 255/255, 255/255),
	min = 0,
	max = 1,
	step = 0
}
function v2.init(p1) --[[ Line: 23 | Upvalues: Roact (copy), Maid (copy) ]]
	p1.sliderRef = Roact.createRef()
	p1.handleRef = Roact.createRef()
	p1.maid = Maid.new()
	p1:setState({
		sliderAbsoluteSize = Vector2.new(1, 1)
	})
end
function v2.render(p1) --[[ Line: 31 | Upvalues: createElement (copy), Roact (copy), RunService (copy), GuiService (copy), GamepadService (copy), ContextActionService (copy) ]]
	local v1 = p1.state.sliderAbsoluteSize.Y / p1.state.sliderAbsoluteSize.X
	return createElement("Frame", {
		BackgroundColor3 = p1.props.backgroundColor,
		BorderSizePixel = 0,
		Position = p1.props.position,
		Size = p1.props.size,
		LayoutOrder = p1.props.layoutOrder,
		[Roact.Ref] = p1.sliderRef,
		[Roact.Change.AbsoluteSize] = function(p12) --[[ Line: 42 | Upvalues: p1 (copy) ]]
			p1:setState({
				sliderAbsoluteSize = p12.AbsoluteSize
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
			Position = p1.props.value:map(function(p12) --[[ Line: 61 | Upvalues: p1 (copy), v1 (copy) ]]
				local v3 = 1.3000000000000003 * v1
				return UDim2.new((p12 - p1.props.min) / (p1.props.max - p1.props.min) * (1 - 2 * v3) + v3, 0, 0.5, 0)
			end),
			Font = Enum.Font.SourceSansBold,
			Text = p1.props.text,
			TextScaled = true,
			TextColor3 = Color3.new(0.1, 0.1, 0.1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			[Roact.Event.InputBegan] = function(p12, p2) --[[ Line: 72 | Upvalues: p1 (copy), RunService (ref), v1 (copy), GuiService (ref) ]]
				if (p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.UserInputType == Enum.UserInputType.Touch) and p2.UserInputState == Enum.UserInputState.Begin then
					p1.maid.waitForEnd = p2:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 78 | Upvalues: p2 (copy), p1 (ref) ]]
						if p2.UserInputState == Enum.UserInputState.End then
							p1.maid.waitForEnd = nil
							p1.maid.dragHeartbeat = nil
						end
					end)
					local v12 = p1.sliderRef:getValue()
					p1.maid.dragHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 85 | Upvalues: p1 (ref), v12 (copy), v1 (ref) ]]
						if p1._mouseMovementInput then
							local AbsoluteSize = v12.AbsoluteSize
							local v13 = 1.3000000000000003 * v1
							p1:_setValue((p1._mouseMovementInput.Position.X - v12.AbsolutePosition.X - AbsoluteSize.X * v13) / (AbsoluteSize.X * (1 - 2 * v13)))
						end
					end)
				end
				if p2.UserInputType == Enum.UserInputType.MouseMovement or p2.UserInputType == Enum.UserInputType.Touch then
					p1._mouseMovementInput = p2
				end
				if p2.UserInputType == Enum.UserInputType.Gamepad1 and p2.KeyCode == Enum.KeyCode.ButtonA then
					local SelectedObject = GuiService.SelectedObject
					p1.isGamepadDragging = true
					GuiService.SelectedObject = nil
					p1.maid.waitForEnd = p2:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 113 | Upvalues: p2 (copy), p1 (ref), GuiService (ref), SelectedObject (copy) ]]
						if p2.UserInputState == Enum.UserInputState.End then
							p1.maid.waitForEnd = nil
							GuiService.SelectedObject = SelectedObject
							p1.isGamepadDragging = false
						end
					end)
				end
			end,
			[Roact.Event.SelectionGained] = function() --[[ Line: 124 | Upvalues: GamepadService (ref), p1 (copy), ContextActionService (ref) ]]
				if not (GamepadService.GamepadCursorEnabled or p1.isGamepadDragging) then
					p1:_hookSelection(true)
					ContextActionService:BindActionAtPriority("sinkThumb1", function() --[[ Line: 130 ]]
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
					ContextActionService:BindActionAtPriority("sinkThumb2", function() --[[ Line: 133 ]]
						return Enum.ContextActionResult.Sink
					end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
				end
			end,
			[Roact.Event.SelectionLost] = function() --[[ Line: 138 | Upvalues: GamepadService (ref), p1 (copy), ContextActionService (ref) ]]
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
function v2._setValue(p1, p2) --[[ Line: 156 ]]
	local v1 = math.clamp(p2, 0, 1)
	local step = p1.props.step
	local v2 = p1.props.max - p1.props.min
	local v3
	if step > 0 then
		local v4 = v2 / step
		v3 = math.floor(v1 * v4 + 0.5) / v4
	else
		v3 = v1
	end
	local v5 = v3 * v2 + p1.props.min
	if p1.props.value:getValue() ~= v5 then
		p1.props.updateValue(v5)
	end
end
function v2._hookSelection(p1, p2) --[[ Line: 169 | Upvalues: UserInputService (copy), GamepadService (copy), RunService (copy) ]]
	if p2 then
		local v1 = nil
		p1.maid.selectionDragListen = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 172 | Upvalues: GamepadService (ref), v1 (ref) ]]
			if not GamepadService.GamepadCursorEnabled and (p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick2) then
				v1 = p1
			end
		end)
		p1.maid.dragHeartbeat = RunService.Heartbeat:Connect(function(p12) --[[ Line: 186 | Upvalues: v1 (ref), p1 (copy) ]]
			if v1 then
				local X = v1.Position.X
				if math.abs(X) > 0.1 then
					p1:_setValue((p1.props.value:getValue() - p1.props.min) / (p1.props.max - p1.props.min) + X * p12)
				end
			end
		end)
	else
		p1.maid.selectionDragListen = nil
		p1.maid.dragHeartbeat = nil
	end
end
function v2.willUnmount(p1) --[[ Line: 202 ]]
	p1.maid:DoCleaning()
end
return v2