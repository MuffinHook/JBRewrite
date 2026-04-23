require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	local function openTab(p1, p2) --[[ Line: 4 ]]
		if not (p1.state.index.value > 0) then
			p1.state.index:set(p2)
		end
	end
	local function closeTab(p1, p2) --[[ Line: 12 ]]
		if p1.state.index.value == p2 then
			for i = p2 - 1, 1, -1 do
				if p1.Tabs[i].state.isOpened.value == true then
					p1.state.index:set(i)
					return
				end
			end
			for j = p2, #p1.Tabs do
				if p1.Tabs[j].state.isOpened.value == true then
					p1.state.index:set(j)
					return
				end
			end
			p1.state.index:set(0)
		end
	end
	p1.WidgetConstructor("TabBar", {
		hasState = true,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 43 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_TabBar = Instance.new("Frame")
			Iris_TabBar.Name = "Iris_TabBar"
			Iris_TabBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_TabBar.Size = UDim2.fromScale(1, 0)
			Iris_TabBar.BackgroundTransparency = 1
			Iris_TabBar.BorderSizePixel = 0
			p2.UIListLayout(Iris_TabBar, Enum.FillDirection.Vertical, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Bottom
			local Bar = Instance.new("Frame")
			Bar.Name = "Bar"
			Bar.AutomaticSize = Enum.AutomaticSize.Y
			Bar.Size = UDim2.fromScale(1, 0)
			Bar.BackgroundTransparency = 1
			Bar.BorderSizePixel = 0
			p2.UIListLayout(Bar, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))
			Bar.Parent = Iris_TabBar
			local Underline = Instance.new("Frame")
			Underline.Name = "Underline"
			Underline.Size = UDim2.new(1, 0, 0, 1)
			Underline.BackgroundColor3 = p1._config.TabActiveColor
			Underline.BackgroundTransparency = p1._config.TabActiveTransparency
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
			p12.ChildContainer = TabContainer
			p12.Tabs = {}
			return Iris_TabBar
		end,
		Update = function(p1) --[[ Name: Update | Line: 90 ]] end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 91 ]]
			assert(p2.type == "Tab", "Only Iris.Tab can be parented to Iris.TabBar.")
			p2.ChildContainer.Parent = p1.ChildContainer
			p2.Index = #p1.Tabs + 1
			p1.state.index.ConnectedWidgets[p2.ID] = p2
			table.insert(p1.Tabs, p2)
			return p1.Instance.Bar
		end,
		ChildDiscarded = function(p1, p2) --[[ Name: ChildDiscarded | Line: 101 | Upvalues: closeTab (copy) ]]
			local Index = p2.Index
			table.remove(p1.Tabs, Index)
			for i = Index, #p1.Tabs do
				p1.Tabs[i].Index = i
			end
			closeTab(p1, Index)
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 111 | Upvalues: p1 (copy) ]]
			if p12.state.index == nil then
				p12.state.index = p1._widgetState(p12, "index", 1)
			end
		end,
		UpdateState = function(p1) --[[ Name: UpdateState | Line: 116 ]] end,
		Discard = function(p1) --[[ Name: Discard | Line: 118 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("Tab", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1,
			Hideable = 2
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 132 ]]
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 135 ]]
				return p1.Instance
			end),
			selected = {
				Init = function(p1) --[[ Line: 139 ]] end,
				Get = function(p12) --[[ Line: 140 | Upvalues: p1 (copy) ]]
					return p12.lastSelectedTick == p1._cycleTick
				end
			},
			unselected = {
				Init = function(p1) --[[ Line: 145 ]] end,
				Get = function(p12) --[[ Line: 146 | Upvalues: p1 (copy) ]]
					return p12.lastUnselectedTick == p1._cycleTick
				end
			},
			active = {
				Init = function(p1) --[[ Line: 151 ]] end,
				Get = function(p1) --[[ Line: 152 ]]
					return p1.state.index.value == p1.Index
				end
			},
			opened = {
				Init = function(p1) --[[ Line: 157 ]] end,
				Get = function(p12) --[[ Line: 158 | Upvalues: p1 (copy) ]]
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			closed = {
				Init = function(p1) --[[ Line: 163 ]] end,
				Get = function(p12) --[[ Line: 164 | Upvalues: p1 (copy) ]]
					return p12.lastClosedTick == p1._cycleTick
				end
			}
		},
		Generate = function(p12) --[[ Name: Generate | Line: 169 | Upvalues: p1 (copy), p2 (copy), closeTab (copy) ]]
			local Iris_Tab = Instance.new("TextButton")
			Iris_Tab.Name = "Iris_Tab"
			Iris_Tab.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tab.BackgroundColor3 = p1._config.TabColor
			Iris_Tab.BackgroundTransparency = p1._config.TabTransparency
			Iris_Tab.BorderSizePixel = 0
			Iris_Tab.Text = ""
			Iris_Tab.AutoButtonColor = false
			p12.ButtonColors = {
				Color = p1._config.TabColor,
				Transparency = p1._config.TabTransparency,
				HoveredColor = p1._config.TabHoveredColor,
				HoveredTransparency = p1._config.TabHoveredTransparency,
				ActiveColor = p1._config.TabActiveColor,
				ActiveTransparency = p1._config.TabActiveTransparency
			}
			p2.UIPadding(Iris_Tab, Vector2.new(p1._config.FramePadding.X, 0))
			p2.applyFrameStyle(Iris_Tab, true, true)
			p2.UIListLayout(Iris_Tab, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInteractionHighlights("Background", Iris_Tab, Iris_Tab, p12.ButtonColors)
			p2.applyButtonClick(Iris_Tab, function() --[[ Line: 192 | Upvalues: p12 (copy) ]]
				p12.state.index:set(p12.Index)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.applyTextStyle(TextLabel)
			p2.UIPadding(TextLabel, Vector2.new(0, p1._config.FramePadding.Y))
			TextLabel.Parent = Iris_Tab
			local v1 = p1._config.TextSize + (p1._config.FramePadding.Y - 1) * 2
			local CloseButton = Instance.new("TextButton")
			CloseButton.Name = "CloseButton"
			CloseButton.Size = UDim2.fromOffset(v1, v1)
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.AutoButtonColor = false
			CloseButton.LayoutOrder = 1
			p2.UICorner(CloseButton)
			p2.applyButtonClick(CloseButton, function() --[[ Line: 219 | Upvalues: p12 (copy), closeTab (ref) ]]
				p12.state.isOpened:set(false)
				closeTab(p12.parentWidget, p12.Index)
			end)
			p2.applyInteractionHighlights("Background", CloseButton, CloseButton, {
				Color = p1._config.TabColor,
				Transparency = 1,
				HoveredColor = p1._config.ButtonHoveredColor,
				HoveredTransparency = p1._config.ButtonHoveredTransparency,
				ActiveColor = p1._config.ButtonActiveColor,
				ActiveTransparency = p1._config.ButtonActiveTransparency
			})
			CloseButton.Parent = Iris_Tab
			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.Size = UDim2.fromOffset(math.floor(0.7 * v1), (math.floor(0.7 * v1)))
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Image = p2.ICONS.MULTIPLICATION_SIGN
			Icon.ImageTransparency = 1
			p2.applyInteractionHighlights("Image", Iris_Tab, Icon, {
				Color = p1._config.TextColor,
				Transparency = 1,
				HoveredColor = p1._config.TextColor,
				HoveredTransparency = p1._config.TextTransparency,
				ActiveColor = p1._config.TextColor,
				ActiveTransparency = p1._config.TextTransparency
			})
			Icon.Parent = CloseButton
			local TabContainer = Instance.new("Frame")
			TabContainer.Name = "TabContainer"
			TabContainer.AutomaticSize = Enum.AutomaticSize.Y
			TabContainer.Size = UDim2.fromScale(1, 0)
			TabContainer.BackgroundTransparency = 1
			TabContainer.BorderSizePixel = 0
			TabContainer.ClipsDescendants = true
			p2.UIListLayout(TabContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(TabContainer, Vector2.new(0, p1._config.ItemSpacing.Y)).PaddingBottom = UDim.new()
			p12.ChildContainer = TabContainer
			return Iris_Tab
		end,
		Update = function(p1) --[[ Name: Update | Line: 270 ]]
			local v1 = p1.Instance
			v1.TextLabel.Text = p1.arguments.Text
			v1.CloseButton.Visible = p1.arguments.Hideable == true
		end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 278 ]]
			return p1.ChildContainer
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 281 | Upvalues: p1 (copy) ]]
			p12.state.index = p12.parentWidget.state.index
			p12.state.index.ConnectedWidgets[p12.ID] = p12
			if p12.state.isOpened == nil then
				p12.state.isOpened = p1._widgetState(p12, "isOpened", true)
			end
		end,
		UpdateState = function(p12) --[[ Name: UpdateState | Line: 289 | Upvalues: p1 (copy), closeTab (copy) ]]
			local v1 = p12.Instance
			local ChildContainer = p12.ChildContainer
			if p12.state.isOpened.lastChangeTick == p1._cycleTick then
				if p12.state.isOpened.value == true then
					p12.lastOpenedTick = p1._cycleTick + 1
					local parentWidget = p12.parentWidget
					local Index = p12.Index
					if not (parentWidget.state.index.value > 0) then
						parentWidget.state.index:set(Index)
					end
					v1.Visible = true
				else
					p12.lastClosedTick = p1._cycleTick + 1
					closeTab(p12.parentWidget, p12.Index)
					v1.Visible = false
				end
			end
			if p12.state.index.lastChangeTick == p1._cycleTick then
				if p12.state.index.value == p12.Index then
					p12.ButtonColors.Color = p1._config.TabActiveColor
					p12.ButtonColors.Transparency = p1._config.TabActiveTransparency
					v1.BackgroundColor3 = p1._config.TabActiveColor
					v1.BackgroundTransparency = p1._config.TabActiveTransparency
					ChildContainer.Visible = true
					p12.lastSelectedTick = p1._cycleTick + 1
					return
				end
				p12.ButtonColors.Color = p1._config.TabColor
				p12.ButtonColors.Transparency = p1._config.TabTransparency
				v1.BackgroundColor3 = p1._config.TabColor
				v1.BackgroundTransparency = p1._config.TabTransparency
				ChildContainer.Visible = false
				p12.lastUnselectedTick = p1._cycleTick + 1
			end
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 323 | Upvalues: closeTab (copy), p2 (copy) ]]
			if p1.state.isOpened.value == true then
				closeTab(p1.parentWidget, p1.Index)
			end
			p1.Instance:Destroy()
			p1.ChildContainer:Destroy()
			p2.discardState(p1)
		end
	})
end