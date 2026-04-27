require(script.Parent.Parent.Types)
return function(irisConfig, irisUtils)
	local isMenuOpen = false
	local currentOpenedMenu = nil
	local menuStack = {}
	local function EmptyMenuStack(clearIndex)
		for i = #menuStack, clearIndex and clearIndex + 1 or 1, -1 do
			local menuItem = menuStack[i]
			menuItem.state.isOpened:set(false)
			menuItem.Instance.BackgroundColor3 = irisConfig._config.HeaderColor
			menuItem.Instance.BackgroundTransparency = 1
			table.remove(menuStack, i)
		end
		if #menuStack == 0 then
			isMenuOpen = false
			currentOpenedMenu = nil
		end
	end
	local function UpdateChildContainerTransform(menuWidget)
		local isType = menuWidget.parentWidget.type == "Menu"
		local instance = menuWidget.Instance
		local ChildContainer = menuWidget.ChildContainer
		ChildContainer.Size = UDim2.fromOffset(instance.AbsoluteSize.X, 0)
		if ChildContainer.Parent ~= nil then
			local menuPosition = instance.AbsolutePosition - irisUtils.GuiOffset
			local AbsoluteSize = instance.AbsoluteSize
			local AbsoluteSize_2 = ChildContainer.AbsoluteSize
			local PopupBorderSize = irisConfig._config.PopupBorderSize
			local AbsoluteSize_3 = ChildContainer.Parent.AbsoluteSize
			local X = menuPosition.X
			local zero = Vector2.zero
			if isType and menuPosition.X + AbsoluteSize_2.X > AbsoluteSize_3.X then
				zero = Vector2.xAxis
			elseif isType then
				X = menuPosition.X + AbsoluteSize.X
			end
			local offsetY
			if menuPosition.Y + AbsoluteSize_2.Y > AbsoluteSize_3.Y then
				zero = zero + Vector2.yAxis
				offsetY = menuPosition.Y - PopupBorderSize + (isType and AbsoluteSize.Y or 0)
			else
				offsetY = menuPosition.Y + PopupBorderSize + if isType then 0 else AbsoluteSize.Y
			end
			ChildContainer.Position = UDim2.fromOffset(X, offsetY)
			ChildContainer.AnchorPoint = zero
		end
	end
	irisUtils.registerEvent("InputBegan", function(inputData)
		if irisConfig._started and ((inputData.UserInputType == Enum.UserInputType.MouseButton1 or inputData.UserInputType == Enum.UserInputType.MouseButton2) and (isMenuOpen ~= false and currentOpenedMenu ~= nil)) then
			local mouseLocation = irisUtils.getMouseLocation()
			local isMouseInside = false
			for stackIndex, menuItem in menuStack do
				for elementIndex, element in { menuItem.ChildContainer, menuItem.Instance } do
					local elementPosition = element.AbsolutePosition - irisUtils.GuiOffset
					if irisUtils.isPosInsideRect(mouseLocation, elementPosition, elementPosition + element.AbsoluteSize) then
						isMouseInside = true
						break
					end
				end
				if isMouseInside then
					break
				end
			end
			if not isMouseInside then
				EmptyMenuStack()
			end
		end
	end)
	irisConfig.WidgetConstructor("MenuBar", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(menuWidget)
			local Iris_MenuBar = Instance.new("Frame")
			Iris_MenuBar.Name = "Iris_MenuBar"
			Iris_MenuBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuBar.Size = UDim2.fromScale(1, 0)
			Iris_MenuBar.BackgroundColor3 = irisConfig._config.MenubarBgColor
			Iris_MenuBar.BackgroundTransparency = irisConfig._config.MenubarBgTransparency
			Iris_MenuBar.BorderSizePixel = 0
			Iris_MenuBar.ClipsDescendants = true
			irisUtils.UIPadding(Iris_MenuBar, Vector2.new(irisConfig._config.WindowPadding.X, 1))
			irisUtils.UIListLayout(Iris_MenuBar, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center
			irisUtils.applyFrameStyle(Iris_MenuBar, true, true)
			return Iris_MenuBar
		end,
		Update = function(irisConfig) end,
		ChildAdded = function(irisConfig, irisUtils)
			return irisConfig.Instance
		end,
		Discard = function(irisConfig)
			irisConfig.Instance:Destroy()
		end
	})
	irisConfig.WidgetConstructor("Menu", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1
		},
		Events = {
			clicked = irisUtils.EVENTS.click(function(irisConfig)
				return irisConfig.Instance
			end),
			hovered = irisUtils.EVENTS.hover(function(irisConfig)
				return irisConfig.Instance
			end),
			opened = {
				Init = function(irisConfig) end,
				Get = function(menuWidget)
					return menuWidget.lastOpenedTick == irisConfig._cycleTick
				end
			},
			closed = {
				Init = function(irisConfig) end,
				Get = function(menuWidget)
					return menuWidget.lastClosedTick == irisConfig._cycleTick
				end
			}
		},
		Generate = function(menuWidget)
			menuWidget.ButtonColors = {
				Color = irisConfig._config.HeaderColor,
				Transparency = 1,
				HoveredColor = irisConfig._config.HeaderHoveredColor,
				HoveredTransparency = irisConfig._config.HeaderHoveredTransparency,
				ActiveColor = irisConfig._config.HeaderHoveredColor,
				ActiveTransparency = irisConfig._config.HeaderHoveredTransparency
			}
			local menuButtonFrame
			if menuWidget.parentWidget.type == "Menu" then
				local Menu = Instance.new("TextButton")
				Menu.Name = "Menu"
				Menu.AutomaticSize = Enum.AutomaticSize.Y
				Menu.Size = UDim2.fromScale(1, 0)
				Menu.BackgroundColor3 = irisConfig._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Text = ""
				Menu.AutoButtonColor = false
				local menuPadding = irisUtils.UIPadding(Menu, irisConfig._config.FramePadding)
				menuPadding.PaddingTop = menuPadding.PaddingTop - UDim.new(0, 1)
				irisUtils.UIListLayout(Menu, Enum.FillDirection.Horizontal, UDim.new(0, irisConfig._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				irisUtils.applyTextStyle(TextLabel)
				TextLabel.Parent = Menu
				local baseSize = irisConfig._config.TextSize + 2 * irisConfig._config.FramePadding.Y
				local iconSize = baseSize - math.round(0.2 * baseSize) * 2
				local Icon = Instance.new("ImageLabel")
				Icon.Name = "Icon"
				Icon.Size = UDim2.fromOffset(iconSize, iconSize)
				Icon.BackgroundTransparency = 1
				Icon.BorderSizePixel = 0
				Icon.ImageColor3 = irisConfig._config.TextColor
				Icon.ImageTransparency = irisConfig._config.TextTransparency
				Icon.Image = irisUtils.ICONS.RIGHT_POINTING_TRIANGLE
				Icon.LayoutOrder = 1
				Icon.Parent = Menu
				menuButtonFrame = Menu
			else
				local Menu = Instance.new("TextButton")
				Menu.Name = "Menu"
				Menu.AutomaticSize = Enum.AutomaticSize.XY
				Menu.Size = UDim2.fromScale(0, 0)
				Menu.BackgroundColor3 = irisConfig._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Text = ""
				Menu.AutoButtonColor = false
				Menu.ClipsDescendants = true
				irisUtils.applyTextStyle(Menu)
				irisUtils.UIPadding(Menu, Vector2.new(irisConfig._config.ItemSpacing.X, irisConfig._config.FramePadding.Y))
				menuButtonFrame = Menu
			end
			irisUtils.applyInteractionHighlights("Background", menuButtonFrame, menuButtonFrame, menuWidget.ButtonColors)
			irisUtils.applyButtonClick(menuButtonFrame, function()
				local shouldOpen = if #menuStack <= 1 then not menuWidget.state.isOpened.value else true
				menuWidget.state.isOpened:set(shouldOpen)
				isMenuOpen = shouldOpen
				currentOpenedMenu = shouldOpen and menuWidget or nil
				if #menuStack <= 1 then
					if shouldOpen then
						table.insert(menuStack, menuWidget)
						return
					end
					table.remove(menuStack)
				end
			end)
			irisUtils.applyMouseEnter(menuButtonFrame, function()
				if isMenuOpen and (currentOpenedMenu and currentOpenedMenu ~= menuWidget) then
					EmptyMenuStack((table.find(menuStack, menuWidget.parentWidget)))
					menuWidget.state.isOpened:set(true)
					currentOpenedMenu = menuWidget
					isMenuOpen = true
					table.insert(menuStack, menuWidget)
				end
			end)
			local MenuContainer = Instance.new("ScrollingFrame")
			MenuContainer.Name = "MenuContainer"
			MenuContainer.AutomaticSize = Enum.AutomaticSize.XY
			MenuContainer.Size = UDim2.fromOffset(0, 0)
			MenuContainer.BackgroundColor3 = irisConfig._config.PopupBgColor
			MenuContainer.BackgroundTransparency = irisConfig._config.PopupBgTransparency
			MenuContainer.BorderSizePixel = 0
			MenuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			MenuContainer.ScrollBarImageTransparency = irisConfig._config.ScrollbarGrabTransparency
			MenuContainer.ScrollBarImageColor3 = irisConfig._config.ScrollbarGrabColor
			MenuContainer.ScrollBarThickness = irisConfig._config.ScrollbarSize
			MenuContainer.CanvasSize = UDim2.fromScale(0, 0)
			MenuContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			MenuContainer.TopImage = irisUtils.ICONS.BLANK_SQUARE
			MenuContainer.MidImage = irisUtils.ICONS.BLANK_SQUARE
			MenuContainer.BottomImage = irisUtils.ICONS.BLANK_SQUARE
			MenuContainer.ZIndex = 6
			MenuContainer.LayoutOrder = 6
			MenuContainer.ClipsDescendants = true
			irisUtils.UIStroke(MenuContainer, irisConfig._config.WindowBorderSize, irisConfig._config.BorderColor, irisConfig._config.BorderTransparency)
			irisUtils.UIPadding(MenuContainer, Vector2.new(2, irisConfig._config.WindowPadding.Y - irisConfig._config.ItemSpacing.Y))
			irisUtils.UIListLayout(MenuContainer, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
			MenuContainer.Parent = irisConfig._rootInstance and irisConfig._rootInstance:FindFirstChild("PopupScreenGui")
			menuWidget.ChildContainer = MenuContainer
			return menuButtonFrame
		end,
		Update = function(irisConfig)
			local instance = irisConfig.Instance;
			(if irisConfig.parentWidget.type == "Menu" then instance.TextLabel else instance).Text = irisConfig.arguments.Text or "Menu"
		end,
		ChildAdded = function(irisConfig, irisUtils)
			UpdateChildContainerTransform(irisConfig)
			return irisConfig.ChildContainer
		end,
		ChildDiscarded = function(irisConfig, irisUtils)
			UpdateChildContainerTransform(irisConfig)
		end,
		GenerateState = function(menuWidget)
			if menuWidget.state.isOpened == nil then
				menuWidget.state.isOpened = irisConfig._widgetState(menuWidget, "isOpened", false)
			end
		end,
		UpdateState = function(menuWidget)
			local ChildContainer = menuWidget.ChildContainer
			if menuWidget.state.isOpened.value then
				menuWidget.lastOpenedTick = irisConfig._cycleTick + 1
				menuWidget.ButtonColors.Transparency = irisConfig._config.HeaderTransparency
				ChildContainer.Visible = true
				UpdateChildContainerTransform(menuWidget)
			else
				menuWidget.lastClosedTick = irisConfig._cycleTick + 1
				menuWidget.ButtonColors.Transparency = 1
				ChildContainer.Visible = false
			end
		end,
		Discard = function(irisConfig)
			if isMenuOpen then
				local parentWidget = irisConfig.parentWidget
				local stackIndex = table.find(menuStack, parentWidget)
				if stackIndex then
					EmptyMenuStack(stackIndex)
					if #menuStack ~= 0 then
						currentOpenedMenu = parentWidget
						isMenuOpen = true
					end
				end
			end
			irisConfig.Instance:Destroy()
			irisConfig.ChildContainer:Destroy()
			irisUtils.discardState(irisConfig)
		end
	})
	irisConfig.WidgetConstructor("MenuItem", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			clicked = irisUtils.EVENTS.click(function(irisConfig)
				return irisConfig.Instance
			end),
			hovered = irisUtils.EVENTS.hover(function(irisConfig)
				return irisConfig.Instance
			end)
		},
		Generate = function(menuWidget)
			local Iris_MenuItem = Instance.new("TextButton")
			Iris_MenuItem.Name = "Iris_MenuItem"
			Iris_MenuItem.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuItem.Size = UDim2.fromScale(1, 0)
			Iris_MenuItem.BackgroundTransparency = 1
			Iris_MenuItem.BorderSizePixel = 0
			Iris_MenuItem.Text = ""
			Iris_MenuItem.AutoButtonColor = false
			local menuItemPadding = irisUtils.UIPadding(Iris_MenuItem, irisConfig._config.FramePadding)
			menuItemPadding.PaddingTop = menuItemPadding.PaddingTop - UDim.new(0, 1)
			irisUtils.UIListLayout(Iris_MenuItem, Enum.FillDirection.Horizontal, UDim.new(0, irisConfig._config.ItemInnerSpacing.X))
			irisUtils.applyInteractionHighlights("Background", Iris_MenuItem, Iris_MenuItem, {
				Color = irisConfig._config.HeaderColor,
				Transparency = 1,
				HoveredColor = irisConfig._config.HeaderHoveredColor,
				HoveredTransparency = irisConfig._config.HeaderHoveredTransparency,
				ActiveColor = irisConfig._config.HeaderHoveredColor,
				ActiveTransparency = irisConfig._config.HeaderHoveredTransparency
			})
			irisUtils.applyButtonClick(Iris_MenuItem, function()
				EmptyMenuStack()
			end)
			irisUtils.applyMouseEnter(Iris_MenuItem, function()
				local parentWidget = menuWidget.parentWidget
				if isMenuOpen and (currentOpenedMenu and currentOpenedMenu ~= parentWidget) then
					EmptyMenuStack((table.find(menuStack, parentWidget)))
					currentOpenedMenu = parentWidget
					isMenuOpen = true
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			irisUtils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_MenuItem
			local Shortcut = Instance.new("TextLabel")
			Shortcut.Name = "Shortcut"
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.LayoutOrder = 1
			irisUtils.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = irisConfig._config.TextDisabledColor
			Shortcut.TextTransparency = irisConfig._config.TextDisabledTransparency
			Shortcut.Parent = Iris_MenuItem
			return Iris_MenuItem
		end,
		Update = function(irisConfig)
			local instance = irisConfig.Instance
			local Shortcut = instance.Shortcut
			instance.TextLabel.Text = irisConfig.arguments.Text
			if irisConfig.arguments.KeyCode then
				if irisConfig.arguments.ModifierKey then
					Shortcut.Text = irisConfig.arguments.ModifierKey.Name .. " + " .. irisConfig.arguments.KeyCode.Name
					return
				end
				Shortcut.Text = irisConfig.arguments.KeyCode.Name
			end
		end,
		Discard = function(irisConfig)
			irisConfig.Instance:Destroy()
		end
	})
	irisConfig.WidgetConstructor("MenuToggle", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			checked = {
				Init = function(irisConfig) end,
				Get = function(menuWidget)
					return menuWidget.lastCheckedTick == irisConfig._cycleTick
				end
			},
			unchecked = {
				Init = function(irisConfig) end,
				Get = function(menuWidget)
					return menuWidget.lastUncheckedTick == irisConfig._cycleTick
				end
			},
			hovered = irisUtils.EVENTS.hover(function(irisConfig)
				return irisConfig.Instance
			end)
		},
		Generate = function(menuWidget)
			local Iris_MenuToggle = Instance.new("TextButton")
			Iris_MenuToggle.Name = "Iris_MenuToggle"
			Iris_MenuToggle.AutomaticSize = Enum.AutomaticSize.Y
			Iris_MenuToggle.Size = UDim2.fromScale(1, 0)
			Iris_MenuToggle.BackgroundTransparency = 1
			Iris_MenuToggle.BorderSizePixel = 0
			Iris_MenuToggle.Text = ""
			Iris_MenuToggle.AutoButtonColor = false
			local togglePadding = irisUtils.UIPadding(Iris_MenuToggle, irisConfig._config.FramePadding)
			togglePadding.PaddingTop = togglePadding.PaddingTop - UDim.new(0, 1)
			irisUtils.UIListLayout(Iris_MenuToggle, Enum.FillDirection.Horizontal, UDim.new(0, irisConfig._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			irisUtils.applyInteractionHighlights("Background", Iris_MenuToggle, Iris_MenuToggle, {
				Color = irisConfig._config.HeaderColor,
				Transparency = 1,
				HoveredColor = irisConfig._config.HeaderHoveredColor,
				HoveredTransparency = irisConfig._config.HeaderHoveredTransparency,
				ActiveColor = irisConfig._config.HeaderHoveredColor,
				ActiveTransparency = irisConfig._config.HeaderHoveredTransparency
			})
			irisUtils.applyButtonClick(Iris_MenuToggle, function()
				menuWidget.state.isChecked:set(not menuWidget.state.isChecked.value)
				EmptyMenuStack()
			end)
			irisUtils.applyMouseEnter(Iris_MenuToggle, function()
				local parentWidget = menuWidget.parentWidget
				if isMenuOpen and (currentOpenedMenu and currentOpenedMenu ~= parentWidget) then
					EmptyMenuStack((table.find(menuStack, parentWidget)))
					currentOpenedMenu = parentWidget
					isMenuOpen = true
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			irisUtils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_MenuToggle
			local Shortcut = Instance.new("TextLabel")
			Shortcut.Name = "Shortcut"
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.LayoutOrder = 1
			irisUtils.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = irisConfig._config.TextDisabledColor
			Shortcut.TextTransparency = irisConfig._config.TextDisabledTransparency
			Shortcut.Parent = Iris_MenuToggle
			local baseToggleSize = irisConfig._config.TextSize + 2 * irisConfig._config.FramePadding.Y
			local toggleIconSize = baseToggleSize - math.round(0.2 * baseToggleSize) * 2
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.Size = UDim2.fromOffset(toggleIconSize, toggleIconSize)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.ImageColor3 = irisConfig._config.TextColor
			Icon.ImageTransparency = irisConfig._config.TextTransparency
			Icon.Image = irisUtils.ICONS.CHECK_MARK
			Icon.LayoutOrder = 2
			Icon.Parent = Iris_MenuToggle
			return Iris_MenuToggle
		end,
		GenerateState = function(menuWidget)
			if menuWidget.state.isChecked == nil then
				menuWidget.state.isChecked = irisConfig._widgetState(menuWidget, "isChecked", false)
			end
		end,
		Update = function(irisConfig)
			local instance = irisConfig.Instance
			local Shortcut = instance.Shortcut
			instance.TextLabel.Text = irisConfig.arguments.Text
			if irisConfig.arguments.KeyCode then
				if irisConfig.arguments.ModifierKey then
					Shortcut.Text = irisConfig.arguments.ModifierKey.Name .. " + " .. irisConfig.arguments.KeyCode.Name
					return
				end
				Shortcut.Text = irisConfig.arguments.KeyCode.Name
			end
		end,
		UpdateState = function(menuWidget)
			local Icon = menuWidget.Instance.Icon
			if menuWidget.state.isChecked.value then
				Icon.ImageTransparency = irisConfig._config.TextTransparency
				menuWidget.lastCheckedTick = irisConfig._cycleTick + 1
			else
				Icon.ImageTransparency = 1
				menuWidget.lastUncheckedTick = irisConfig._cycleTick + 1
			end
		end,
		Discard = function(irisConfig)
			irisConfig.Instance:Destroy()
			irisUtils.discardState(irisConfig)
		end
	})
end
