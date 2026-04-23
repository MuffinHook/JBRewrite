require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	local function relocateTooltips() --[[ Line: 4 | Upvalues: p1 (copy), p2 (copy) ]]
		if p1._rootInstance ~= nil then
			local PopupScreenGui = p1._rootInstance:FindFirstChild("PopupScreenGui")
			local TooltipContainer = PopupScreenGui.TooltipContainer
			local v2 = p2.findBestWindowPosForPopup(p2.getMouseLocation(), TooltipContainer.AbsoluteSize, p1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize)
			TooltipContainer.Position = UDim2.fromOffset(v2.X, v2.Y)
		end
	end
	p2.registerEvent("InputChanged", function() --[[ Line: 15 | Upvalues: p1 (copy), relocateTooltips (copy) ]]
		if p1._started then
			relocateTooltips()
		end
	end)
	p1.WidgetConstructor("Tooltip", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 30 | Upvalues: p1 (copy), p2 (copy) ]]
			p12.parentWidget = p1._rootWidget
			local Iris_Tooltip = Instance.new("Frame")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tooltip.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.BackgroundTransparency = 1
			local TooltipText = Instance.new("TextLabel")
			TooltipText.Name = "TooltipText"
			TooltipText.AutomaticSize = Enum.AutomaticSize.XY
			TooltipText.Size = UDim2.fromOffset(0, 0)
			TooltipText.BackgroundColor3 = p1._config.PopupBgColor
			TooltipText.BackgroundTransparency = p1._config.PopupBgTransparency
			p2.applyTextStyle(TooltipText)
			p2.UIStroke(TooltipText, p1._config.PopupBorderSize, p1._config.BorderActiveColor, p1._config.BorderActiveTransparency)
			p2.UIPadding(TooltipText, p1._config.WindowPadding)
			if p1._config.PopupRounding > 0 then
				p2.UICorner(TooltipText, p1._config.PopupRounding)
			end
			TooltipText.Parent = Iris_Tooltip
			return Iris_Tooltip
		end,
		Update = function(p1) --[[ Name: Update | Line: 58 | Upvalues: relocateTooltips (copy) ]]
			if p1.arguments.Text == nil then
				error("Text argument is required for Iris.Tooltip().", 5)
			end
			p1.Instance.TooltipText.Text = p1.arguments.Text
			relocateTooltips()
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 67 ]]
			p1.Instance:Destroy()
		end
	})
	local v1 = 0
	local v2 = nil
	local v3 = false
	local v4 = nil
	local v5 = nil
	local v6 = false
	local v7 = false
	local v8 = false
	local Top = Enum.TopBottom.Top
	local Left = Enum.LeftRight.Left
	local v9 = nil
	local v10 = nil
	local v11 = false
	local t = {}
	local function quickSwapWindows() --[[ Line: 91 | Upvalues: p1 (copy), t (copy) ]]
		if p1._config.UseScreenGUIs == false then
			return
		end
		local v1 = 65535
		local v2 = nil
		for v3, v4 in t do
			if v4.state.isOpened.value and (not v4.arguments.NoNav and v4.Instance:IsA("ScreenGui")) then
				local DisplayOrder = v4.Instance.DisplayOrder
				if DisplayOrder < v1 then
					v1 = DisplayOrder
					v2 = v4
				end
			end
		end
		if v2 then
			if v2.state.isUncollapsed.value == false then
				v2.state.isUncollapsed:set(true)
			end
			p1.SetFocusedWindow(v2)
		end
	end
	local function fitSizeToWindowBounds(p12, p22) --[[ Line: 122 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = Vector2.new(p12.state.position.value.X, p12.state.position.value.Y)
		local v2 = (p1._config.TextSize + 2 * p1._config.FramePadding.Y) * 2
		local v3 = p2.getScreenSizeForWindow(p12) - v1 - Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(p22.X, v2, (math.max(v3.X, v2))), (math.clamp(p22.Y, v2, (math.max(v3.Y, v2)))))
	end
	local function fitPositionToWindowBounds(p12, p22) --[[ Line: 132 | Upvalues: p2 (copy), p1 (copy) ]]
		local v1 = p12.Instance
		local v2 = p2.getScreenSizeForWindow(p12)
		local v3 = Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(p22.X, v3.X, (math.max(v3.X, v2.X - v1.WindowButton.AbsoluteSize.X - v3.X))), (math.clamp(p22.Y, v3.Y, (math.max(v3.Y, v2.Y - v1.WindowButton.AbsoluteSize.Y - v3.Y)))))
	end
	function p1.SetFocusedWindow(p12) --[[ Line: 143 | Upvalues: v10 (ref), v11 (ref), t (copy), p1 (copy), v1 (ref), p2 (copy) ]]
		if v10 ~= p12 then
			if v11 and v10 ~= nil then
				if t[v10.ID] then
					local WindowButton = v10.Instance.WindowButton
					local TitleBar = WindowButton.Content.TitleBar
					if v10.state.isUncollapsed.value then
						TitleBar.BackgroundColor3 = p1._config.TitleBgColor
						TitleBar.BackgroundTransparency = p1._config.TitleBgTransparency
					else
						TitleBar.BackgroundColor3 = p1._config.TitleBgCollapsedColor
						TitleBar.BackgroundTransparency = p1._config.TitleBgCollapsedTransparency
					end
					WindowButton.UIStroke.Color = p1._config.BorderColor
				end
				v11 = false
				v10 = nil
			end
			if p12 ~= nil then
				v11 = true
				v10 = p12
				local v12 = p12.Instance
				local WindowButton = v12.WindowButton
				local TitleBar = WindowButton.Content.TitleBar
				TitleBar.BackgroundColor3 = p1._config.TitleBgActiveColor
				TitleBar.BackgroundTransparency = p1._config.TitleBgActiveTransparency
				WindowButton.UIStroke.Color = p1._config.BorderActiveColor
				v1 = v1 + 1
				if p12.usesScreenGuis then
					v12.DisplayOrder = v1 + p1._config.DisplayOrderOffset
				else
					v12.ZIndex = v1 + p1._config.DisplayOrderOffset
				end
				if p12.state.isUncollapsed.value == false then
					p12.state.isUncollapsed:set(true)
				end
				if p2.GuiService.SelectedObject then
					if TitleBar.Visible then
						p2.GuiService:Select(TitleBar)
						return
					end
					p2.GuiService:Select(p12.ChildContainer)
				end
			end
		end
	end
	p2.registerEvent("InputBegan", function(p12) --[[ Line: 204 | Upvalues: p1 (copy), p2 (copy), t (copy), quickSwapWindows (copy), v7 (ref), v8 (ref), v11 (ref), v10 (ref), Top (ref), Left (ref), v6 (ref), v5 (ref) ]]
		if p1._started then
			if p12.UserInputType == Enum.UserInputType.MouseButton1 then
				local v1 = p2.getMouseLocation()
				for v3, v4 in t do
					local v52 = v4.Instance
					if v52 then
						local ResizeBorder = v52.WindowButton.ResizeBorder
						local _ = ResizeBorder and p2.isPosInsideRect(v1, ResizeBorder.AbsolutePosition - p2.GuiOffset, ResizeBorder.AbsolutePosition - p2.GuiOffset + ResizeBorder.AbsoluteSize)
					end
				end
				if not false then
					p1.SetFocusedWindow(nil)
				end
			end
			if p12.KeyCode == Enum.KeyCode.Tab and (p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
				quickSwapWindows()
			end
			if p12.UserInputType == Enum.UserInputType.MouseButton1 and (v7 and (not v8 and (v11 and v10))) then
				local v72 = p2.getMouseLocation() - (v10.state.position.value + v10.state.size.value / 2)
				local v82 = math.abs(v72.X) * v10.state.size.value.Y
				if math.abs(v72.Y) * v10.state.size.value.X <= v82 then
					Top = Enum.TopBottom.Center
					Left = if math.sign(v72.X) == -1 then Enum.LeftRight.Left else Enum.LeftRight.Right
				else
					Left = Enum.LeftRight.Center
					Top = if math.sign(v72.Y) == -1 then Enum.TopBottom.Top else Enum.TopBottom.Bottom
				end
				v6 = true
				v5 = v10
			end
		end
	end)
	p2.registerEvent("TouchTapInWorld", function(p12, p2) --[[ Line: 250 | Upvalues: p1 (copy) ]]
		if p1._started and not p2 then
			p1.SetFocusedWindow(nil)
		end
	end)
	p2.registerEvent("InputChanged", function(p12) --[[ Line: 259 | Upvalues: p1 (copy), v3 (ref), v2 (ref), p2 (copy), v4 (ref), fitPositionToWindowBounds (copy), v6 (ref), v5 (ref), v9 (ref), Left (ref), Top (ref), fitSizeToWindowBounds (copy) ]]
		if p1._started then
			if v3 and v2 then
				local v1
				if p12.UserInputType == Enum.UserInputType.Touch then
					local Position = p12.Position
					v1 = Vector2.new(Position.X, Position.Y)
				else
					v1 = p2.getMouseLocation()
				end
				local v42 = fitPositionToWindowBounds(v2, v1 - v4)
				v2.Instance.WindowButton.Position = UDim2.fromOffset(v42.X, v42.Y)
				v2.state.position.value = v42
			end
			if v6 and (v5 and v5.arguments.NoResize ~= true) then
				local WindowButton = v5.Instance.WindowButton
				local v52 = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset)
				local v62 = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset)
				local v7 = if p12.UserInputType == Enum.UserInputType.Touch then p12.Delta else p2.getMouseLocation() - v9
				local v11 = v52 + Vector2.new(if Left == Enum.LeftRight.Left then v7.X else 0, if Top == Enum.TopBottom.Top then v7.Y else 0)
				local v15 = fitSizeToWindowBounds(v5, v62 + Vector2.new(if Left == Enum.LeftRight.Left then -v7.X elseif Left == Enum.LeftRight.Right then v7.X else 0, if Top == Enum.TopBottom.Top then -v7.Y elseif Top == Enum.TopBottom.Bottom then v7.Y else 0))
				local v16 = fitPositionToWindowBounds(v5, v11)
				WindowButton.Size = UDim2.fromOffset(v15.X, v15.Y)
				v5.state.size.value = v15
				WindowButton.Position = UDim2.fromOffset(v16.X, v16.Y)
				v5.state.position.value = v16
			end
			v9 = p2.getMouseLocation()
		end
	end)
	p2.registerEvent("InputEnded", function(p12, p2) --[[ Line: 313 | Upvalues: p1 (copy), v3 (ref), v2 (ref), v6 (ref), v5 (ref), quickSwapWindows (copy) ]]
		if p1._started then
			if (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) and (v3 and v2) then
				local WindowButton = v2.Instance.WindowButton
				v3 = false
				v2.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset))
			end
			if (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) and (v6 and v5) then
				v6 = false
				v5.state.size:set(v5.Instance.WindowButton.AbsoluteSize)
			end
			if p12.KeyCode == Enum.KeyCode.ButtonX then
				quickSwapWindows()
			end
		end
	end)
	p1.WidgetConstructor("Window", {
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
				Init = function(p1) --[[ Line: 352 ]] end,
				Get = function(p12) --[[ Line: 353 | Upvalues: p1 (copy) ]]
					return p12.lastClosedTick == p1._cycleTick
				end
			},
			opened = {
				Init = function(p1) --[[ Line: 358 ]] end,
				Get = function(p12) --[[ Line: 359 | Upvalues: p1 (copy) ]]
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			collapsed = {
				Init = function(p1) --[[ Line: 364 ]] end,
				Get = function(p12) --[[ Line: 365 | Upvalues: p1 (copy) ]]
					return p12.lastCollapsedTick == p1._cycleTick
				end
			},
			uncollapsed = {
				Init = function(p1) --[[ Line: 370 ]] end,
				Get = function(p12) --[[ Line: 371 | Upvalues: p1 (copy) ]]
					return p12.lastUncollapsedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 375 ]]
				return p1.Instance.WindowButton
			end)
		},
		Generate = function(p12) --[[ Name: Generate | Line: 380 | Upvalues: p1 (copy), t (copy), p2 (copy), v2 (ref), v3 (ref), v4 (ref), v11 (ref), v10 (ref), v6 (ref), Top (ref), Left (ref), v5 (ref), v7 (ref), v8 (ref) ]]
			p12.parentWidget = p1._rootWidget
			p12.usesScreenGuis = p1._config.UseScreenGUIs
			t[p12.ID] = p12
			local Iris_Window
			if p12.usesScreenGuis then
				local ScreenGui = Instance.new("ScreenGui")
				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.DisplayOrder = p1._config.DisplayOrderOffset
				ScreenGui.ScreenInsets = p1._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = p1._config.IgnoreGuiInset
				Iris_Window = ScreenGui
			else
				local Frame = Instance.new("Frame")
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = p1._config.DisplayOrderOffset
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
			WindowButton.SelectionImageObject = p1.SelectionImageObject
			WindowButton.SelectionGroup = true
			WindowButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			p2.UIStroke(WindowButton, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			WindowButton.Parent = Iris_Window
			p2.applyInputBegan(WindowButton, function(p13) --[[ Line: 425 | Upvalues: p12 (copy), p1 (ref), v2 (ref), v3 (ref), v4 (ref), p2 (ref) ]]
				if p13.UserInputType ~= Enum.UserInputType.MouseMovement and p13.UserInputType ~= Enum.UserInputType.Keyboard then
					if p12.state.isUncollapsed.value then
						p1.SetFocusedWindow(p12)
					end
					if not p12.arguments.NoMove and p13.UserInputType == Enum.UserInputType.MouseButton1 then
						v2 = p12
						v3 = true
						v4 = p2.getMouseLocation() - p12.state.position.value
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
			local v1 = p2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
			v1.HorizontalAlignment = Enum.HorizontalAlignment.Center
			v1.VerticalAlignment = Enum.VerticalAlignment.Top
			local WindowContainer = Instance.new("ScrollingFrame")
			WindowContainer.Name = "WindowContainer"
			WindowContainer.Size = UDim2.fromScale(1, 1)
			WindowContainer.BackgroundColor3 = p1._config.WindowBgColor
			WindowContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			WindowContainer.BorderSizePixel = 0
			WindowContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			WindowContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			WindowContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			WindowContainer.CanvasSize = UDim2.fromScale(0, 0)
			WindowContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			WindowContainer.TopImage = p2.ICONS.BLANK_SQUARE
			WindowContainer.MidImage = p2.ICONS.BLANK_SQUARE
			WindowContainer.BottomImage = p2.ICONS.BLANK_SQUARE
			WindowContainer.LayoutOrder = p12.ZIndex + 65535
			WindowContainer.ClipsDescendants = true
			p2.UIPadding(WindowContainer, p1._config.WindowPadding)
			WindowContainer.Parent = Frame
			local UIFlexItem = Instance.new("UIFlexItem")
			UIFlexItem.FlexMode = Enum.UIFlexMode.Fill
			UIFlexItem.ItemLineAlignment = Enum.ItemLineAlignment.End
			UIFlexItem.Parent = WindowContainer
			WindowContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 480 | Upvalues: p12 (copy), WindowContainer (copy) ]]
				p12.state.scrollDistance.value = WindowContainer.CanvasPosition.Y
			end)
			p2.applyInputBegan(WindowContainer, function(p13) --[[ Line: 485 | Upvalues: p12 (copy), p1 (ref) ]]
				if p13.UserInputType ~= Enum.UserInputType.MouseMovement and p13.UserInputType ~= Enum.UserInputType.Keyboard and p12.state.isUncollapsed.value then
					p1.SetFocusedWindow(p12)
				end
			end)
			local TerminatingFrame = Instance.new("Frame")
			TerminatingFrame.Name = "TerminatingFrame"
			TerminatingFrame.Size = UDim2.fromOffset(0, p1._config.WindowPadding.Y + p1._config.FramePadding.Y)
			TerminatingFrame.BackgroundTransparency = 1
			TerminatingFrame.BorderSizePixel = 0
			TerminatingFrame.LayoutOrder = 2147483632
			p2.UIListLayout(WindowContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
			TerminatingFrame.Parent = WindowContainer
			local TitleBar = Instance.new("Frame")
			TitleBar.Name = "TitleBar"
			TitleBar.AutomaticSize = Enum.AutomaticSize.Y
			TitleBar.Size = UDim2.fromScale(1, 0)
			TitleBar.BorderSizePixel = 0
			TitleBar.ClipsDescendants = true
			TitleBar.Parent = Frame
			p2.UIPadding(TitleBar, Vector2.new(p1._config.FramePadding.X))
			p2.UIListLayout(TitleBar, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInputBegan(TitleBar, function(p1) --[[ Line: 516 | Upvalues: p12 (copy), v2 (ref), v3 (ref), v4 (ref) ]]
				if p1.UserInputType == Enum.UserInputType.Touch and not p12.arguments.NoMove then
					v2 = p12
					v3 = true
					local Position = p1.Position
					v4 = Vector2.new(Position.X, Position.Y) - p12.state.position.value
				end
			end)
			local v22 = p1._config.TextSize + (p1._config.FramePadding.Y - 1) * 2
			local CollapseButton = Instance.new("TextButton")
			CollapseButton.Name = "CollapseButton"
			CollapseButton.AutomaticSize = Enum.AutomaticSize.None
			CollapseButton.AnchorPoint = Vector2.new(0, 0.5)
			CollapseButton.Size = UDim2.fromOffset(v22, v22)
			CollapseButton.Position = UDim2.fromScale(0, 0.5)
			CollapseButton.BackgroundTransparency = 1
			CollapseButton.BorderSizePixel = 0
			CollapseButton.AutoButtonColor = false
			CollapseButton.Text = ""
			p2.UICorner(CollapseButton)
			CollapseButton.Parent = TitleBar
			p2.applyButtonClick(CollapseButton, function() --[[ Line: 544 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)
			p2.applyInteractionHighlights("Background", CollapseButton, CollapseButton, {
				Color = p1._config.ButtonColor,
				Transparency = 1,
				HoveredColor = p1._config.ButtonHoveredColor,
				HoveredTransparency = p1._config.ButtonHoveredTransparency,
				ActiveColor = p1._config.ButtonActiveColor,
				ActiveTransparency = p1._config.ButtonActiveTransparency
			})
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
			Arrow.Size = UDim2.fromOffset(math.floor(0.7 * v22), (math.floor(0.7 * v22)))
			Arrow.Position = UDim2.fromScale(0.5, 0.5)
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.Image = p2.ICONS.MULTIPLICATION_SIGN
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.Parent = CollapseButton
			local CloseButton = Instance.new("TextButton")
			CloseButton.Name = "CloseButton"
			CloseButton.AutomaticSize = Enum.AutomaticSize.None
			CloseButton.AnchorPoint = Vector2.new(1, 0.5)
			CloseButton.Size = UDim2.fromOffset(v22, v22)
			CloseButton.Position = UDim2.fromScale(1, 0.5)
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.AutoButtonColor = false
			CloseButton.LayoutOrder = 2
			p2.UICorner(CloseButton)
			p2.applyButtonClick(CloseButton, function() --[[ Line: 583 | Upvalues: p12 (copy) ]]
				p12.state.isOpened:set(false)
			end)
			p2.applyInteractionHighlights("Background", CloseButton, CloseButton, {
				Color = p1._config.ButtonColor,
				Transparency = 1,
				HoveredColor = p1._config.ButtonHoveredColor,
				HoveredTransparency = p1._config.ButtonHoveredTransparency,
				ActiveColor = p1._config.ButtonActiveColor,
				ActiveTransparency = p1._config.ButtonActiveTransparency
			})
			CloseButton.Parent = TitleBar
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Size = UDim2.fromOffset(math.floor(0.7 * v22), (math.floor(0.7 * v22)))
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Image = p2.ICONS.MULTIPLICATION_SIGN
			Icon.ImageColor3 = p1._config.TextColor
			Icon.ImageTransparency = p1._config.TextTransparency
			Icon.Parent = CloseButton
			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.AutomaticSize = Enum.AutomaticSize.XY
			Title.BorderSizePixel = 0
			Title.BackgroundTransparency = 1
			Title.LayoutOrder = 1
			Title.ClipsDescendants = true
			p2.UIPadding(Title, Vector2.new(0, p1._config.FramePadding.Y))
			p2.applyTextStyle(Title)
			Title.TextXAlignment = Enum.TextXAlignment[p1._config.WindowTitleAlign.Name]
			local UIFlexItem_2 = Instance.new("UIFlexItem")
			UIFlexItem_2.FlexMode = Enum.UIFlexMode.Fill
			UIFlexItem_2.ItemLineAlignment = Enum.ItemLineAlignment.Center
			UIFlexItem_2.Parent = Title
			Title.Parent = TitleBar
			local v32 = p1._config.TextSize + p1._config.FramePadding.X
			local LeftResizeGrip = Instance.new("ImageButton")
			LeftResizeGrip.Name = "LeftResizeGrip"
			LeftResizeGrip.AnchorPoint = Vector2.yAxis
			LeftResizeGrip.Rotation = 180
			LeftResizeGrip.Position = UDim2.fromScale(0, 1)
			LeftResizeGrip.Size = UDim2.fromOffset(v32, v32)
			LeftResizeGrip.BackgroundTransparency = 1
			LeftResizeGrip.BorderSizePixel = 0
			LeftResizeGrip.Image = p2.ICONS.BOTTOM_RIGHT_CORNER
			LeftResizeGrip.ImageColor3 = p1._config.ResizeGripColor
			LeftResizeGrip.ImageTransparency = 1
			LeftResizeGrip.AutoButtonColor = false
			LeftResizeGrip.ZIndex = 3
			LeftResizeGrip.Parent = WindowButton
			p2.applyInteractionHighlights("Image", LeftResizeGrip, LeftResizeGrip, {
				Color = p1._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			p2.applyButtonDown(LeftResizeGrip, function() --[[ Line: 658 | Upvalues: v11 (ref), v10 (ref), p12 (copy), p1 (ref), v6 (ref), Top (ref), Left (ref), v5 (ref) ]]
				if not v11 or v10 ~= p12 then
					p1.SetFocusedWindow(p12)
				end
				v6 = true
				Top = Enum.TopBottom.Bottom
				Left = Enum.LeftRight.Left
				v5 = p12
			end)
			local RightResizeGrip = Instance.new("ImageButton")
			RightResizeGrip.Name = "RightResizeGrip"
			RightResizeGrip.AnchorPoint = Vector2.one
			RightResizeGrip.Rotation = 90
			RightResizeGrip.Position = UDim2.fromScale(1, 1)
			RightResizeGrip.Size = UDim2.fromOffset(v32, v32)
			RightResizeGrip.BackgroundTransparency = 1
			RightResizeGrip.BorderSizePixel = 0
			RightResizeGrip.Image = p2.ICONS.BOTTOM_RIGHT_CORNER
			RightResizeGrip.ImageColor3 = p1._config.ResizeGripColor
			RightResizeGrip.ImageTransparency = p1._config.ResizeGripTransparency
			RightResizeGrip.AutoButtonColor = false
			RightResizeGrip.ZIndex = 3
			RightResizeGrip.Parent = WindowButton
			p2.applyInteractionHighlights("Image", RightResizeGrip, RightResizeGrip, {
				Color = p1._config.ResizeGripColor,
				Transparency = p1._config.ResizeGripTransparency,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			p2.applyButtonDown(RightResizeGrip, function() --[[ Line: 694 | Upvalues: v11 (ref), v10 (ref), p12 (copy), p1 (ref), v6 (ref), Top (ref), Left (ref), v5 (ref) ]]
				if not v11 or v10 ~= p12 then
					p1.SetFocusedWindow(p12)
				end
				v6 = true
				Top = Enum.TopBottom.Bottom
				Left = Enum.LeftRight.Right
				v5 = p12
			end)
			local LeftResizeBorder = Instance.new("ImageButton")
			LeftResizeBorder.Name = "LeftResizeBorder"
			LeftResizeBorder.AnchorPoint = Vector2.new(1, 0.5)
			LeftResizeBorder.Position = UDim2.fromScale(0, 0.5)
			LeftResizeBorder.Size = UDim2.new(0, p1._config.WindowResizePadding.X, 1, 2 * p1._config.WindowBorderSize)
			LeftResizeBorder.Transparency = 1
			LeftResizeBorder.Image = p2.ICONS.BORDER
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
			RightResizeBorder.Size = UDim2.new(0, p1._config.WindowResizePadding.X, 1, 2 * p1._config.WindowBorderSize)
			RightResizeBorder.Transparency = 1
			RightResizeBorder.Image = p2.ICONS.BORDER
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
			TopResizeBorder.Size = UDim2.new(1, 2 * p1._config.WindowBorderSize, 0, p1._config.WindowResizePadding.Y)
			TopResizeBorder.Transparency = 1
			TopResizeBorder.Image = p2.ICONS.BORDER
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
			BottomResizeBorder.Size = UDim2.new(1, 2 * p1._config.WindowBorderSize, 0, p1._config.WindowResizePadding.Y)
			BottomResizeBorder.Transparency = 1
			BottomResizeBorder.Image = p2.ICONS.BORDER
			BottomResizeBorder.ResampleMode = Enum.ResamplerMode.Pixelated
			BottomResizeBorder.ScaleType = Enum.ScaleType.Slice
			BottomResizeBorder.SliceCenter = Rect.new(0, 1, 1, 2)
			BottomResizeBorder.ImageRectOffset = Vector2.new(2, 1)
			BottomResizeBorder.ImageRectSize = Vector2.new(1, 2)
			BottomResizeBorder.ImageTransparency = 1
			BottomResizeBorder.AutoButtonColor = false
			BottomResizeBorder.ZIndex = 4
			BottomResizeBorder.Parent = WindowButton
			p2.applyInteractionHighlights("Image", LeftResizeBorder, LeftResizeBorder, {
				Color = p1._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			p2.applyInteractionHighlights("Image", RightResizeBorder, RightResizeBorder, {
				Color = p1._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			p2.applyInteractionHighlights("Image", TopResizeBorder, TopResizeBorder, {
				Color = p1._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			p2.applyInteractionHighlights("Image", BottomResizeBorder, BottomResizeBorder, {
				Color = p1._config.ResizeGripColor,
				Transparency = 1,
				HoveredColor = p1._config.ResizeGripHoveredColor,
				HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
				ActiveColor = p1._config.ResizeGripActiveColor,
				ActiveTransparency = p1._config.ResizeGripActiveTransparency
			})
			local ResizeBorder = Instance.new("Frame")
			ResizeBorder.Name = "ResizeBorder"
			ResizeBorder.Position = UDim2.fromOffset(-p1._config.WindowResizePadding.X, -p1._config.WindowResizePadding.Y)
			ResizeBorder.Size = UDim2.new(1, p1._config.WindowResizePadding.X * 2, 1, p1._config.WindowResizePadding.Y * 2)
			ResizeBorder.BackgroundTransparency = 1
			ResizeBorder.BorderSizePixel = 0
			ResizeBorder.Active = false
			ResizeBorder.Selectable = false
			ResizeBorder.ClipsDescendants = false
			ResizeBorder.Parent = WindowButton
			p2.applyMouseEnter(ResizeBorder, function() --[[ Line: 824 | Upvalues: v10 (ref), p12 (copy), v7 (ref) ]]
				if v10 == p12 then
					v7 = true
				end
			end)
			p2.applyMouseLeave(ResizeBorder, function() --[[ Line: 829 | Upvalues: v10 (ref), p12 (copy), v7 (ref) ]]
				if v10 == p12 then
					v7 = false
				end
			end)
			p2.applyInputBegan(ResizeBorder, function(p13) --[[ Line: 834 | Upvalues: p12 (copy), p1 (ref) ]]
				if p13.UserInputType ~= Enum.UserInputType.MouseMovement and p13.UserInputType ~= Enum.UserInputType.Keyboard and p12.state.isUncollapsed.value then
					p1.SetFocusedWindow(p12)
				end
			end)
			p2.applyMouseEnter(WindowButton, function() --[[ Line: 843 | Upvalues: v10 (ref), p12 (copy), v8 (ref) ]]
				if v10 == p12 then
					v8 = true
				end
			end)
			p2.applyMouseLeave(WindowButton, function() --[[ Line: 848 | Upvalues: v10 (ref), p12 (copy), v8 (ref) ]]
				if v10 == p12 then
					v8 = false
				end
			end)
			p12.ChildContainer = WindowContainer
			return Iris_Window
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 857 | Upvalues: p1 (copy), v11 (ref), v10 (ref), fitPositionToWindowBounds (copy), fitSizeToWindowBounds (copy) ]]
			if p12.state.size == nil then
				p12.state.size = p1._widgetState(p12, "size", Vector2.new(400, 300))
			end
			if p12.state.position == nil then
				p12.state.position = p1._widgetState(p12, "position", if v11 and v10 then v10.state.position.value + Vector2.new(15, 45) else Vector2.new(150, 250))
			end
			p12.state.position.value = fitPositionToWindowBounds(p12, p12.state.position.value)
			p12.state.size.value = fitSizeToWindowBounds(p12, p12.state.size.value)
			if p12.state.isUncollapsed == nil then
				p12.state.isUncollapsed = p1._widgetState(p12, "isUncollapsed", true)
			end
			if p12.state.isOpened == nil then
				p12.state.isOpened = p1._widgetState(p12, "isOpened", true)
			end
			if p12.state.scrollDistance == nil then
				p12.state.scrollDistance = p1._widgetState(p12, "scrollDistance", 0)
			end
		end,
		Update = function(p12) --[[ Name: Update | Line: 877 | Upvalues: p1 (copy) ]]
			local ChildContainer = p12.ChildContainer
			local WindowButton = p12.Instance.WindowButton
			local v2 = WindowButton.Content
			local TitleBar = v2.TitleBar
			local Title = TitleBar.Title
			local Iris_MenuBar = v2:FindFirstChild("Iris_MenuBar")
			local LeftResizeGrip = WindowButton.LeftResizeGrip
			local RightResizeGrip = WindowButton.RightResizeGrip
			local LeftResizeBorder = WindowButton.LeftResizeBorder
			local RightResizeBorder = WindowButton.RightResizeBorder
			local TopResizeBorder = WindowButton.TopResizeBorder
			local BottomResizeBorder = WindowButton.BottomResizeBorder
			if p12.arguments.NoResize == true then
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
			if p12.arguments.NoScrollbar then
				ChildContainer.ScrollBarThickness = 0
			else
				ChildContainer.ScrollBarThickness = p1._config.ScrollbarSize
			end
			if p12.arguments.NoTitleBar then
				TitleBar.Visible = false
			else
				TitleBar.Visible = true
			end
			if Iris_MenuBar and p12.arguments.NoMenu then
				Iris_MenuBar.Visible = false
			elseif Iris_MenuBar then
				Iris_MenuBar.Visible = true
			end
			if p12.arguments.NoBackground then
				ChildContainer.BackgroundTransparency = 1
			else
				ChildContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			end
			if p12.arguments.NoCollapse then
				TitleBar.CollapseButton.Visible = false
			else
				TitleBar.CollapseButton.Visible = true
			end
			if p12.arguments.NoClose then
				TitleBar.CloseButton.Visible = false
			else
				TitleBar.CloseButton.Visible = true
			end
			Title.Text = p12.arguments.Title or ""
		end,
		UpdateState = function(p12) --[[ Name: UpdateState | Line: 944 | Upvalues: p1 (copy), p2 (copy) ]]
			local value = p12.state.size.value
			local value_2 = p12.state.position.value
			local value_3 = p12.state.isUncollapsed.value
			local value_4 = p12.state.isOpened.value
			local value_5 = p12.state.scrollDistance.value
			local v1 = p12.Instance
			local ChildContainer = p12.ChildContainer
			local WindowButton = v1.WindowButton
			local v2 = WindowButton.Content
			local TitleBar = v2.TitleBar
			local Iris_MenuBar = v2:FindFirstChild("Iris_MenuBar")
			local LeftResizeGrip = WindowButton.LeftResizeGrip
			local RightResizeGrip = WindowButton.RightResizeGrip
			local LeftResizeBorder = WindowButton.LeftResizeBorder
			local RightResizeBorder = WindowButton.RightResizeBorder
			local TopResizeBorder = WindowButton.TopResizeBorder
			local BottomResizeBorder = WindowButton.BottomResizeBorder
			WindowButton.Size = UDim2.fromOffset(value.X, value.Y)
			WindowButton.Position = UDim2.fromOffset(value_2.X, value_2.Y)
			if value_4 then
				if p12.usesScreenGuis then
					v1.Enabled = true
				else
					v1.Visible = true
				end
				WindowButton.Visible = true
				p12.lastOpenedTick = p1._cycleTick + 1
			else
				if p12.usesScreenGuis then
					v1.Enabled = false
				else
					v1.Visible = false
				end
				WindowButton.Visible = false
				p12.lastClosedTick = p1._cycleTick + 1
			end
			if value_3 then
				TitleBar.CollapseButton.Arrow.Image = p2.ICONS.DOWN_POINTING_TRIANGLE
				if Iris_MenuBar then
					Iris_MenuBar.Visible = not p12.arguments.NoMenu
				end
				ChildContainer.Visible = true
				if p12.arguments.NoResize ~= true then
					LeftResizeGrip.Visible = true
					RightResizeGrip.Visible = true
					LeftResizeBorder.Visible = true
					RightResizeBorder.Visible = true
					TopResizeBorder.Visible = true
					BottomResizeBorder.Visible = true
				end
				WindowButton.AutomaticSize = Enum.AutomaticSize.None
				p12.lastUncollapsedTick = p1._cycleTick + 1
			else
				TitleBar.CollapseButton.Arrow.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
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
				WindowButton.Size = UDim2.fromOffset(value.X, TitleBar.AbsoluteSize.Y)
				p12.lastCollapsedTick = p1._cycleTick + 1
			end
			if value_4 and value_3 then
				p1.SetFocusedWindow(p12)
			else
				TitleBar.BackgroundColor3 = p1._config.TitleBgCollapsedColor
				TitleBar.BackgroundTransparency = p1._config.TitleBgCollapsedTransparency
				WindowButton.UIStroke.Color = p1._config.BorderColor
				p1.SetFocusedWindow(nil)
			end
			if value_5 and value_5 ~= 0 then
				local v3 = #p1._postCycleCallbacks + 1
				local v4 = p1._cycleTick + 1
				p1._postCycleCallbacks[v3] = function() --[[ Line: 1035 | Upvalues: p1 (ref), v4 (copy), p12 (copy), ChildContainer (copy), value_5 (copy), v3 (copy) ]]
					if v4 <= p1._cycleTick then
						if p12.lastCycleTick ~= -1 then
							ChildContainer.CanvasPosition = Vector2.new(0, value_5)
						end
						p1._postCycleCallbacks[v3] = nil
					end
				end
			end
		end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 1045 ]]
			local v1 = p1.Instance.WindowButton.Content
			if p2.type == "MenuBar" then
				local ChildContainer = p1.ChildContainer
				p2.Instance.ZIndex = ChildContainer.ZIndex + 1
				p2.Instance.LayoutOrder = ChildContainer.LayoutOrder - 1
				return v1
			else
				return p1.ChildContainer
			end
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 1057 | Upvalues: v10 (ref), v11 (ref), v2 (ref), v3 (ref), v5 (ref), v6 (ref), t (copy), p2 (copy) ]]
			if v10 == p1 then
				v10 = nil
				v11 = false
			end
			if v2 == p1 then
				v2 = nil
				v3 = false
			end
			if v5 == p1 then
				v5 = nil
				v6 = false
			end
			t[p1.ID] = nil
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end