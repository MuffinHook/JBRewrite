require(script.Parent.Parent.Types)
return function(Iris, IrisUtils)
	local function openTab(tabBar, tabIndex)
		if not (tabBar.state.index.value > 0) then
			tabBar.state.index:set(tabIndex)
		end
	end
	local function closeTab(tabBar, tabIndex)
		if tabBar.state.index.value == tabIndex then
			for i = tabIndex - 1, 1, -1 do
				if tabBar.Tabs[i].state.isOpened.value == true then
					tabBar.state.index:set(i)
					return
				end
			end
			for j = tabIndex, #tabBar.Tabs do
				if tabBar.Tabs[j].state.isOpened.value == true then
					tabBar.state.index:set(j)
					return
				end
			end
			tabBar.state.index:set(0)
		end
	end
	Iris.WidgetConstructor("TabBar", {
		hasState = true,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(tabBarWidget)
			local Iris_TabBar = Instance.new("Frame")
			Iris_TabBar.Name = "Iris_TabBar"
			Iris_TabBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_TabBar.Size = UDim2.fromScale(1, 0)
			Iris_TabBar.BackgroundTransparency = 1
			Iris_TabBar.BorderSizePixel = 0
			IrisUtils.UIListLayout(Iris_TabBar, Enum.FillDirection.Vertical, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Bottom
			local Bar = Instance.new("Frame")
			Bar.Name = "Bar"
			Bar.AutomaticSize = Enum.AutomaticSize.Y
			Bar.Size = UDim2.fromScale(1, 0)
			Bar.BackgroundTransparency = 1
			Bar.BorderSizePixel = 0
			IrisUtils.UIListLayout(Bar, Enum.FillDirection.Horizontal, UDim.new(0, Iris._config.ItemInnerSpacing.X))
			Bar.Parent = Iris_TabBar
			local Underline = Instance.new("Frame")
			Underline.Name = "Underline"
			Underline.Size = UDim2.new(1, 0, 0, 1)
			Underline.BackgroundColor3 = Iris._config.TabActiveColor
			Underline.BackgroundTransparency = Iris._config.TabActiveTransparency
			Underline.BorderSizePixel = 0
			Underline.LayoutOrder = 1
			Underline.Parent = Iris_TabBar
			local TabContainer = Instance.new("Frame")
			TabContainer.Name = "TabContainer"
			TabContainer.AutomaticSize = Enum.AutomaticSize.Y
			TabContainer.Size = UDim2.fromScale(1, 0)
			TabContainer.BackgroundTransparency = 1
			TabContainer.BorderSizePixel = 0
			TabContainer.LayoutOrder = 2
			TabContainer.ClipsDescendants = true
			TabContainer.Parent = Iris_TabBar
			tabBarWidget.ChildContainer = TabContainer
			tabBarWidget.Tabs = {}
			return Iris_TabBar
		end,
		Update = function(p1) end,
		ChildAdded = function(tabBar, newTab)
			assert(newTab.type == "Tab", "Only Iris.Tab can be parented to Iris.TabBar.")
			newTab.ChildContainer.Parent = tabBar.ChildContainer
			newTab.Index = #tabBar.Tabs + 1
			tabBar.state.index.ConnectedWidgets[newTab.ID] = newTab
			table.insert(tabBar.Tabs, newTab)
			return tabBar.Instance.Bar
		end,
		ChildDiscarded = function(tabBar, removedTab)
			local tabPosition = removedTab.Index
			table.remove(tabBar.Tabs, tabPosition)
			for i = tabPosition, #tabBar.Tabs do
				tabBar.Tabs[i].Index = i
			end
			closeTab(tabBar, tabPosition)
		end,
		GenerateState = function(tabBarWidget)
			if tabBarWidget.state.index == nil then
				tabBarWidget.state.index = Iris._widgetState(tabBarWidget, "index", 1)
			end
		end,
		UpdateState = function(p1) end,
		Discard = function(tabBarWidget)
			tabBarWidget.Instance:Destroy()
		end
	})
	Iris.WidgetConstructor("Tab", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1,
			Hideable = 2
		},
		Events = {
			clicked = IrisUtils.EVENTS.click(function(tabWidget)
				return tabWidget.Instance
			end),
			hovered = IrisUtils.EVENTS.hover(function(tabWidget)
				return tabWidget.Instance
			end),
			selected = {
				Init = function(p1) end,
				Get = function(tabWidget)
					return tabWidget.lastSelectedTick == Iris._cycleTick
				end
			},
			unselected = {
				Init = function(p1) end,
				Get = function(tabWidget)
					return tabWidget.lastUnselectedTick == Iris._cycleTick
				end
			},
			active = {
				Init = function(p1) end,
				Get = function(tabWidget)
					return tabWidget.state.index.value == tabWidget.Index
				end
			},
			opened = {
				Init = function(p1) end,
				Get = function(tabWidget)
					return tabWidget.lastOpenedTick == Iris._cycleTick
				end
			},
			closed = {
				Init = function(p1) end,
				Get = function(tabWidget)
					return tabWidget.lastClosedTick == Iris._cycleTick
				end
			}
		},
		Generate = function(tabWidget)
			local Iris_Tab = Instance.new("TextButton")
			Iris_Tab.Name = "Iris_Tab"
			Iris_Tab.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tab.BackgroundColor3 = Iris._config.TabColor
			Iris_Tab.BackgroundTransparency = Iris._config.TabTransparency
			Iris_Tab.BorderSizePixel = 0
			Iris_Tab.Text = ""
			Iris_Tab.AutoButtonColor = false
			tabWidget.ButtonColors = {
				Color = Iris._config.TabColor,
				Transparency = Iris._config.TabTransparency,
				HoveredColor = Iris._config.TabHoveredColor,
				HoveredTransparency = Iris._config.TabHoveredTransparency,
				ActiveColor = Iris._config.TabActiveColor,
				ActiveTransparency = Iris._config.TabActiveTransparency
			}
			IrisUtils.UIPadding(Iris_Tab, Vector2.new(Iris._config.FramePadding.X, 0))
			IrisUtils.applyFrameStyle(Iris_Tab, true, true)
			IrisUtils.UIListLayout(Iris_Tab, Enum.FillDirection.Horizontal, UDim.new(0, Iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			IrisUtils.applyInteractionHighlights("Background", Iris_Tab, Iris_Tab, tabWidget.ButtonColors)
			IrisUtils.applyButtonClick(Iris_Tab, function()
				tabWidget.state.index:set(tabWidget.Index)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			IrisUtils.applyTextStyle(TextLabel)
			IrisUtils.UIPadding(TextLabel, Vector2.new(0, Iris._config.FramePadding.Y))
			TextLabel.Parent = Iris_Tab
			local buttonSize = Iris._config.TextSize + (Iris._config.FramePadding.Y - 1) * 2
			local CloseButton = Instance.new("TextButton")
			CloseButton.Name = "CloseButton"
			CloseButton.Size = UDim2.fromOffset(buttonSize, buttonSize)
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.AutoButtonColor = false
			CloseButton.LayoutOrder = 1
			IrisUtils.UICorner(CloseButton)
			IrisUtils.applyButtonClick(CloseButton, function()
				tabWidget.state.isOpened:set(false)
				closeTab(tabWidget.parentWidget, tabWidget.Index)
			end)
			IrisUtils.applyInteractionHighlights("Background", CloseButton, CloseButton, {
				Color = Iris._config.TabColor,
				Transparency = 1,
				HoveredColor = Iris._config.ButtonHoveredColor,
				HoveredTransparency = Iris._config.ButtonHoveredTransparency,
				ActiveColor = Iris._config.ButtonActiveColor,
				ActiveTransparency = Iris._config.ButtonActiveTransparency
			})
			CloseButton.Parent = Iris_Tab
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.Size = UDim2.fromOffset(math.floor(0.7 * buttonSize), (math.floor(0.7 * buttonSize)))
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Image = IrisUtils.ICONS.MULTIPLICATION_SIGN
			Icon.ImageTransparency = 1
			IrisUtils.applyInteractionHighlights("Image", Iris_Tab, Icon, {
				Color = Iris._config.TextColor,
				Transparency = 1,
				HoveredColor = Iris._config.TextColor,
				HoveredTransparency = Iris._config.TextTransparency,
				ActiveColor = Iris._config.TextColor,
				ActiveTransparency = Iris._config.TextTransparency
			})
			Icon.Parent = CloseButton
			local TabContainer = Instance.new("Frame")
			TabContainer.Name = "TabContainer"
			TabContainer.AutomaticSize = Enum.AutomaticSize.Y
			TabContainer.Size = UDim2.fromScale(1, 0)
			TabContainer.BackgroundTransparency = 1
			TabContainer.BorderSizePixel = 0
			TabContainer.ClipsDescendants = true
			IrisUtils.UIListLayout(TabContainer, Enum.FillDirection.Vertical, UDim.new(0, Iris._config.ItemSpacing.Y))
			IrisUtils.UIPadding(TabContainer, Vector2.new(0, Iris._config.ItemSpacing.Y)).PaddingBottom = UDim.new()
			tabWidget.ChildContainer = TabContainer
			return Iris_Tab
		end,
		Update = function(tabWidget)
			local tabInstance = tabWidget.Instance
			tabInstance.TextLabel.Text = tabWidget.arguments.Text
			tabInstance.CloseButton.Visible = tabWidget.arguments.Hideable == true
		end,
		ChildAdded = function(tabWidget, p2)
			return tabWidget.ChildContainer
		end,
		GenerateState = function(tabWidget)
			tabWidget.state.index = tabWidget.parentWidget.state.index
			tabWidget.state.index.ConnectedWidgets[tabWidget.ID] = tabWidget
			if tabWidget.state.isOpened == nil then
				tabWidget.state.isOpened = Iris._widgetState(tabWidget, "isOpened", true)
			end
		end,
		UpdateState = function(tabWidget)
			local tabInstance = tabWidget.Instance
			local tabChildContainer = tabWidget.ChildContainer
			if tabWidget.state.isOpened.lastChangeTick == Iris._cycleTick then
				if tabWidget.state.isOpened.value == true then
					tabWidget.lastOpenedTick = Iris._cycleTick + 1
					local parentWidget = tabWidget.parentWidget
					local tabPosition = tabWidget.Index
					if not (parentWidget.state.index.value > 0) then
						parentWidget.state.index:set(tabPosition)
					end
					tabInstance.Visible = true
				else
					tabWidget.lastClosedTick = Iris._cycleTick + 1
					closeTab(tabWidget.parentWidget, tabWidget.Index)
					tabInstance.Visible = false
				end
			end
			if tabWidget.state.index.lastChangeTick == Iris._cycleTick then
				if tabWidget.state.index.value == tabWidget.Index then
					tabWidget.ButtonColors.Color = Iris._config.TabActiveColor
					tabWidget.ButtonColors.Transparency = Iris._config.TabActiveTransparency
					tabInstance.BackgroundColor3 = Iris._config.TabActiveColor
					tabInstance.BackgroundTransparency = Iris._config.TabActiveTransparency
					tabChildContainer.Visible = true
					tabWidget.lastSelectedTick = Iris._cycleTick + 1
					return
				end
				tabWidget.ButtonColors.Color = Iris._config.TabColor
				tabWidget.ButtonColors.Transparency = Iris._config.TabTransparency
				tabInstance.BackgroundColor3 = Iris._config.TabColor
				tabInstance.BackgroundTransparency = Iris._config.TabTransparency
				tabChildContainer.Visible = false
				tabWidget.lastUnselectedTick = Iris._cycleTick + 1
			end
		end,
		Discard = function(tabWidget)
			if tabWidget.state.isOpened.value == true then
				closeTab(tabWidget.parentWidget, tabWidget.Index)
			end
			tabWidget.Instance:Destroy()
			tabWidget.ChildContainer:Destroy()
			IrisUtils.discardState(tabWidget)
		end
	})
end
