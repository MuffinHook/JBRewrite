require(script.Parent.Parent.Types)
return function(Iris, Utils)
	local function relocateTooltips()
		if Iris._rootInstance ~= nil then
			local PopupScreenGui = Iris._rootInstance:FindFirstChild("PopupScreenGui")
			local TooltipContainer = PopupScreenGui.TooltipContainer
			local tooltipPosition = Utils.findBestWindowPosForPopup(Utils.getMouseLocation(), TooltipContainer.AbsoluteSize, Iris._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize)
			TooltipContainer.Position = UDim2.fromOffset(tooltipPosition.X, tooltipPosition.Y)
		end
	end
	Utils.registerEvent("InputChanged", function()
		if Iris._started then
			relocateTooltips()
		end
	end)
	Iris.WidgetConstructor("Tooltip", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {},
		Generate = function(widget)
			widget.parentWidget = Iris._rootWidget
			local Iris_Tooltip = Instance.new("Frame")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tooltip.Size = UDim2.new(Iris._config.ContentWidth, UDim.new(0, 0))
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.BackgroundTransparency = 1
			local TooltipText = Instance.new("TextLabel")
			TooltipText.Name = "TooltipText"
			TooltipText.AutomaticSize = Enum.AutomaticSize.XY
			TooltipText.Size = UDim2.fromOffset(0, 0)
			TooltipText.BackgroundColor3 = Iris._config.PopupBgColor
			TooltipText.BackgroundTransparency = Iris._config.PopupBgTransparency
			Utils.applyTextStyle(TooltipText)
			Utils.UIStroke(TooltipText, Iris._config.PopupBorderSize, Iris._config.BorderActiveColor, Iris._config.BorderActiveTransparency)
			Utils.UIPadding(TooltipText, Iris._config.WindowPadding)
			if Iris._config.PopupRounding > 0 then
				Utils.UICorner(TooltipText, Iris._config.PopupRounding)
			end
			TooltipText.Parent = Iris_Tooltip
			return Iris_Tooltip
		end,
		Update = function(widget)
			if widget.arguments.Text == nil then
				error("Text argument is required for Iris.Tooltip().", 5)
			end
			widget.Instance.TooltipText.Text = widget.arguments.Text
			relocateTooltips()
		end,
		Discard = function(widget)
			widget.Instance:Destroy()
		end
	})
	local maxDisplayOrder = 0
	local movingWindow = nil
	local isMoving = false
	local moveOffset = nil
	local resizingWidget = nil
	local isResizing = false
	local isResizeBorderHovered = false
	local isWindowButtonHovered = false
	local resizeDirectionVertical = Enum.TopBottom.Top
	local resizeDirectionHorizontal = Enum.LeftRight.Left
	local lastMousePosition = nil
	local focusedWindow = nil
	local hasFocusedWindow = false
	local windowsTable = {}
	local function quickSwapWindows()
		if Iris._config.UseScreenGUIs == false then
			return
		end
		local minDisplayOrder = 65535
		local topWindow = nil
		for windowId, windowData in windowsTable do
			if windowData.state.isOpened.value and (not windowData.arguments.NoNav and windowData.Instance:IsA("ScreenGui")) then
				local DisplayOrder = windowData.Instance.DisplayOrder
				if DisplayOrder < minDisplayOrder then
					minDisplayOrder = DisplayOrder
					topWindow = windowData
				end
			end
		end
		if topWindow then
			if topWindow.state.isUncollapsed.value == false then
				topWindow.state.isUncollapsed:set(true)
			end
			Iris.SetFocusedWindow(topWindow)
		end
	end
	local function fitSizeToWindowBounds(widget, targetSize)
		local currentPosition = Vector2.new(widget.state.position.value.X, widget.state.position.value.Y)
		local minSize = (Iris._config.TextSize + 2 * Iris._config.FramePadding.Y) * 2
		local availableSpace = Utils.getScreenSizeForWindow(widget) - currentPosition - Vector2.new(Iris._config.WindowBorderSize + Iris._config.DisplaySafeAreaPadding.X, Iris._config.WindowBorderSize + Iris._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(targetSize.X, minSize, (math.max(availableSpace.X, minSize))), (math.clamp(targetSize.Y, minSize, (math.max(availableSpace.Y, minSize)))))
	end
	local function fitPositionToWindowBounds(widget, targetPosition)
		local windowInstance = widget.Instance
		local screenSize = Utils.getScreenSizeForWindow(widget)
		local safeAreaPadding = Vector2.new(Iris._config.WindowBorderSize + Iris._config.DisplaySafeAreaPadding.X, Iris._config.WindowBorderSize + Iris._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(targetPosition.X, safeAreaPadding.X, (math.max(safeAreaPadding.X, screenSize.X - windowInstance.WindowButton.AbsoluteSize.X - safeAreaPadding.X))), (math.clamp(targetPosition.Y, safeAreaPadding.Y, (math.max(safeAreaPadding.Y, screenSize.Y - windowInstance.WindowButton.AbsoluteSize.Y - safeAreaPadding.Y)))))
	end
	function Iris.SetFocusedWindow(widget)
		if focusedWindow ~= widget then
			if hasFocusedWindow and focusedWindow ~= nil then
				if windowsTable[focusedWindow.ID] then
					local WindowButton = focusedWindow.Instance.WindowButton
					local TitleBar = WindowButton.Content.TitleBar
					if focusedWindow.state.isUncollapsed.value then
						TitleBar.BackgroundColor3 = Iris._config.TitleBgColor
						TitleBar.BackgroundTransparency = Iris._config.TitleBgTransparency
					else
						TitleBar.BackgroundColor3 = Iris._config.TitleBgCollapsedColor
						TitleBar.BackgroundTransparency = Iris._config.TitleBgCollapsedTransparency
					end
					WindowButton.UIStroke.Color = Iris._config.BorderColor
				end
				hasFocusedWindow = false
				focusedWindow = nil
			end
			if widget ~= nil then
				hasFocusedWindow = true
				focusedWindow = widget
				local windowInstance = widget.Instance
				local WindowButton = windowInstance.WindowButton
				local TitleBar = WindowButton.Content.TitleBar
				TitleBar.BackgroundColor3 = Iris._config.TitleBgActiveColor
				TitleBar.BackgroundTransparency = Iris._config.TitleBgActiveTransparency
				WindowButton.UIStroke.Color = Iris._config.BorderActiveColor
				maxDisplayOrder = maxDisplayOrder + 1
				if widget.usesScreenGuis then
					windowInstance.DisplayOrder = maxDisplayOrder + Iris._config.DisplayOrderOffset
				else
					windowInstance.ZIndex = maxDisplayOrder + Iris._config.DisplayOrderOffset
				end
				if widget.state.isUncollapsed.value == false then
					widget.state.isUncollapsed:set(true)
				end
				if Utils.GuiService.SelectedObject then
					if TitleBar.Visible then
						Utils.GuiService:Select(TitleBar)
						return
					end
					Utils.GuiService:Select(widget.ChildContainer)
				end
			end
		end
	end
	Utils.registerEvent("InputBegan", function(input)
		if Iris._started then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mousePos = Utils.getMouseLocation()
				for windowId, windowData in windowsTable do
					local windowInstance = windowData.Instance
					if windowInstance then
						local ResizeBorder = windowInstance.WindowButton.ResizeBorder
						local _ = ResizeBorder and Utils.isPosInsideRect(mousePos, ResizeBorder.AbsolutePosition - Utils.GuiOffset, ResizeBorder.AbsolutePosition - Utils.GuiOffset + ResizeBorder.AbsoluteSize)
					end
				end
				if not false then
					Iris.SetFocusedWindow(nil)
				end
			end
			if input.KeyCode == Enum.KeyCode.Tab and (Utils.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or Utils.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
				quickSwapWindows()
			end
			if input.UserInputType == Enum.UserInputType.MouseButton1 and (isResizeBorderHovered and (not isWindowButtonHovered and (hasFocusedWindow and focusedWindow))) then
				local offsetFromCenter = Utils.getMouseLocation() - (focusedWindow.state.position.value + focusedWindow.state.size.value / 2)
				local horizontalArea = math.abs(offsetFromCenter.X) * focusedWindow.state.size.value.Y
				if math.abs(offsetFromCenter.Y) * focusedWindow.state.size.value.X <= horizontalArea then
					resizeDirectionVertical = Enum.TopBottom.Center
					resizeDirectionHorizontal = if math.sign(offsetFromCenter.X) == -1 then Enum.LeftRight.Left else Enum.LeftRight.Right
				else
					resizeDirectionHorizontal = Enum.LeftRight.Center
					resizeDirectionVertical = if math.sign(offsetFromCenter.Y) == -1 then Enum.TopBottom.Top else Enum.TopBottom.Bottom
				end
				isResizing = true
				resizingWidget = focusedWindow
			end
		end
	end)
	Utils.registerEvent("TouchTapInWorld", function(input, touchInGui)
		if Iris._started and not touchInGui then
			Iris.SetFocusedWindow(nil)
		end
	end)
	Utils.registerEvent("InputChanged", function(input)
		if Iris._started then
			if isMoving and movingWindow then
				local currentMousePos
				if input.UserInputType == Enum.UserInputType.Touch then
					local Position = input.Position
					currentMousePos = Vector2.new(Position.X, Position.Y)
				else
					currentMousePos = Utils.getMouseLocation()
				end
				local newPosition = fitPositionToWindowBounds(movingWindow, currentMousePos - moveOffset)
				movingWindow.Instance.WindowButton.Position = UDim2.fromOffset(newPosition.X, newPosition.Y)
				movingWindow.state.position.value = newPosition
			end
			if isResizing and (resizingWidget and resizingWidget.arguments.NoResize ~= true) then
				local WindowButton = resizingWidget.Instance.WindowButton
				local currentWindowPos = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset)
				local currentWindowSize = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset)
				local mouseDelta = if input.UserInputType == Enum.UserInputType.Touch then input.Delta else Utils.getMouseLocation() - lastMousePosition
				local newWindowPos = currentWindowPos + Vector2.new(if resizeDirectionHorizontal == Enum.LeftRight.Left then mouseDelta.X else 0, if resizeDirectionVertical == Enum.TopBottom.Top then mouseDelta.Y else 0)
				local newWindowSize = fitSizeToWindowBounds(resizingWidget, currentWindowSize + Vector2.new(if resizeDirectionHorizontal == Enum.LeftRight.Left then -mouseDelta.X elseif resizeDirectionHorizontal == Enum.LeftRight.Right then mouseDelta.X else 0, if resizeDirectionVertical == Enum.TopBottom.Top then -mouseDelta.Y elseif resizeDirectionVertical == Enum.TopBottom.Bottom then mouseDelta.Y else 0))
				local clampedWindowPos = fitPositionToWindowBounds(resizingWidget, newWindowPos)
				WindowButton.Size = UDim2.fromOffset(newWindowSize.X, newWindowSize.Y)
				resizingWidget.state.size.value = newWindowSize
				WindowButton.Position = UDim2.fromOffset(clampedWindowPos.X, clampedWindowPos.Y)
				resizingWidget.state.position.value = clampedWindowPos
			end
			lastMousePosition = Utils.getMouseLocation()
		end
	end)
	Utils.registerEvent("InputEnded", function(input, touchInGui)
		if Iris._started then
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (isMoving and movingWindow) then
				local WindowButton = movingWindow.Instance.WindowButton
				isMoving = false
				movingWindow.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset))
			end
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (isResizing and resizingWidget) then
				isResizing = false
				resizingWidget.state.size:set(resizingWidget.Instance.WindowButton.AbsoluteSize)
			end
			if input.KeyCode == Enum.KeyCode.ButtonX then
				quickSwapWindows()
			end
		end
	end)
	Iris.WidgetConstructor("Window", {
		hasState = true,
		hasChildren = true,
		Args = {
			Title = 1,
			NoTitleBar = 2,
			NoBackground = 3,
			NoCollapse = 4,
			NoClose = 5,
			NoMove = 6,
			NoScrollbar = 7,
			NoResize = 8,
			NoNav = 9,
			NoMenu = 10
		},
		Events = {
			closed = {
				Init = function(widget) end,
				Get = function(widget)
					return widget.lastClosedTick == Iris._cycleTick
				end
			},
			opened = {
				Init = function(widget) end,
				Get = function(widget)
					return widget.lastOpenedTick == Iris._cycleTick
				end
			},
			collapsed = {
				Init = function(widget) end,
				Get = function(widget)
					return widget.lastCollapsedTick == Iris._cycleTick
				end
			},
			uncollapsed = {
				Init = function(widget) end,
				Get = function(widget)
					return widget.lastUncollapsedTick == Iris._cycleTick
				end
			},
			hovered = Utils.EVENTS.hover(function(widget)
				return widget.Instance.WindowButton
			end)
		},
		Generate = function(widget)
			widget.parentWidget = Iris._rootWidget
			widget.usesScreenGuis = Iris._config.UseScreenGUIs
			windowsTable[widget.ID] = widget
			local Iris_Window
			if widget.usesScreenGuis then
				local ScreenGui = Instance.new("ScreenGui")
				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.DisplayOrder = Iris._config.DisplayOrderOffset
				ScreenGui.ScreenInsets = Iris._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = Iris._config.IgnoreGuiInset
				Iris_Window = ScreenGui
			else
				local Frame = Instance.new("Frame")
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = Iris._config.DisplayOrderOffset
				Iris_Window = Frame
			end
			Iris_Window.Name = "Iris_Window"
			local WindowButton = Instance.new("TextButton")
			WindowButton.Name = "WindowButton"
			WindowButton.Size = UDim2.fromOffset(0, 0)
			WindowButton.BackgroundTransparency = 1
			WindowButton.BorderSizePixel = 0
			WindowButton.Text = ""
			WindowButton.AutoButtonColor = false
			WindowButton.ClipsDescendants = false
			WindowButton.Selectable = false
			WindowButton.SelectionImageObject = Iris.SelectionImageObject
			WindowButton.SelectionGroup = true
			WindowButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			Utils.UIStroke(WindowButton, Iris._config.WindowBorderSize, Iris._config.BorderColor, Iris._config.BorderTransparency)
			WindowButton.Parent = Iris_Window
			Utils.applyInputBegan(WindowButton, function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Keyboard then
					if widget.state.isUncollapsed.value then
						Iris.SetFocusedWindow(widget)
					end
					if not widget.arguments.NoMove and input.UserInputType == Enum.UserInputType.MouseButton1 then
						movingWindow = widget
						isMoving = true
						moveOffset = Utils.getMouseLocation() - widget.state.position.value
					end
				end
			end)
			local Frame = Instance.new("Frame")
			Frame.Name = "Content"
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.Position = UDim2.fromScale(0.5, 0.5)
			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundTransparency = 1
			Frame.ClipsDescendants = true
			Frame.Parent = WindowButton
			local contentLayout = Utils.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
			contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			contentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			local WindowContainer = Instance.new("ScrollingFrame")
			WindowContainer.Name = "WindowContainer"
			WindowContainer.Size = UDim2.fromScale(1, 1)
			WindowContainer.BackgroundColor3 = Iris._config.WindowBgColor
			WindowContainer.BackgroundTransparency = Iris._config.WindowBgTransparency
			WindowContainer.BorderSizePixel = 0
			WindowContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			WindowContainer.ScrollBarImageTransparency = Iris._config.ScrollbarGrabTransparency
			WindowContainer.ScrollBarImageColor3 = Iris._config.ScrollbarGrabColor
			WindowContainer.CanvasSize = UDim2.fromScale(0, 0)
			WindowContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			WindowContainer.TopImage = Utils.ICONS.BLANK_SQUARE
			WindowContainer.MidImage = Utils.ICONS.BLANK_SQUARE
			WindowContainer.BottomImage = Utils.ICONS.BLANK_SQUARE
			WindowContainer.LayoutOrder = widget.ZIndex + 65535
			WindowContainer.ClipsDescendants = true
			Utils.UIPadding(WindowContainer, Iris._config.WindowPadding)
			WindowContainer.Parent = Frame
			local UIFlexItem = Instance.new("UIFlexItem")
			UIFlexItem.FlexMode = Enum.UIFlexMode.Fill
			UIFlexItem.ItemLineAlignment = Enum.ItemLineAlignment.End
			UIFlexItem.Parent = WindowContainer
			WindowContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
				widget.state.scrollDistance.value = WindowContainer.CanvasPosition.Y
			end)
			Utils.applyInputBegan(WindowContainer, function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Keyboard and widget.state.isUncollapsed.value then
					Iris.SetFocusedWindow(widget)
				end
			end)
			local TerminatingFrame = Instance.new("Frame")
			TerminatingFrame.Name = "TerminatingFrame"
			TerminatingFrame.Size = UDim2.fromOffset(0, Iris._config.WindowPadding.Y + Iris._config.FramePadding.Y)
			TerminatingFrame.BackgroundTransparency = 1
			TerminatingFrame.BorderSizePixel = 0
			TerminatingFrame.LayoutOrder = 2147483632
			Utils.UIListLayout(WindowContainer, Enum.FillDirection.Vertical, UDim.new(0, Iris._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
			TerminatingFrame.Parent = WindowContainer
			local TitleBar = Instance.new("Frame")
			TitleBar.Name = "TitleBar"
			TitleBar.AutomaticSize = Enum.AutomaticSize.Y
			TitleBar.Size = UDim2.fromScale(1, 0)
			TitleBar.BorderSizePixel = 0
			TitleBar.ClipsDescendants = true
			TitleBar.Parent = Frame
			Utils.UIPadding(TitleBar, Vector2.new(Iris._config.FramePadding.X))
			Utils.UIListLayout(TitleBar, Enum.FillDirection.Horizontal, UDim.new(0, Iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			Utils.applyInputBegan(TitleBar, function(input)
				if input.UserInputType == Enum.UserInputType.Touch and not widget.arguments.NoMove then
					movingWindow = widget
					isMoving = true
					local Position = input.Position
					moveOffset = Vector2.new(Position.X, Position.Y) - widget.state.position.value
				end
			end)
			local buttonSize = Iris._config.TextSize + (Iris._config.FramePadding.Y - 1) * 2
			local CollapseButton = Instance.new("TextButton")
			CollapseButton.Name = "CollapseButton"
			CollapseButton.AutomaticSize = Enum.AutomaticSize.None
			CollapseButton.AnchorPoint = Vector2.new(0, 0.5)
			CollapseButton.Size = UDim2.fromOffset(buttonSize, buttonSize)
			CollapseButton.Position = UDim2.fromScale(0, 0.5)
			CollapseButton.BackgroundTransparency = 1
			CollapseButton.BorderSizePixel = 0
			CollapseButton.AutoButtonColor = false
			CollapseButton.Text = ""
			Utils.UICorner(CollapseButton)
			CollapseButton.Parent = TitleBar
			Utils.applyButtonClick(CollapseButton, function()
				widget.state.isUncollapsed:set(not widget.state.isUncollapsed.value)
			end)
			Utils.applyInteractionHighlights("Background", CollapseButton, CollapseButton, {
				Color = Iris._config.ButtonColor,
				Transparency = 1,
				HoveredColor = Iris._config.ButtonHoveredColor,
				HoveredTransparency = Iris._config.ButtonHoveredTransparency,
				ActiveColor = Iris._config.ButtonActiveColor,
				ActiveTransparency = Iris._config.ButtonActiveTransparency
			})
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
			Arrow.Size = UDim2.fromOffset(math.floor(0.7 * buttonSize), (math.floor(0.7 * buttonSize)))
			Arrow.Position = UDim2.fromScale(0.5, 0.5)
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.Image = Utils.ICONS.MULTIPLICATION_SIGN
			Arrow.ImageColor3 = Iris._config.TextColor
			Arrow.ImageTransparency = Iris._config.TextTransparency
			Arrow.Parent = CollapseButton
			local CloseButton = Instance.new("TextButton")
			CloseButton.Name = "CloseButton"
			CloseButton.AutomaticSize = Enum.AutomaticSize.None
			CloseButton.AnchorPoint = Vector2.new(1, 0.5)
			CloseButton.Size = UDim2.fromOffset(buttonSize, buttonSize)
			CloseButton.Position = UDim2.fromScale(1, 0.5)
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.AutoButtonColor = false
			CloseButton.LayoutOrder = 2
			Utils.UICorner(CloseButton)
			Utils.applyButtonClick(CloseButton, function()
				widget.state.isOpened:set(false)
			end)
			Utils.applyInteractionHighlights("Background", CloseButton, CloseButton, {
				Color = Iris._config.ButtonColor,
				Transparency = 1,
				HoveredColor = Iris._config.ButtonHoveredColor,
				HoveredTransparency = Iris._config.ButtonHoveredTransparency,
				ActiveColor = Iris._config.ButtonActiveColor,
				ActiveTransparency = Iris._config.ButtonActiveTransparency
			})
			CloseButton.Parent = TitleBar
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Size = UDim2.fromOffset(math.floor(0.7 * buttonSize), (math.floor(0.7 * buttonSize)))
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Image = Utils.ICONS.MULTIPLICATION_SIGN
			Icon.ImageColor3 = Iris._config.TextColor
			Icon.ImageTransparency = Iris._config.TextTransparency
			Icon.Parent = CloseButton
			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.AutomaticSize = Enum.AutomaticSize.XY
			Title.BorderSizePixel = 0
			Title.BackgroundTransparency = 1
			Title.LayoutOrder = 1
			Title.ClipsDescendants = true
			Utils.UIPadding(Title, Vector2.new(0, Iris._config.FramePadding.Y))
			Utils.applyTextStyle(Title)
			Title.TextXAlignment = Enum.TextXAlignment[Iris._config.WindowTitleAlign.Name]
			local UIFlexItem_2 = Instance.new("UIFlexItem")
			UIFlexItem_2.FlexMode = Enum.UIFlexMode.Fill
			UIFlexItem_2.ItemLineAlignment = Enum.ItemLineAlignment.Center
			UIFlexItem_2.Parent = Title
			Title.Parent = TitleBar
			local gripSize = Iris._config.TextSize + Iris._config.FramePadding.X
			local LeftResizeGrip = Instance.new("ImageButton")
			LeftResizeGrip.Name = "LeftResizeGrip"
			LeftResizeGrip.AnchorPoint = Vector2.yAxis
			LeftResizeGrip.Rotation = 180
			LeftResizeGrip.Position = UDim2.fromScale(0, 1)
			LeftResizeGrip.Size = UDim2.fromOffset(gripSize, gripSize)
			LeftResizeGrip.BackgroundTransparency = 1
			LeftResizeGrip.BorderSizePixel = 0
			LeftResizeGrip.Image = Utils.ICONS.BOTTOM_RIGHT_CORNER
			LeftResizeGrip.ImageColor3 = Iris._config.ResizeGripColor
			LeftResizeGrip.ImageTransparency = 1
			LeftResizeGrip.AutoButtonColor = false
			LeftResizeGrip.ZIndex = 3
			LeftResizeGrip.Parent = WindowButton
			Utils.applyInteractionHighlights("Image", LeftResizeGrip, LeftResizeGrip, {
				Color = Iris._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			Utils.applyButtonDown(LeftResizeGrip, function()
				if not hasFocusedWindow or focusedWindow ~= widget then
					Iris.SetFocusedWindow(widget)
				end
				isResizing = true
				resizeDirectionVertical = Enum.TopBottom.Bottom
				resizeDirectionHorizontal = Enum.LeftRight.Left
				resizingWidget = widget
			end)
			local RightResizeGrip = Instance.new("ImageButton")
			RightResizeGrip.Name = "RightResizeGrip"
			RightResizeGrip.AnchorPoint = Vector2.one
			RightResizeGrip.Rotation = 90
			RightResizeGrip.Position = UDim2.fromScale(1, 1)
			RightResizeGrip.Size = UDim2.fromOffset(gripSize, gripSize)
			RightResizeGrip.BackgroundTransparency = 1
			RightResizeGrip.BorderSizePixel = 0
			RightResizeGrip.Image = Utils.ICONS.BOTTOM_RIGHT_CORNER
			RightResizeGrip.ImageColor3 = Iris._config.ResizeGripColor
			RightResizeGrip.ImageTransparency = Iris._config.ResizeGripTransparency
			RightResizeGrip.AutoButtonColor = false
			RightResizeGrip.ZIndex = 3
			RightResizeGrip.Parent = WindowButton
			Utils.applyInteractionHighlights("Image", RightResizeGrip, RightResizeGrip, {
				Color = Iris._config.ResizeGripColor,
				Transparency = Iris._config.ResizeGripTransparency,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			Utils.applyButtonDown(RightResizeGrip, function()
				if not hasFocusedWindow or focusedWindow ~= widget then
					Iris.SetFocusedWindow(widget)
				end
				isResizing = true
				resizeDirectionVertical = Enum.TopBottom.Bottom
				resizeDirectionHorizontal = Enum.LeftRight.Right
				resizingWidget = widget
			end)
			local LeftResizeBorder = Instance.new("ImageButton")
			LeftResizeBorder.Name = "LeftResizeBorder"
			LeftResizeBorder.AnchorPoint = Vector2.new(1, 0.5)
			LeftResizeBorder.Position = UDim2.fromScale(0, 0.5)
			LeftResizeBorder.Size = UDim2.new(0, Iris._config.WindowResizePadding.X, 1, 2 * Iris._config.WindowBorderSize)
			LeftResizeBorder.Transparency = 1
			LeftResizeBorder.Image = Utils.ICONS.BORDER
			LeftResizeBorder.ResampleMode = Enum.ResamplerMode.Pixelated
			LeftResizeBorder.ScaleType = Enum.ScaleType.Slice
			LeftResizeBorder.SliceCenter = Rect.new(0, 0, 1, 1)
			LeftResizeBorder.ImageRectOffset = Vector2.new(2, 2)
			LeftResizeBorder.ImageRectSize = Vector2.new(2, 1)
			LeftResizeBorder.ImageTransparency = 1
			LeftResizeBorder.AutoButtonColor = false
			LeftResizeBorder.ZIndex = 4
			LeftResizeBorder.Parent = WindowButton
			local RightResizeBorder = Instance.new("ImageButton")
			RightResizeBorder.Name = "RightResizeBorder"
			RightResizeBorder.AnchorPoint = Vector2.new(0, 0.5)
			RightResizeBorder.Position = UDim2.fromScale(1, 0.5)
			RightResizeBorder.Size = UDim2.new(0, Iris._config.WindowResizePadding.X, 1, 2 * Iris._config.WindowBorderSize)
			RightResizeBorder.Transparency = 1
			RightResizeBorder.Image = Utils.ICONS.BORDER
			RightResizeBorder.ResampleMode = Enum.ResamplerMode.Pixelated
			RightResizeBorder.ScaleType = Enum.ScaleType.Slice
			RightResizeBorder.SliceCenter = Rect.new(1, 0, 2, 1)
			RightResizeBorder.ImageRectOffset = Vector2.new(1, 2)
			RightResizeBorder.ImageRectSize = Vector2.new(2, 1)
			RightResizeBorder.ImageTransparency = 1
			RightResizeBorder.AutoButtonColor = false
			RightResizeBorder.ZIndex = 4
			RightResizeBorder.Parent = WindowButton
			local TopResizeBorder = Instance.new("ImageButton")
			TopResizeBorder.Name = "TopResizeBorder"
			TopResizeBorder.AnchorPoint = Vector2.new(0.5, 1)
			TopResizeBorder.Position = UDim2.fromScale(0.5, 0)
			TopResizeBorder.Size = UDim2.new(1, 2 * Iris._config.WindowBorderSize, 0, Iris._config.WindowResizePadding.Y)
			TopResizeBorder.Transparency = 1
			TopResizeBorder.Image = Utils.ICONS.BORDER
			TopResizeBorder.ResampleMode = Enum.ResamplerMode.Pixelated
			TopResizeBorder.ScaleType = Enum.ScaleType.Slice
			TopResizeBorder.SliceCenter = Rect.new(0, 0, 1, 1)
			TopResizeBorder.ImageRectOffset = Vector2.new(2, 2)
			TopResizeBorder.ImageRectSize = Vector2.new(1, 2)
			TopResizeBorder.ImageTransparency = 1
			TopResizeBorder.AutoButtonColor = false
			TopResizeBorder.ZIndex = 4
			TopResizeBorder.Parent = WindowButton
			local BottomResizeBorder = Instance.new("ImageButton")
			BottomResizeBorder.Name = "BottomResizeBorder"
			BottomResizeBorder.AnchorPoint = Vector2.new(0.5, 0)
			BottomResizeBorder.Position = UDim2.fromScale(0.5, 1)
			BottomResizeBorder.Size = UDim2.new(1, 2 * Iris._config.WindowBorderSize, 0, Iris._config.WindowResizePadding.Y)
			BottomResizeBorder.Transparency = 1
			BottomResizeBorder.Image = Utils.ICONS.BORDER
			BottomResizeBorder.ResampleMode = Enum.ResamplerMode.Pixelated
			BottomResizeBorder.ScaleType = Enum.ScaleType.Slice
			BottomResizeBorder.SliceCenter = Rect.new(0, 1, 1, 2)
			BottomResizeBorder.ImageRectOffset = Vector2.new(2, 1)
			BottomResizeBorder.ImageRectSize = Vector2.new(1, 2)
			BottomResizeBorder.ImageTransparency = 1
			BottomResizeBorder.AutoButtonColor = false
			BottomResizeBorder.ZIndex = 4
			BottomResizeBorder.Parent = WindowButton
			Utils.applyInteractionHighlights("Image", LeftResizeBorder, LeftResizeBorder, {
				Color = Iris._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			Utils.applyInteractionHighlights("Image", RightResizeBorder, RightResizeBorder, {
				Color = Iris._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			Utils.applyInteractionHighlights("Image", TopResizeBorder, TopResizeBorder, {
				Color = Iris._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			Utils.applyInteractionHighlights("Image", BottomResizeBorder, BottomResizeBorder, {
				Color = Iris._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = Iris._config.ResizeGripHoveredColor,
				HoveredTransparency = Iris._config.ResizeGripHoveredTransparency,
				ActiveColor = Iris._config.ResizeGripActiveColor,
				ActiveTransparency = Iris._config.ResizeGripActiveTransparency
			})
			local ResizeBorder = Instance.new("Frame")
			ResizeBorder.Name = "ResizeBorder"
			ResizeBorder.Position = UDim2.fromOffset(-Iris._config.WindowResizePadding.X, -Iris._config.WindowResizePadding.Y)
			ResizeBorder.Size = UDim2.new(1, Iris._config.WindowResizePadding.X * 2, 1, Iris._config.WindowResizePadding.Y * 2)
			ResizeBorder.BackgroundTransparency = 1
			ResizeBorder.BorderSizePixel = 0
			ResizeBorder.Active = false
			ResizeBorder.Selectable = false
			ResizeBorder.ClipsDescendants = false
			ResizeBorder.Parent = WindowButton
			Utils.applyMouseEnter(ResizeBorder, function()
				if focusedWindow == widget then
					isResizeBorderHovered = true
				end
			end)
			Utils.applyMouseLeave(ResizeBorder, function()
				if focusedWindow == widget then
					isResizeBorderHovered = false
				end
			end)
			Utils.applyInputBegan(ResizeBorder, function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Keyboard and widget.state.isUncollapsed.value then
					Iris.SetFocusedWindow(widget)
				end
			end)
			Utils.applyMouseEnter(WindowButton, function()
				if focusedWindow == widget then
					isWindowButtonHovered = true
				end
			end)
			Utils.applyMouseLeave(WindowButton, function()
				if focusedWindow == widget then
					isWindowButtonHovered = false
				end
			end)
			widget.ChildContainer = WindowContainer
			return Iris_Window
		end,
		GenerateState = function(widget)
			if widget.state.size == nil then
				widget.state.size = Iris._widgetState(widget, "size", Vector2.new(400, 300))
			end
			if widget.state.position == nil then
				widget.state.position = Iris._widgetState(widget, "position", if hasFocusedWindow and focusedWindow then focusedWindow.state.position.value + Vector2.new(15, 45) else Vector2.new(150, 250))
			end
			widget.state.position.value = fitPositionToWindowBounds(widget, widget.state.position.value)
			widget.state.size.value = fitSizeToWindowBounds(widget, widget.state.size.value)
			if widget.state.isUncollapsed == nil then
				widget.state.isUncollapsed = Iris._widgetState(widget, "isUncollapsed", true)
			end
			if widget.state.isOpened == nil then
				widget.state.isOpened = Iris._widgetState(widget, "isOpened", true)
			end
			if widget.state.scrollDistance == nil then
				widget.state.scrollDistance = Iris._widgetState(widget, "scrollDistance", 0)
			end
		end,
		Update = function(widget)
			local ChildContainer = widget.ChildContainer
			local WindowButton = widget.Instance.WindowButton
			local contentFrame = WindowButton.Content
			local TitleBar = contentFrame.TitleBar
			local Title = TitleBar.Title
			local Iris_MenuBar = contentFrame:FindFirstChild("Iris_MenuBar")
			local LeftResizeGrip = WindowButton.LeftResizeGrip
			local RightResizeGrip = WindowButton.RightResizeGrip
			local LeftResizeBorder = WindowButton.LeftResizeBorder
			local RightResizeBorder = WindowButton.RightResizeBorder
			local TopResizeBorder = WindowButton.TopResizeBorder
			local BottomResizeBorder = WindowButton.BottomResizeBorder
			if widget.arguments.NoResize == true then
				LeftResizeGrip.Visible = false
				RightResizeGrip.Visible = false
				LeftResizeBorder.Visible = false
				RightResizeBorder.Visible = false
				TopResizeBorder.Visible = false
				BottomResizeBorder.Visible = false
			else
				LeftResizeGrip.Visible = true
				RightResizeGrip.Visible = true
				LeftResizeBorder.Visible = true
				RightResizeBorder.Visible = true
				TopResizeBorder.Visible = true
				BottomResizeBorder.Visible = true
			end
			if widget.arguments.NoScrollbar then
				ChildContainer.ScrollBarThickness = 0
			else
				ChildContainer.ScrollBarThickness = Iris._config.ScrollbarSize
			end
			if widget.arguments.NoTitleBar then
				TitleBar.Visible = false
			else
				TitleBar.Visible = true
			end
			if Iris_MenuBar and widget.arguments.NoMenu then
				Iris_MenuBar.Visible = false
			elseif Iris_MenuBar then
				Iris_MenuBar.Visible = true
			end
			if widget.arguments.NoBackground then
				ChildContainer.BackgroundTransparency = 1
			else
				ChildContainer.BackgroundTransparency = Iris._config.WindowBgTransparency
			end
			if widget.arguments.NoCollapse then
				TitleBar.CollapseButton.Visible = false
			else
				TitleBar.CollapseButton.Visible = true
			end
			if widget.arguments.NoClose then
				TitleBar.CloseButton.Visible = false
			else
				TitleBar.CloseButton.Visible = true
			end
			Title.Text = widget.arguments.Title or ""
		end,
		UpdateState = function(widget)
			local sizeValue = widget.state.size.value
			local positionValue = widget.state.position.value
			local isUncollapsedValue = widget.state.isUncollapsed.value
			local isOpenedValue = widget.state.isOpened.value
			local scrollDistanceValue = widget.state.scrollDistance.value
			local windowInstance = widget.Instance
			local ChildContainer = widget.ChildContainer
			local WindowButton = windowInstance.WindowButton
			local contentFrame = WindowButton.Content
			local TitleBar = contentFrame.TitleBar
			local Iris_MenuBar = contentFrame:FindFirstChild("Iris_MenuBar")
			local LeftResizeGrip = WindowButton.LeftResizeGrip
			local RightResizeGrip = WindowButton.RightResizeGrip
			local LeftResizeBorder = WindowButton.LeftResizeBorder
			local RightResizeBorder = WindowButton.RightResizeBorder
			local TopResizeBorder = WindowButton.TopResizeBorder
			local BottomResizeBorder = WindowButton.BottomResizeBorder
			WindowButton.Size = UDim2.fromOffset(sizeValue.X, sizeValue.Y)
			WindowButton.Position = UDim2.fromOffset(positionValue.X, positionValue.Y)
			if isOpenedValue then
				if widget.usesScreenGuis then
					windowInstance.Enabled = true
				else
					windowInstance.Visible = true
				end
				WindowButton.Visible = true
				widget.lastOpenedTick = Iris._cycleTick + 1
			else
				if widget.usesScreenGuis then
					windowInstance.Enabled = false
				else
					windowInstance.Visible = false
				end
				WindowButton.Visible = false
				widget.lastClosedTick = Iris._cycleTick + 1
			end
			if isUncollapsedValue then
				TitleBar.CollapseButton.Arrow.Image = Utils.ICONS.DOWN_POINTING_TRIANGLE
				if Iris_MenuBar then
					Iris_MenuBar.Visible = not widget.arguments.NoMenu
				end
				ChildContainer.Visible = true
				if widget.arguments.NoResize ~= true then
					LeftResizeGrip.Visible = true
					RightResizeGrip.Visible = true
					LeftResizeBorder.Visible = true
					RightResizeBorder.Visible = true
					TopResizeBorder.Visible = true
					BottomResizeBorder.Visible = true
				end
				WindowButton.AutomaticSize = Enum.AutomaticSize.None
				widget.lastUncollapsedTick = Iris._cycleTick + 1
			else
				TitleBar.CollapseButton.Arrow.Image = Utils.ICONS.RIGHT_POINTING_TRIANGLE
				if Iris_MenuBar then
					Iris_MenuBar.Visible = false
				end
				ChildContainer.Visible = false
				LeftResizeGrip.Visible = false
				RightResizeGrip.Visible = false
				LeftResizeBorder.Visible = false
				RightResizeBorder.Visible = false
				TopResizeBorder.Visible = false
				BottomResizeBorder.Visible = false
				WindowButton.Size = UDim2.fromOffset(sizeValue.X, TitleBar.AbsoluteSize.Y)
				widget.lastCollapsedTick = Iris._cycleTick + 1
			end
			if isOpenedValue and isUncollapsedValue then
				Iris.SetFocusedWindow(widget)
			else
				TitleBar.BackgroundColor3 = Iris._config.TitleBgCollapsedColor
				TitleBar.BackgroundTransparency = Iris._config.TitleBgCollapsedTransparency
				WindowButton.UIStroke.Color = Iris._config.BorderColor
				Iris.SetFocusedWindow(nil)
			end
			if scrollDistanceValue and scrollDistanceValue ~= 0 then
				local callbackIndex = #Iris._postCycleCallbacks + 1
				local targetCycleTick = Iris._cycleTick + 1
				Iris._postCycleCallbacks[callbackIndex] = function()
					if targetCycleTick <= Iris._cycleTick then
						if widget.lastCycleTick ~= -1 then
							ChildContainer.CanvasPosition = Vector2.new(0, scrollDistanceValue)
						end
						Iris._postCycleCallbacks[callbackIndex] = nil
					end
				end
			end
		end,
		ChildAdded = function(widget, childWidget)
			local contentInstance = widget.Instance.WindowButton.Content
			if childWidget.type == "MenuBar" then
				local ChildContainer = widget.ChildContainer
				childWidget.Instance.ZIndex = ChildContainer.ZIndex + 1
				childWidget.Instance.LayoutOrder = ChildContainer.LayoutOrder - 1
				return contentInstance
			else
				return widget.ChildContainer
			end
		end,
		Discard = function(widget)
			if focusedWindow == widget then
				focusedWindow = nil
				hasFocusedWindow = false
			end
			if movingWindow == widget then
				movingWindow = nil
				isMoving = false
			end
			if resizingWidget == widget then
				resizingWidget = nil
				isResizing = false
			end
			windowsTable[widget.ID] = nil
			widget.Instance:Destroy()
			Utils.discardState(widget)
		end
	})
end
