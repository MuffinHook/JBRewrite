-- Reviewed by Claude
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local Maid = require(ReplicatedStorage.Std.Maid)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local MinimapUtils = require(script.Parent.MinimapUtils)
local Minimap = require(script.Parent.Minimap)
local v1 = Roact.PureComponent:extend("BigMinimap")
v1.defaultProps = {
	visible = true,
	mapScale = 1
}
function v1.init(p1)
	p1.horizontalRef = Roact.createRef()
	p1.verticalRef = Roact.createRef()
	p1.maid = Maid.new()
	if p1.props.containerSize then
		local updateContainerSize = p1.props.updateContainerSize
		p1.containerSize = p1.props.containerSize
		p1.updateContainerSize = updateContainerSize
	else
		local v1, v2 = Roact.createBinding(Vector2.new(512, 512))
		p1.containerSize = v1
		p1.updateContainerSize = v2
	end
	if p1.props.containerRef then
		p1.containerRef = p1.props.containerRef
	else
		p1.containerRef = Roact.createRef()
	end
	p1:setState({
		crossHairEnabled = false,
		inputType = Enum.UserInputType.Keyboard
	})
	p1.x = 0
	p1.y = 0
end
function v1.render(p1)
	if p1.props.visible then
		local v3 = Dictionary.merge(p1.props, {
			containerSize = p1.containerSize,
			updateContainerSize = p1.updateContainerSize,
			containerRef = p1.containerRef,
			containerChildren = {
				LineHorizontal = createElement("Frame", {
					BackgroundTransparency = 0,
					Size = UDim2.new(1, 0, 0, 2),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
					BorderSizePixel = 1,
					BorderColor3 = Color3.new(102/255, 102/255, 102/255),
					ZIndex = 4,
					Visible = p1.state.crossHairEnabled,
					[Roact.Ref] = p1.horizontalRef
				}),
				LineVertical = createElement("Frame", {
					BackgroundTransparency = 0,
					Size = UDim2.new(0, 2, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
					BorderSizePixel = 1,
					BorderColor3 = Color3.new(102/255, 102/255, 102/255),
					ZIndex = 4,
					Visible = p1.state.crossHairEnabled,
					[Roact.Ref] = p1.verticalRef
				})
			}
		})
		local t = {}
		local t2 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.05, 0),
			Position = UDim2.new(0, 0, 1, 4)
		}
		local t3 = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 4)
			})
		}
		local t4 = {
			BackgroundColor3 = p1.props.color,
			Size = UDim2.new(1, 0, 1, 0),
			Text = "",
			LayoutOrder = 1,
			Selectable = true,
			[Roact.Event.Activated] = function()
				if #p1.props.waypoints == 0 then
					p1:setState({
						crossHairEnabled = true
					})
					if p1.state.inputType == Enum.UserInputType.Gamepad1 then
						GuiService.SelectedObject = nil
						local AbsoluteSize = p1.containerRef:getValue().AbsoluteSize
						p1:_setXY(AbsoluteSize.X * 0.5, AbsoluteSize.Y * 0.5)
					end
				else
					p1.props.onSetWaypoint(nil)
				end
			end
		}
		local t5 = {}
		local t6 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t6.Text = if #p1.props.waypoints == 0 then "Add Waypoint" else "Remove Waypoint"
		t6.Font = Enum.Font.LuckiestGuy
		t6.LineHeight = 0.7
		t6.TextScaled = true
		t6.TextXAlignment = Enum.TextXAlignment.Center
		t6.TextYAlignment = Enum.TextYAlignment.Center
		t6.TextColor3 = Color3.fromRGB(255, 255, 255)
		t6.ZIndex = 10
		t5.Title = createElement("TextLabel", t6)
		t5.AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		})
		t5.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
		})
		t3.Waypoint = createElement("TextButton", t4, t5)
		t.Buttons = createElement("Frame", t2, t3)
		return createElement(Minimap, v3, t)
	end
end
function v1._setXY(p1, p2, p3)
	local AbsoluteSize = p1.containerRef:getValue().AbsoluteSize
	p1.x = math.clamp(p2, 0, AbsoluteSize.X)
	p1.y = math.clamp(p3, 0, AbsoluteSize.Y)
	local v1 = p1.horizontalRef:getValue()
	local v2 = p1.verticalRef:getValue()
	if p1.state.crossHairEnabled then
		v1.Position = UDim2.new(0, 0, 0, p1.y)
		v2.Position = UDim2.new(0, p1.x, 0, 0)
	end
end
function v1._hookVisible(p1, p2)
	if p2 then
		local v1 = Maid.new()
		p1.maid.visibleMaid = v1
		local v2 = GuiService:GetGuiInset()
		v1:GiveTask(RunService.Heartbeat:Connect(function()
			local v1 = p1.containerRef:getValue()
			if p1.state.inputType == Enum.UserInputType.Keyboard then
				local v22 = UserInputService:GetMouseLocation() - v2
				local AbsolutePosition = v1.AbsolutePosition
				p1:_setXY(v22.X - AbsolutePosition.X, v22.Y - AbsolutePosition.Y)
			end
		end))
		v1:GiveTask(UserInputService.InputBegan:Connect(function(p12)
			if p1.state.crossHairEnabled and (p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.Gamepad1 and p12.KeyCode == Enum.KeyCode.ButtonA)) then
				local v1 = p1.containerRef:getValue()
				local AbsoluteSize = v1.AbsoluteSize
				if p12.UserInputType == Enum.UserInputType.Touch then
					local AbsolutePosition = v1.AbsolutePosition
					p1.x = p12.Position.X - AbsolutePosition.X
					p1.y = p12.Position.Y - AbsolutePosition.Y
				end
				local x = p1.x
				local y = p1.y
				if not (x < 0 or (y < 0 or (AbsoluteSize.X < x or AbsoluteSize.Y < y))) then
					local v2, v3 = MinimapUtils.computeWorldXY(x, y, p1.props.worldPosition:getValue(), p1.containerSize:getValue(), p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth, p1.props.mapImageHeight, p1.props.mapScale)
					if p1.props.onSetWaypoint then
						p1.props.onSetWaypoint((Vector3.new(v2, 50, v3)))
					end
					if p1.props.onToggle then
						p1.props.onToggle(false)
					end
					p1:setState({
						crossHairEnabled = false
					})
				end
			end
		end))
	else
		p1.maid.visibleMaid = nil
	end
end
function v1.didMount(p1)
	local function updateInputType()
		local v1 = UserInputService:GetLastInputType()
		if (v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Keyboard or v1 == Enum.UserInputType.Touch)) and p1.state.inputType ~= v1 then
			p1:setState({
				inputType = v1
			})
		end
	end
	updateInputType()
	p1.maid:GiveTask(UserInputService.LastInputTypeChanged:Connect(updateInputType))
end
function v1.didUpdate(p1, p2, p3)
	if p1.state.crossHairEnabled ~= p3.crossHairEnabled then
		p1:_hookGamepad(p1.state.crossHairEnabled)
	end
	if p1.props.visible ~= p2.visible then
		p1:_hookVisible(p1.props.visible)
	end
end
function v1._hookGamepad(p1, p2)
	if p2 then
		ContextActionService:BindActionAtPriority("sinkThumb1", function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
		ContextActionService:BindActionAtPriority("sinkJump", function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA)
		local v1 = nil
		p1.maid.selectionDragListen = UserInputService.InputChanged:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick1 then
				v1 = p1
			end
		end)
		p1.maid.dragHeartbeat = RunService.Heartbeat:Connect(function(p12)
			if v1 then
				local X = v1.Position.X
				local Y = v1.Position.Y
				if math.abs(X) > 0.1 or math.abs(Y) > 0.1 then
					p1:_setXY(p1.x + X * 10, p1.y - Y * 10, true)
				end
			end
		end)
	else
		ContextActionService:UnbindAction("sinkThumb1")
		ContextActionService:UnbindAction("sinkJump")
		p1.maid.selectionDragListen = nil
		p1.maid.dragHeartbeat = nil
	end
end
function v1.willUnmount(p1)
	p1:_hookGamepad(false)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		labels = p1.minimapLabels,
		waypoints = p1.minimapWaypoints,
		points = p1.minimapPoints,
		circles = p1.minimapCircles
	}
end, function(p1)
	return {
		onSetWaypoint = function(p12)
			if p12 then
				if MinimapService._addWaypointRemote then
					MinimapService._addWaypointRemote:FireServer(p12.X, p12.Z)
				end
			else
				p1({
					type = "removeWaypointCurrent"
				})
			end
		end
	}
end)(v1)