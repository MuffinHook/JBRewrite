-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local function relocateTooltips()
		if p1._rootInstance ~= nil then
			local PopupScreenGui = p1._rootInstance:FindFirstChild("PopupScreenGui")
			local TooltipContainer = PopupScreenGui.TooltipContainer
			local v2 = p2.findBestWindowPosForPopup(p2.getMouseLocation(), TooltipContainer.AbsoluteSize, p1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize)
			TooltipContainer.Position = UDim2.fromOffset(v2.X, v2.Y)
		end
	end
	p2.registerEvent("InputChanged", function()
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
		Generate = function(p12)
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
		Update = function(p1)
			if p1.arguments.Text == nil then
				error("Text argument is required for Iris.Tooltip().", 5)
			end
			p1.Instance.TooltipText.Text = p1.arguments.Text
			relocateTooltips()
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
		end
	})
	local instance = 0
	local v2 = nil
	local var3 = false
	local var4 = nil
	local var5 = nil
	local var6 = false
	local var7 = false
	local var8 = false
	local Top = Enum.TopBottom.Top
	local Left = Enum.LeftRight.Left
	local var9 = nil
	local var10 = nil
	local var11 = false
	local t = {}
	local function quickSwapWindows()
		if p1._config.UseScreenGUIs == false then
			return
		end
		local instance = 65535
		local v2 = nil
		for var3, var4 in t do
			if var4.state.isOpened.value and (not var4.arguments.NoNav and var4.Instance:IsA("ScreenGui")) then
				local DisplayOrder = var4.Instance.DisplayOrder
				if DisplayOrder < instance then
					instance = DisplayOrder
					v2 = var4
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
	local function fitSizeToWindowBounds(p12, p22)
		local instance = Vector2.new(p12.state.position.value.X, p12.state.position.value.Y)
		local v2 = (p1._config.TextSize + 2 * p1._config.FramePadding.Y) * 2
		local var3 = p2.getScreenSizeForWindow(p12) - instance - Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(p22.X, v2, (math.max(var3.X, v2))), (math.clamp(p22.Y, v2, (math.max(var3.Y, v2)))))
	end
	local function fitPositionToWindowBounds(p12, p22)
		local instance = p12.Instance
		local v2 = p2.getScreenSizeForWindow(p12)
		local var3 = Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(p22.X, var3.X, (math.max(var3.X, v2.X - instance.WindowButton.AbsoluteSize.X - var3.X))), (math.clamp(p22.Y, var3.Y, (math.max(var3.Y, v2.Y - instance.WindowButton.AbsoluteSize.Y - var3.Y)))))
	end
	function p1.SetFocusedWindow(p12)
		if var10 ~= p12 then
			if var11 and var10 ~= nil then
				if t[var10.ID] then
					local WindowButton = var10.Instance.WindowButton
					local TitleBar = WindowButton.Content.TitleBar
					if var10.state.isUncollapsed.value then
						TitleBar.BackgroundColor3 = p1._config.TitleBgColor
						TitleBar.BackgroundTransparency = p1._config.TitleBgTransparency
					else
						TitleBar.BackgroundColor3 = p1._config.TitleBgCollapsedColor
						TitleBar.BackgroundTransparency = p1._config.TitleBgCollapsedTransparency
					end
					WindowButton.UIStroke.Color = p1._config.BorderColor
				end
				var11 = false
				var10 = nil
			end
			if p12 ~= nil then
				var11 = true
				var10 = p12
				local instance12 = p12.Instance
				local WindowButton = instance12.WindowButton
				local TitleBar = WindowButton.Content.TitleBar
				TitleBar.BackgroundColor3 = p1._config.TitleBgActiveColor
				TitleBar.BackgroundTransparency = p1._config.TitleBgActiveTransparency
				WindowButton.UIStroke.Color = p1._config.BorderActiveColor
				instance = instance + 1
				if p12.usesScreenGuis then
					instance12.DisplayOrder = instance + p1._config.DisplayOrderOffset
				else
					instance12.ZIndex = instance + p1._config.DisplayOrderOffset
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
	p2.registerEvent("InputBegan", function(p12)
		if p1._started then
			if p12.UserInputType == Enum.UserInputType.MouseButton1 then
				local instance = p2.getMouseLocation()
				for var3, var4 in t do
					local instance52 = var4.Instance
					if instance52 then
						local ResizeBorder = instance52.WindowButton.ResizeBorder
						local _ = ResizeBorder and p2.isPosInsideRect(instance, ResizeBorder.AbsolutePosition - p2.GuiOffset, ResizeBorder.AbsolutePosition - p2.GuiOffset + ResizeBorder.AbsoluteSize)
					end
				end
				if not false then
					p1.SetFocusedWindow(nil)
				end
			end
			if p12.KeyCode == Enum.KeyCode.Tab and (p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
				quickSwapWindows()
			end
			if p12.UserInputType == Enum.UserInputType.MouseButton1 and (var7 and (not var8 and (var11 and var10))) then
				local var72 = p2.getMouseLocation() - (var10.state.position.value + var10.state.size.value / 2)
				local var82 = math.abs(var72.X) * var10.state.size.value.Y
				if math.abs(var72.Y) * var10.state.size.value.X <= var82 then
					Top = Enum.TopBottom.Center
					Left = if math.sign(var72.X) == -1 then Enum.LeftRight.Left else Enum.LeftRight.Right
				else
					Left = Enum.LeftRight.Center
					Top = if math.sign(var72.Y) == -1 then Enum.TopBottom.Top else Enum.TopBottom.Bottom
				end
				var6 = true
				var5 = var10
			end
		end
	end)
	p2.registerEvent("TouchTapInWorld", function(p12, p2)
		if p1._started and not p2 then
			p1.SetFocusedWindow(nil)
		end
	end)
	p2.registerEvent("InputChanged", function(p12)
		if p1._started then
			if var3 and v2 then
				local instance
				if p12.UserInputType == Enum.UserInputType.Touch then
					local Position = p12.Position
					instance = Vector2.new(Position.X, Position.Y)
				else
					instance = p2.getMouseLocation()
				end
				local var42 = fitPositionToWindowBounds(v2, instance - var4)
				v2.Instance.WindowButton.Position = UDim2.fromOffset(var42.X, var42.Y)
				v2.state.position.value = var42
			end
			if var6 and (var5 and var5.arguments.NoResize ~= true) then
				local WindowButton = var5.Instance.WindowButton
				local instance52 = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset)
				local instance62 = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset)
				local var7 = if p12.UserInputType == Enum.UserInputType.Touch then p12.Delta else p2.getMouseLocation() - var9
				local var11 = instance52 + Vector2.new(if Left == Enum.LeftRight.Left then var7.X else 0, if Top == Enum.TopBottom.Top then var7.Y else 0)
				local instance15 = fitSizeToWindowBounds(var5, instance62 + Vector2.new(if Left == Enum.LeftRight.Left then -var7.X elseif Left == Enum.LeftRight.Right then var7.X else 0, if Top == Enum.TopBottom.Top then -var7.Y elseif Top == Enum.TopBottom.Bottom then var7.Y else 0))
				local var16 = fitPositionToWindowBounds(var5, var11)
				WindowButton.Size = UDim2.fromOffset(instance15.X, instance15.Y)
				var5.state.size.value = instance15
				WindowButton.Position = UDim2.fromOffset(var16.X, var16.Y)
				var5.state.position.value = var16
			end
			var9 = p2.getMouseLocation()
		end
	end)
	p2.registerEvent("InputEnded", function(p12, p2)
		if p1._started then
			if (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) and (var3 and v2) then
				local WindowButton = v2.Instance.WindowButton
				var3 = false
				v2.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset))
			end
			if (p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch) and (var6 and var5) then
				var6 = false
				var5.state.size:set(var5.Instance.WindowButton.AbsoluteSize)
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
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastClosedTick == p1._cycleTick
				end
			},
			opened = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			collapsed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastCollapsedTick == p1._cycleTick
				end
			},
			uncollapsed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastUncollapsedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance.WindowButton
			end)
		},
		Generate = function(p12)
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
			p2.applyInputBegan(WindowButton, function(p13)
				if p13.UserInputType ~= Enum.UserInputType.MouseMovement and p13.UserInputType ~= Enum.UserInputType.Keyboard then
					if p12.state.isUncollapsed.value then
						p1.SetFocusedWindow(p12)
					end
					if not p12.arguments.NoMove and p13.UserInputType == Enum.UserInputType.MouseButton1 then
						v2 = p12
						var3 = true
						var4 = p2.getMouseLocation() - p12.state.position.value
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
			local instance = p2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
			instance.HorizontalAlignment = Enum.HorizontalAlignment.Center
			instance.VerticalAlignment = Enum.VerticalAlignment.Top
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
			WindowContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
				p12.state.scrollDistance.value = WindowContainer.CanvasPosition.Y
			end)
			p2.applyInputBegan(WindowContainer, function(p13)
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
			p2.applyInputBegan(TitleBar, function(p1)
				if p1.UserInputType == Enum.UserInputType.Touch and not p12.arguments.NoMove then
					v2 = p12
					var3 = true
					local Position = p1.Position
					var4 = Vector2.new(Position.X, Position.Y) - p12.state.position.value
				end
			end)
			local var22 = p1._config.TextSize + (p1._config.FramePadding.Y - 1) * 2
			local CollapseButton = Instance.new("TextButton")
			CollapseButton.Name = "CollapseButton"
			CollapseButton.AutomaticSize = Enum.AutomaticSize.None
			CollapseButton.AnchorPoint = Vector2.new(0, 0.5)
			CollapseButton.Size = UDim2.fromOffset(var22, var22)
			CollapseButton.Position = UDim2.fromScale(0, 0.5)
			CollapseButton.BackgroundTransparency = 1
			CollapseButton.BorderSizePixel = 0
			CollapseButton.AutoButtonColor = false
			CollapseButton.Text = ""
			p2.UICorner(CollapseButton)
			CollapseButton.Parent = TitleBar
			p2.applyButtonClick(CollapseButton, function()
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
			Arrow.Size = UDim2.fromOffset(math.floor(0.7 * var22), (math.floor(0.7 * var22)))
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
			CloseButton.Size = UDim2.fromOffset(var22, var22)
			CloseButton.Position = UDim2.fromScale(1, 0.5)
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.AutoButtonColor = false
			CloseButton.LayoutOrder = 2
			p2.UICorner(CloseButton)
			p2.applyButtonClick(CloseButton, function()
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
			Icon.Size = UDim2.fromOffset(math.floor(0.7 * var22), (math.floor(0.7 * var22)))
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
			local var32 = p1._config.TextSize + p1._config.FramePadding.X
			local LeftResizeGrip = Instance.new("ImageButton")
			LeftResizeGrip.Name = "LeftResizeGrip"
			LeftResizeGrip.AnchorPoint = Vector2.yAxis
			LeftResizeGrip.Rotation = 180
			LeftResizeGrip.Position = UDim2.fromScale(0, 1)
			LeftResizeGrip.Size = UDim2.fromOffset(var32, var32)
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
			p2.applyButtonDown(LeftResizeGrip, function()
				if not var11 or var10 ~= p12 then
					p1.SetFocusedWindow(p12)
				end
				var6 = true
				Top = Enum.TopBottom.Bottom
				Left = Enum.LeftRight.Left
				var5 = p12
			end)
			local RightResizeGrip = Instance.new("ImageButton")
			RightResizeGrip.Name = "RightResizeGrip"
			RightResizeGrip.AnchorPoint = Vector2.one
			RightResizeGrip.Rotation = 90
			RightResizeGrip.Position = UDim2.fromScale(1, 1)
			RightResizeGrip.Size = UDim2.fromOffset(var32, var32)
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
			p2.applyButtonDown(RightResizeGrip, function()
				if not var11 or var10 ~= p12 then
					p1.SetFocusedWindow(p12)
				end
				var6 = true
				Top = Enum.TopBottom.Bottom
				Left = Enum.LeftRight.Right
				var5 = p12
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
			p2.applyMouseEnter(ResizeBorder, function()
				if var10 == p12 then
					var7 = true
				end
			end)
			p2.applyMouseLeave(ResizeBorder, function()
				if var10 == p12 then
					var7 = false
				end
			end)
			p2.applyInputBegan(ResizeBorder, function(p13)
				if p13.UserInputType ~= Enum.UserInputType.MouseMovement and p13.UserInputType ~= Enum.UserInputType.Keyboard and p12.state.isUncollapsed.value then
					p1.SetFocusedWindow(p12)
				end
			end)
			p2.applyMouseEnter(WindowButton, function()
				if var10 == p12 then
					var8 = true
				end
			end)
			p2.applyMouseLeave(WindowButton, function()
				if var10 == p12 then
					var8 = false
				end
			end)
			p12.ChildContainer = WindowContainer
			return Iris_Window
		end,
		GenerateState = function(p12)
			if p12.state.size == nil then
				p12.state.size = p1._widgetState(p12, "size", Vector2.new(400, 300))
			end
			if p12.state.position == nil then
				p12.state.position = p1._widgetState(p12, "position", if var11 and var10 then var10.state.position.value + Vector2.new(15, 45) else Vector2.new(150, 250))
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
		Update = function(p12)
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
		UpdateState = function(p12)
			local value = p12.state.size.value
			local value_2 = p12.state.position.value
			local value_3 = p12.state.isUncollapsed.value
			local value_4 = p12.state.isOpened.value
			local value_5 = p12.state.scrollDistance.value
			local instance = p12.Instance
			local ChildContainer = p12.ChildContainer
			local WindowButton = instance.WindowButton
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
					instance.Enabled = true
				else
					instance.Visible = true
				end
				WindowButton.Visible = true
				p12.lastOpenedTick = p1._cycleTick + 1
			else
				if p12.usesScreenGuis then
					instance.Enabled = false
				else
					instance.Visible = false
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
				local var3 = #p1._postCycleCallbacks + 1
				local var4 = p1._cycleTick + 1
				p1._postCycleCallbacks[var3] = function()
					if var4 <= p1._cycleTick then
						if p12.lastCycleTick ~= -1 then
							ChildContainer.CanvasPosition = Vector2.new(0, value_5)
						end
						p1._postCycleCallbacks[var3] = nil
					end
				end
			end
		end,
		ChildAdded = function(p1, p2)
			local instance = p1.Instance.WindowButton.Content
			if p2.type == "MenuBar" then
				local ChildContainer = p1.ChildContainer
				p2.Instance.ZIndex = ChildContainer.ZIndex + 1
				p2.Instance.LayoutOrder = ChildContainer.LayoutOrder - 1
				return instance
			else
				return p1.ChildContainer
			end
		end,
		Discard = function(p1)
			if var10 == p1 then
				var10 = nil
				var11 = false
			end
			if v2 == p1 then
				v2 = nil
				var3 = false
			end
			if var5 == p1 then
				var5 = nil
				var6 = false
			end
			t[p1.ID] = nil
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end
