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
local BigMinimap = Roact.PureComponent:extend("BigMinimap")
BigMinimap.defaultProps = {
	visible = true,
	mapScale = 1
}
function BigMinimap.init(self)
	self.horizontalRef = Roact.createRef()
	self.verticalRef = Roact.createRef()
	self.maid = Maid.new()
	if self.props.containerSize then
		local updateContainerSize = self.props.updateContainerSize
		self.containerSize = self.props.containerSize
		self.updateContainerSize = updateContainerSize
	else
		local containerSize, updateContainerSize = Roact.createBinding(Vector2.new(512, 512))
		self.containerSize = containerSize
		self.updateContainerSize = updateContainerSize
	end
	if self.props.containerRef then
		self.containerRef = self.props.containerRef
	else
		self.containerRef = Roact.createRef()
	end
	self:setState({
		crossHairEnabled = false,
		inputType = Enum.UserInputType.Keyboard
	})
	self.x = 0
	self.y = 0
end
function BigMinimap.render(self)
	if self.props.visible then
		local mergedProps = Dictionary.merge(self.props, {
			containerSize = self.containerSize,
			updateContainerSize = self.updateContainerSize,
			containerRef = self.containerRef,
			containerChildren = {
				LineHorizontal = createElement("Frame", {
					BackgroundTransparency = 0,
					Size = UDim2.new(1, 0, 0, 2),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
					BorderSizePixel = 1,
					BorderColor3 = Color3.new(102/255, 102/255, 102/255),
					ZIndex = 4,
					Visible = self.state.crossHairEnabled,
					[Roact.Ref] = self.horizontalRef
				}),
				LineVertical = createElement("Frame", {
					BackgroundTransparency = 0,
					Size = UDim2.new(0, 2, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
					BorderSizePixel = 1,
					BorderColor3 = Color3.new(102/255, 102/255, 102/255),
					ZIndex = 4,
					Visible = self.state.crossHairEnabled,
					[Roact.Ref] = self.verticalRef
				})
			}
		})
		local containerChildren = {}
		local buttonsFrameProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.05, 0),
			Position = UDim2.new(0, 0, 1, 4)
		}
		local buttonsChildren = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 4)
			})
		}
		local waypointButtonProps = {
			BackgroundColor3 = self.props.color,
			Size = UDim2.new(1, 0, 1, 0),
			Text = "",
			LayoutOrder = 1,
			Selectable = true,
			[Roact.Event.Activated] = function()
				if #self.props.waypoints == 0 then
					self:setState({
						crossHairEnabled = true
					})
					if self.state.inputType == Enum.UserInputType.Gamepad1 then
						GuiService.SelectedObject = nil
						local AbsoluteSize = self.containerRef:getValue().AbsoluteSize
						self:_setXY(AbsoluteSize.X * 0.5, AbsoluteSize.Y * 0.5)
					end
				else
					self.props.onSetWaypoint(nil)
				end
			end
		}
		local waypointButtonChildren = {}
		local titleProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		titleProps.Text = if #self.props.waypoints == 0 then "Add Waypoint" else "Remove Waypoint"
		titleProps.Font = Enum.Font.LuckiestGuy
		titleProps.LineHeight = 0.7
		titleProps.TextScaled = true
		titleProps.TextXAlignment = Enum.TextXAlignment.Center
		titleProps.TextYAlignment = Enum.TextYAlignment.Center
		titleProps.TextColor3 = Color3.fromRGB(255, 255, 255)
		titleProps.ZIndex = 10
		waypointButtonChildren.Title = createElement("TextLabel", titleProps)
		waypointButtonChildren.AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		})
		waypointButtonChildren.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
		})
		buttonsChildren.Waypoint = createElement("TextButton", waypointButtonProps, waypointButtonChildren)
		containerChildren.Buttons = createElement("Frame", buttonsFrameProps, buttonsChildren)
		return createElement(Minimap, mergedProps, containerChildren)
	end
end
function BigMinimap._setXY(self, x, y)
	local AbsoluteSize = self.containerRef:getValue().AbsoluteSize
	self.x = math.clamp(x, 0, AbsoluteSize.X)
	self.y = math.clamp(y, 0, AbsoluteSize.Y)
	local horizontalRefFrame = self.horizontalRef:getValue()
	local verticalRefFrame = self.verticalRef:getValue()
	if self.state.crossHairEnabled then
		horizontalRefFrame.Position = UDim2.new(0, 0, 0, self.y)
		verticalRefFrame.Position = UDim2.new(0, self.x, 0, 0)
	end
end
function BigMinimap._hookVisible(self, isVisible)
	if isVisible then
		local visibleMaid = Maid.new()
		self.maid.visibleMaid = visibleMaid
		local guiInset = GuiService:GetGuiInset()
		visibleMaid:GiveTask(RunService.Heartbeat:Connect(function()
			local containerFrame = self.containerRef:getValue()
			if self.state.inputType == Enum.UserInputType.Keyboard then
				local adjustedMouseLocation = UserInputService:GetMouseLocation() - guiInset
				local AbsolutePosition = containerFrame.AbsolutePosition
				self:_setXY(adjustedMouseLocation.X - AbsolutePosition.X, adjustedMouseLocation.Y - AbsolutePosition.Y)
			end
		end))
		visibleMaid:GiveTask(UserInputService.InputBegan:Connect(function(inputEvent)
			if self.state.crossHairEnabled and (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or (inputEvent.UserInputType == Enum.UserInputType.Touch or inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.ButtonA)) then
				local containerFrame = self.containerRef:getValue()
				local AbsoluteSize = containerFrame.AbsoluteSize
				if inputEvent.UserInputType == Enum.UserInputType.Touch then
					local AbsolutePosition = containerFrame.AbsolutePosition
					self.x = inputEvent.Position.X - AbsolutePosition.X
					self.y = inputEvent.Position.Y - AbsolutePosition.Y
				end
				local x = self.x
				local y = self.y
				if not (x < 0 or (y < 0 or (AbsoluteSize.X < x or AbsoluteSize.Y < y))) then
					local worldX, worldY = MinimapUtils.computeWorldXY(x, y, self.props.worldPosition:getValue(), self.containerSize:getValue(), self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth, self.props.mapImageHeight, self.props.mapScale)
					if self.props.onSetWaypoint then
						self.props.onSetWaypoint((Vector3.new(worldX, 50, worldY)))
					end
					if self.props.onToggle then
						self.props.onToggle(false)
					end
					self:setState({
						crossHairEnabled = false
					})
				end
			end
		end))
	else
		self.maid.visibleMaid = nil
	end
end
function BigMinimap.didMount(self)
	local function updateInputType()
		local lastInputType = UserInputService:GetLastInputType()
		if (lastInputType == Enum.UserInputType.Gamepad1 or (lastInputType == Enum.UserInputType.Keyboard or lastInputType == Enum.UserInputType.Touch)) and self.state.inputType ~= lastInputType then
			self:setState({
				inputType = lastInputType
			})
		end
	end
	updateInputType()
	self.maid:GiveTask(UserInputService.LastInputTypeChanged:Connect(updateInputType))
end
function BigMinimap.didUpdate(self, previousProps, previousState)
	if self.state.crossHairEnabled ~= previousState.crossHairEnabled then
		self:_hookGamepad(self.state.crossHairEnabled)
	end
	if self.props.visible ~= previousProps.visible then
		self:_hookVisible(self.props.visible)
	end
end
function BigMinimap._hookGamepad(self, isEnabled)
	if isEnabled then
		ContextActionService:BindActionAtPriority("sinkThumb1", function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
		ContextActionService:BindActionAtPriority("sinkJump", function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA)
		local lastInputEvent = nil
		self.maid.selectionDragListen = UserInputService.InputChanged:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.Thumbstick1 then
				lastInputEvent = inputEvent
			end
		end)
		self.maid.dragHeartbeat = RunService.Heartbeat:Connect(function(deltaTime)
			if lastInputEvent then
				local X = lastInputEvent.Position.X
				local Y = lastInputEvent.Position.Y
				if math.abs(X) > 0.1 or math.abs(Y) > 0.1 then
					self:_setXY(self.x + X * 10, self.y - Y * 10, true)
				end
			end
		end)
	else
		ContextActionService:UnbindAction("sinkThumb1")
		ContextActionService:UnbindAction("sinkJump")
		self.maid.selectionDragListen = nil
		self.maid.dragHeartbeat = nil
	end
end
function BigMinimap.willUnmount(self)
	self:_hookGamepad(false)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		labels = state.minimapLabels,
		waypoints = state.minimapWaypoints,
		points = state.minimapPoints,
		circles = state.minimapCircles
	}
end, function(dispatch)
	return {
		onSetWaypoint = function(waypoint)
			if waypoint then
				if MinimapService._addWaypointRemote then
					MinimapService._addWaypointRemote:FireServer(waypoint.X, waypoint.Z)
				end
			else
				dispatch({
					type = "removeWaypointCurrent"
				})
			end
		end
	}
end)(BigMinimap)
