-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local v1 = false
	local v2 = nil
	local t = {}
	local function EmptyMenuStack(p12)
		for i = #t, p12 and p12 + 1 or 1, -1 do
			local v3 = t[i]
			v3.state.isOpened:set(false)
			v3.Instance.BackgroundColor3 = p1._config.HeaderColor
			v3.Instance.BackgroundTransparency = 1
			table.remove(t, i)
		end
		if #t == 0 then
			v1 = false
			v2 = nil
		end
	end
	local function UpdateChildContainerTransform(p12)
		local isType = p12.parentWidget.type == "Menu"
		local v1 = p12.Instance
		local ChildContainer = p12.ChildContainer
		ChildContainer.Size = UDim2.fromOffset(v1.AbsoluteSize.X, 0)
		if ChildContainer.Parent ~= nil then
			local v2 = v1.AbsolutePosition - p2.GuiOffset
			local AbsoluteSize = v1.AbsoluteSize
			local AbsoluteSize_2 = ChildContainer.AbsoluteSize
			local PopupBorderSize = p1._config.PopupBorderSize
			local AbsoluteSize_3 = ChildContainer.Parent.AbsoluteSize
			local X = v2.X
			local zero = Vector2.zero
			if isType and v2.X + AbsoluteSize_2.X > AbsoluteSize_3.X then
				zero = Vector2.xAxis
			elseif isType then
				X = v2.X + AbsoluteSize.X
			end
			local v3
			if v2.Y + AbsoluteSize_2.Y > AbsoluteSize_3.Y then
				zero = zero + Vector2.yAxis
				v3 = v2.Y - PopupBorderSize + (isType and AbsoluteSize.Y or 0)
			else
				v3 = v2.Y + PopupBorderSize + if isType then 0 else AbsoluteSize.Y
			end
			ChildContainer.Position = UDim2.fromOffset(X, v3)
			ChildContainer.AnchorPoint = zero
		end
	end
	p2.registerEvent("InputBegan", function(p12)
		if p1._started and ((p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.MouseButton2) and (v1 ~= false and v2 ~= nil)) then
			local v12 = p2.getMouseLocation()
			local v22 = false
			for v3, v4 in t do
				for v5, v6 in { v4.ChildContainer, v4.Instance } do
					local v7 = v6.AbsolutePosition - p2.GuiOffset
					if p2.isPosInsideRect(v12, v7, v7 + v6.AbsoluteSize) then
						v22 = true
						break
					end
				end
				if v22 then
					break
				end
			end
			if not v22 then
				EmptyMenuStack()
			end
		end
	end)
	p1.WidgetConstructor("MenuBar", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12)
			local Iris_MenuBar = Instance.new("Frame")
			Iris_MenuBar.Name = "Iris_MenuBar"
			Iris_MenuBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuBar.Size = UDim2.fromScale(1, 0)
			Iris_MenuBar.BackgroundColor3 = p1._config.MenubarBgColor
			Iris_MenuBar.BackgroundTransparency = p1._config.MenubarBgTransparency
			Iris_MenuBar.BorderSizePixel = 0
			Iris_MenuBar.ClipsDescendants = true
			p2.UIPadding(Iris_MenuBar, Vector2.new(p1._config.WindowPadding.X, 1))
			p2.UIListLayout(Iris_MenuBar, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyFrameStyle(Iris_MenuBar, true, true)
			return Iris_MenuBar
		end,
		Update = function(p1) end,
		ChildAdded = function(p1, p2)
			return p1.Instance
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("Menu", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end),
			opened = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			closed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastClosedTick == p1._cycleTick
				end
			}
		},
		Generate = function(p12)
			p12.ButtonColors = {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderHoveredColor,
				ActiveTransparency = p1._config.HeaderHoveredTransparency
			}
			local v12
			if p12.parentWidget.type == "Menu" then
				local Menu = Instance.new("TextButton")
				Menu.Name = "Menu"
				Menu.AutomaticSize = Enum.AutomaticSize.Y
				Menu.Size = UDim2.fromScale(1, 0)
				Menu.BackgroundColor3 = p1._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Text = ""
				Menu.AutoButtonColor = false
				local v22 = p2.UIPadding(Menu, p1._config.FramePadding)
				v22.PaddingTop = v22.PaddingTop - UDim.new(0, 1)
				p2.UIListLayout(Menu, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Menu
				local v3 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
				local v4 = v3 - math.round(0.2 * v3) * 2
				local Icon = Instance.new("ImageLabel")
				Icon.Name = "Icon"
				Icon.Size = UDim2.fromOffset(v4, v4)
				Icon.BackgroundTransparency = 1
				Icon.BorderSizePixel = 0
				Icon.ImageColor3 = p1._config.TextColor
				Icon.ImageTransparency = p1._config.TextTransparency
				Icon.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
				Icon.LayoutOrder = 1
				Icon.Parent = Menu
				v12 = Menu
			else
				local Menu = Instance.new("TextButton")
				Menu.Name = "Menu"
				Menu.AutomaticSize = Enum.AutomaticSize.XY
				Menu.Size = UDim2.fromScale(0, 0)
				Menu.BackgroundColor3 = p1._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Text = ""
				Menu.AutoButtonColor = false
				Menu.ClipsDescendants = true
				p2.applyTextStyle(Menu)
				p2.UIPadding(Menu, Vector2.new(p1._config.ItemSpacing.X, p1._config.FramePadding.Y))
				v12 = Menu
			end
			p2.applyInteractionHighlights("Background", v12, v12, p12.ButtonColors)
			p2.applyButtonClick(v12, function()
				local v12 = if #t <= 1 then not p12.state.isOpened.value else true
				p12.state.isOpened:set(v12)
				v1 = v12
				v2 = v12 and p12 or nil
				if #t <= 1 then
					if v12 then
						table.insert(t, p12)
						return
					end
					table.remove(t)
				end
			end)
			p2.applyMouseEnter(v12, function()
				if v1 and (v2 and v2 ~= p12) then
					EmptyMenuStack((table.find(t, p12.parentWidget)))
					p12.state.isOpened:set(true)
					v2 = p12
					v1 = true
					table.insert(t, p12)
				end
			end)
			local MenuContainer = Instance.new("ScrollingFrame")
			MenuContainer.Name = "MenuContainer"
			MenuContainer.AutomaticSize = Enum.AutomaticSize.XY
			MenuContainer.Size = UDim2.fromOffset(0, 0)
			MenuContainer.BackgroundColor3 = p1._config.PopupBgColor
			MenuContainer.BackgroundTransparency = p1._config.PopupBgTransparency
			MenuContainer.BorderSizePixel = 0
			MenuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			MenuContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			MenuContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			MenuContainer.ScrollBarThickness = p1._config.ScrollbarSize
			MenuContainer.CanvasSize = UDim2.fromScale(0, 0)
			MenuContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			MenuContainer.TopImage = p2.ICONS.BLANK_SQUARE
			MenuContainer.MidImage = p2.ICONS.BLANK_SQUARE
			MenuContainer.BottomImage = p2.ICONS.BLANK_SQUARE
			MenuContainer.ZIndex = 6
			MenuContainer.LayoutOrder = 6
			MenuContainer.ClipsDescendants = true
			p2.UIStroke(MenuContainer, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			p2.UIPadding(MenuContainer, Vector2.new(2, p1._config.WindowPadding.Y - p1._config.ItemSpacing.Y))
			p2.UIListLayout(MenuContainer, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
			MenuContainer.Parent = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			p12.ChildContainer = MenuContainer
			return v12
		end,
		Update = function(p1)
			local v1 = p1.Instance;
			(if p1.parentWidget.type == "Menu" then v1.TextLabel else v1).Text = p1.arguments.Text or "Menu"
		end,
		ChildAdded = function(p1, p2)
			UpdateChildContainerTransform(p1)
			return p1.ChildContainer
		end,
		ChildDiscarded = function(p1, p2)
			UpdateChildContainerTransform(p1)
		end,
		GenerateState = function(p12)
			if p12.state.isOpened == nil then
				p12.state.isOpened = p1._widgetState(p12, "isOpened", false)
			end
		end,
		UpdateState = function(p12)
			local ChildContainer = p12.ChildContainer
			if p12.state.isOpened.value then
				p12.lastOpenedTick = p1._cycleTick + 1
				p12.ButtonColors.Transparency = p1._config.HeaderTransparency
				ChildContainer.Visible = true
				UpdateChildContainerTransform(p12)
			else
				p12.lastClosedTick = p1._cycleTick + 1
				p12.ButtonColors.Transparency = 1
				ChildContainer.Visible = false
			end
		end,
		Discard = function(p1)
			if v1 then
				local parentWidget = p1.parentWidget
				local v12 = table.find(t, parentWidget)
				if v12 then
					EmptyMenuStack(v12)
					if #t ~= 0 then
						v2 = parentWidget
						v1 = true
					end
				end
			end
			p1.Instance:Destroy()
			p1.ChildContainer:Destroy()
			p2.discardState(p1)
		end
	})
	p1.WidgetConstructor("MenuItem", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_MenuItem = Instance.new("TextButton")
			Iris_MenuItem.Name = "Iris_MenuItem"
			Iris_MenuItem.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuItem.Size = UDim2.fromScale(1, 0)
			Iris_MenuItem.BackgroundTransparency = 1
			Iris_MenuItem.BorderSizePixel = 0
			Iris_MenuItem.Text = ""
			Iris_MenuItem.AutoButtonColor = false
			local v12 = p2.UIPadding(Iris_MenuItem, p1._config.FramePadding)
			v12.PaddingTop = v12.PaddingTop - UDim.new(0, 1)
			p2.UIListLayout(Iris_MenuItem, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))
			p2.applyInteractionHighlights("Background", Iris_MenuItem, Iris_MenuItem, {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderHoveredColor,
				ActiveTransparency = p1._config.HeaderHoveredTransparency
			})
			p2.applyButtonClick(Iris_MenuItem, function()
				EmptyMenuStack()
			end)
			p2.applyMouseEnter(Iris_MenuItem, function()
				local parentWidget = p12.parentWidget
				if v1 and (v2 and v2 ~= parentWidget) then
					EmptyMenuStack((table.find(t, parentWidget)))
					v2 = parentWidget
					v1 = true
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_MenuItem
			local Shortcut = Instance.new("TextLabel")
			Shortcut.Name = "Shortcut"
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.LayoutOrder = 1
			p2.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = p1._config.TextDisabledColor
			Shortcut.TextTransparency = p1._config.TextDisabledTransparency
			Shortcut.Parent = Iris_MenuItem
			return Iris_MenuItem
		end,
		Update = function(p1)
			local v1 = p1.Instance
			local Shortcut = v1.Shortcut
			v1.TextLabel.Text = p1.arguments.Text
			if p1.arguments.KeyCode then
				if p1.arguments.ModifierKey then
					Shortcut.Text = p1.arguments.ModifierKey.Name .. " + " .. p1.arguments.KeyCode.Name
					return
				end
				Shortcut.Text = p1.arguments.KeyCode.Name
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("MenuToggle", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			checked = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastCheckedTick == p1._cycleTick
				end
			},
			unchecked = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastUncheckedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_MenuToggle = Instance.new("TextButton")
			Iris_MenuToggle.Name = "Iris_MenuToggle"
			Iris_MenuToggle.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuToggle.Size = UDim2.fromScale(1, 0)
			Iris_MenuToggle.BackgroundTransparency = 1
			Iris_MenuToggle.BorderSizePixel = 0
			Iris_MenuToggle.Text = ""
			Iris_MenuToggle.AutoButtonColor = false
			local v12 = p2.UIPadding(Iris_MenuToggle, p1._config.FramePadding)
			v12.PaddingTop = v12.PaddingTop - UDim.new(0, 1)
			p2.UIListLayout(Iris_MenuToggle, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInteractionHighlights("Background", Iris_MenuToggle, Iris_MenuToggle, {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderHoveredColor,
				ActiveTransparency = p1._config.HeaderHoveredTransparency
			})
			p2.applyButtonClick(Iris_MenuToggle, function()
				p12.state.isChecked:set(not p12.state.isChecked.value)
				EmptyMenuStack()
			end)
			p2.applyMouseEnter(Iris_MenuToggle, function()
				local parentWidget = p12.parentWidget
				if v1 and (v2 and v2 ~= parentWidget) then
					EmptyMenuStack((table.find(t, parentWidget)))
					v2 = parentWidget
					v1 = true
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_MenuToggle
			local Shortcut = Instance.new("TextLabel")
			Shortcut.Name = "Shortcut"
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.LayoutOrder = 1
			p2.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = p1._config.TextDisabledColor
			Shortcut.TextTransparency = p1._config.TextDisabledTransparency
			Shortcut.Parent = Iris_MenuToggle
			local v22 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
			local v3 = v22 - math.round(0.2 * v22) * 2
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.Size = UDim2.fromOffset(v3, v3)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.ImageColor3 = p1._config.TextColor
			Icon.ImageTransparency = p1._config.TextTransparency
			Icon.Image = p2.ICONS.CHECK_MARK
			Icon.LayoutOrder = 2
			Icon.Parent = Iris_MenuToggle
			return Iris_MenuToggle
		end,
		GenerateState = function(p12)
			if p12.state.isChecked == nil then
				p12.state.isChecked = p1._widgetState(p12, "isChecked", false)
			end
		end,
		Update = function(p1)
			local v1 = p1.Instance
			local Shortcut = v1.Shortcut
			v1.TextLabel.Text = p1.arguments.Text
			if p1.arguments.KeyCode then
				if p1.arguments.ModifierKey then
					Shortcut.Text = p1.arguments.ModifierKey.Name .. " + " .. p1.arguments.KeyCode.Name
					return
				end
				Shortcut.Text = p1.arguments.KeyCode.Name
			end
		end,
		UpdateState = function(p12)
			local Icon = p12.Instance.Icon
			if p12.state.isChecked.value then
				Icon.ImageTransparency = p1._config.TextTransparency
				p12.lastCheckedTick = p1._cycleTick + 1
			else
				Icon.ImageTransparency = 1
				p12.lastUncheckedTick = p1._cycleTick + 1
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end
