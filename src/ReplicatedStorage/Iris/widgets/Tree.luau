require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	local t = {
		hasState = true,
		hasChildren = true,
		Events = {
			collapsed = {
				Init = function(p1) --[[ Line: 9 ]] end,
				Get = function(p12) --[[ Line: 10 | Upvalues: p1 (copy) ]]
					return p12.lastCollapsedTick == p1._cycleTick
				end
			},
			uncollapsed = {
				Init = function(p1) --[[ Line: 15 ]] end,
				Get = function(p12) --[[ Line: 16 | Upvalues: p1 (copy) ]]
					return p12.lastUncollapsedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 20 ]]
				return p1.Instance
			end)
		},
		Discard = function(p1) --[[ Name: Discard | Line: 24 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 28 ]]
			local ChildContainer = p1.ChildContainer
			ChildContainer.Visible = p1.state.isUncollapsed.value
			return ChildContainer
		end,
		UpdateState = function(p12) --[[ Name: UpdateState | Line: 35 | Upvalues: p2 (copy), p1 (copy) ]]
			local value = p12.state.isUncollapsed.value
			local ChildContainer = p12.ChildContainer
			p12.Instance.Header.Button.Arrow.Image = value and p2.ICONS.DOWN_POINTING_TRIANGLE or p2.ICONS.RIGHT_POINTING_TRIANGLE
			if value then
				p12.lastUncollapsedTick = p1._cycleTick + 1
			else
				p12.lastCollapsedTick = p1._cycleTick + 1
			end
			ChildContainer.Visible = value
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 52 | Upvalues: p1 (copy) ]]
			if p12.state.isUncollapsed == nil then
				p12.state.isUncollapsed = p1._widgetState(p12, "isUncollapsed", p12.arguments.DefaultOpen or false)
			end
		end
	}
	p1.WidgetConstructor("Tree", p2.extend(t, {
		Args = {
			Text = 1,
			SpanAvailWidth = 2,
			NoIndent = 3,
			DefaultOpen = 4
		},
		Generate = function(p12) --[[ Name: Generate | Line: 69 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Tree = Instance.new("Frame")
			Iris_Tree.Name = "Iris_Tree"
			Iris_Tree.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tree.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, 0))
			Iris_Tree.BackgroundTransparency = 1
			Iris_Tree.BorderSizePixel = 0
			p2.UIListLayout(Iris_Tree, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local TreeContainer = Instance.new("Frame")
			TreeContainer.Name = "TreeContainer"
			TreeContainer.AutomaticSize = Enum.AutomaticSize.Y
			TreeContainer.Size = UDim2.fromScale(1, 0)
			TreeContainer.BackgroundTransparency = 1
			TreeContainer.BorderSizePixel = 0
			TreeContainer.LayoutOrder = 1
			TreeContainer.Visible = false
			p2.UIListLayout(TreeContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(TreeContainer, Vector2.zero).PaddingTop = UDim.new(0, p1._config.ItemSpacing.Y)
			TreeContainer.Parent = Iris_Tree
			local Header = Instance.new("Frame")
			Header.Name = "Header"
			Header.AutomaticSize = Enum.AutomaticSize.Y
			Header.Size = UDim2.fromScale(1, 0)
			Header.BackgroundTransparency = 1
			Header.BorderSizePixel = 0
			Header.Parent = Iris_Tree
			local Button = Instance.new("TextButton")
			Button.Name = "Button"
			Button.BackgroundTransparency = 1
			Button.BorderSizePixel = 0
			Button.Text = ""
			Button.AutoButtonColor = false
			p2.applyInteractionHighlights("Background", Button, Header, {
				Color = Color3.fromRGB(0, 0, 0),
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderActiveColor,
				ActiveTransparency = p1._config.HeaderActiveTransparency
			})
			p2.UIPadding(Button, Vector2.zero).PaddingLeft = UDim.new(0, p1._config.FramePadding.X)
			p2.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			Button.Parent = Header
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.Size = UDim2.fromOffset(p1._config.TextSize, (math.floor(p1._config.TextSize * 0.7)))
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.Parent = Button
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.UIPadding(TextLabel, Vector2.zero).PaddingRight = UDim.new(0, 21)
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			p2.applyButtonClick(Button, function() --[[ Line: 146 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)
			p12.ChildContainer = TreeContainer
			return Iris_Tree
		end,
		Update = function(p12) --[[ Name: Update | Line: 153 | Upvalues: p1 (copy) ]]
			local Button = p12.Instance.Header.Button
			local UIPadding = p12.ChildContainer.UIPadding
			Button.TextLabel.Text = p12.arguments.Text or "Tree"
			if p12.arguments.SpanAvailWidth then
				Button.AutomaticSize = Enum.AutomaticSize.Y
				Button.Size = UDim2.fromScale(1, 0)
			else
				Button.AutomaticSize = Enum.AutomaticSize.XY
				Button.Size = UDim2.fromScale(0, 0)
			end
			if p12.arguments.NoIndent then
				UIPadding.PaddingLeft = UDim.new(0, 0)
			else
				UIPadding.PaddingLeft = UDim.new(0, p1._config.IndentSpacing)
			end
		end
	}))
	p1.WidgetConstructor("CollapsingHeader", p2.extend(t, {
		Args = {
			Text = 1,
			DefaultOpen = 2
		},
		Generate = function(p12) --[[ Name: Generate | Line: 187 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_CollapsingHeader = Instance.new("Frame")
			Iris_CollapsingHeader.Name = "Iris_CollapsingHeader"
			Iris_CollapsingHeader.AutomaticSize = Enum.AutomaticSize.Y
			Iris_CollapsingHeader.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, 0))
			Iris_CollapsingHeader.BackgroundTransparency = 1
			Iris_CollapsingHeader.BorderSizePixel = 0
			p2.UIListLayout(Iris_CollapsingHeader, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local CollapsingHeaderContainer = Instance.new("Frame")
			CollapsingHeaderContainer.Name = "CollapsingHeaderContainer"
			CollapsingHeaderContainer.AutomaticSize = Enum.AutomaticSize.Y
			CollapsingHeaderContainer.Size = UDim2.fromScale(1, 0)
			CollapsingHeaderContainer.BackgroundTransparency = 1
			CollapsingHeaderContainer.BorderSizePixel = 0
			CollapsingHeaderContainer.LayoutOrder = 1
			CollapsingHeaderContainer.Visible = false
			p2.UIListLayout(CollapsingHeaderContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(CollapsingHeaderContainer, Vector2.zero).PaddingTop = UDim.new(0, p1._config.ItemSpacing.Y)
			CollapsingHeaderContainer.Parent = Iris_CollapsingHeader
			local Header = Instance.new("Frame")
			Header.Name = "Header"
			Header.AutomaticSize = Enum.AutomaticSize.Y
			Header.Size = UDim2.fromScale(1, 0)
			Header.BackgroundTransparency = 1
			Header.BorderSizePixel = 0
			Header.Parent = Iris_CollapsingHeader
			local Button = Instance.new("TextButton")
			Button.Name = "Button"
			Button.AutomaticSize = Enum.AutomaticSize.Y
			Button.Size = UDim2.fromScale(1, 0)
			Button.BackgroundColor3 = p1._config.HeaderColor
			Button.BackgroundTransparency = p1._config.HeaderTransparency
			Button.BorderSizePixel = 0
			Button.Text = ""
			Button.AutoButtonColor = false
			Button.ClipsDescendants = true
			p2.UIPadding(Button, p1._config.FramePadding)
			p2.applyFrameStyle(Button, true)
			p2.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, 2 * p1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInteractionHighlights("Background", Button, Button, {
				Color = p1._config.HeaderColor,
				Transparency = p1._config.HeaderTransparency,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderActiveColor,
				ActiveTransparency = p1._config.HeaderActiveTransparency
			})
			Button.Parent = Header
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.AutomaticSize = Enum.AutomaticSize.Y
			Arrow.Size = UDim2.fromOffset(p1._config.TextSize, (math.ceil(p1._config.TextSize * 0.8)))
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.Parent = Button
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.UIPadding(TextLabel, Vector2.zero).PaddingRight = UDim.new(0, 21)
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			p2.applyButtonClick(Button, function() --[[ Line: 270 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)
			p12.ChildContainer = CollapsingHeaderContainer
			return Iris_CollapsingHeader
		end,
		Update = function(p1) --[[ Name: Update | Line: 277 ]]
			p1.Instance.Header.Button.TextLabel.Text = p1.arguments.Text or "Collapsing Header"
		end
	}))
end