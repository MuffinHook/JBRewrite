require(script.Parent.Parent.Types)
return function(iris, utils)
	local treeDefinition = {
		hasState = true,
		hasChildren = true,
		Events = {
			collapsed = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastCollapsedTick == iris._cycleTick
				end
			},
			uncollapsed = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastUncollapsedTick == iris._cycleTick
				end
			},
			hovered = utils.EVENTS.hover(function(widget)
				return widget.Instance
			end)
		},
		Discard = function(widget)
			widget.Instance:Destroy()
			utils.discardState(widget)
		end,
		ChildAdded = function(widget, utils)
			local ChildContainer = widget.ChildContainer
			ChildContainer.Visible = widget.state.isUncollapsed.value
			return ChildContainer
		end,
		UpdateState = function(widget)
			local value = widget.state.isUncollapsed.value
			local ChildContainer = widget.ChildContainer
			widget.Instance.Header.Button.Arrow.Image = value and utils.ICONS.DOWN_POINTING_TRIANGLE or utils.ICONS.RIGHT_POINTING_TRIANGLE
			if value then
				widget.lastUncollapsedTick = iris._cycleTick + 1
			else
				widget.lastCollapsedTick = iris._cycleTick + 1
			end
			ChildContainer.Visible = value
		end,
		GenerateState = function(widget)
			if widget.state.isUncollapsed == nil then
				widget.state.isUncollapsed = iris._widgetState(widget, "isUncollapsed", widget.arguments.DefaultOpen or false)
			end
		end
	}
	iris.WidgetConstructor("Tree", utils.extend(treeDefinition, {
		Args = {
			Text = 1,
			SpanAvailWidth = 2,
			NoIndent = 3,
			DefaultOpen = 4
		},
		Generate = function(widget)
			local Iris_Tree = Instance.new("Frame")
			Iris_Tree.Name = "Iris_Tree"
			Iris_Tree.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tree.Size = UDim2.new(iris._config.ItemWidth, UDim.new(0, 0))
			Iris_Tree.BackgroundTransparency = 1
			Iris_Tree.BorderSizePixel = 0
			utils.UIListLayout(Iris_Tree, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local TreeContainer = Instance.new("Frame")
			TreeContainer.Name = "TreeContainer"
			TreeContainer.AutomaticSize = Enum.AutomaticSize.Y
			TreeContainer.Size = UDim2.fromScale(1, 0)
			TreeContainer.BackgroundTransparency = 1
			TreeContainer.BorderSizePixel = 0
			TreeContainer.LayoutOrder = 1
			TreeContainer.Visible = false
			utils.UIListLayout(TreeContainer, Enum.FillDirection.Vertical, UDim.new(0, iris._config.ItemSpacing.Y))
			utils.UIPadding(TreeContainer, Vector2.zero).PaddingTop = UDim.new(0, iris._config.ItemSpacing.Y)
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
			utils.applyInteractionHighlights("Background", Button, Header, {
				Color = Color3.fromRGB(0, 0, 0),
				Transparency = 1,
				HoveredColor = iris._config.HeaderHoveredColor,
				HoveredTransparency = iris._config.HeaderHoveredTransparency,
				ActiveColor = iris._config.HeaderActiveColor,
				ActiveTransparency = iris._config.HeaderActiveTransparency
			})
			utils.UIPadding(Button, Vector2.zero).PaddingLeft = UDim.new(0, iris._config.FramePadding.X)
			utils.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			Button.Parent = Header
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.Size = UDim2.fromOffset(iris._config.TextSize, (math.floor(iris._config.TextSize * 0.7)))
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = iris._config.TextColor
			Arrow.ImageTransparency = iris._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.Parent = Button
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			utils.UIPadding(TextLabel, Vector2.zero).PaddingRight = UDim.new(0, 21)
			utils.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			utils.applyButtonClick(Button, function()
				widget.state.isUncollapsed:set(not widget.state.isUncollapsed.value)
			end)
			widget.ChildContainer = TreeContainer
			return Iris_Tree
		end,
		Update = function(widget)
			local Button = widget.Instance.Header.Button
			local UIPadding = widget.ChildContainer.UIPadding
			Button.TextLabel.Text = widget.arguments.Text or "Tree"
			if widget.arguments.SpanAvailWidth then
				Button.AutomaticSize = Enum.AutomaticSize.Y
				Button.Size = UDim2.fromScale(1, 0)
			else
				Button.AutomaticSize = Enum.AutomaticSize.XY
				Button.Size = UDim2.fromScale(0, 0)
			end
			if widget.arguments.NoIndent then
				UIPadding.PaddingLeft = UDim.new(0, 0)
			else
				UIPadding.PaddingLeft = UDim.new(0, iris._config.IndentSpacing)
			end
		end
	}))
	iris.WidgetConstructor("CollapsingHeader", utils.extend(treeDefinition, {
		Args = {
			Text = 1,
			DefaultOpen = 2
		},
		Generate = function(widget)
			local Iris_CollapsingHeader = Instance.new("Frame")
			Iris_CollapsingHeader.Name = "Iris_CollapsingHeader"
			Iris_CollapsingHeader.AutomaticSize = Enum.AutomaticSize.Y
			Iris_CollapsingHeader.Size = UDim2.new(iris._config.ItemWidth, UDim.new(0, 0))
			Iris_CollapsingHeader.BackgroundTransparency = 1
			Iris_CollapsingHeader.BorderSizePixel = 0
			utils.UIListLayout(Iris_CollapsingHeader, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local CollapsingHeaderContainer = Instance.new("Frame")
			CollapsingHeaderContainer.Name = "CollapsingHeaderContainer"
			CollapsingHeaderContainer.AutomaticSize = Enum.AutomaticSize.Y
			CollapsingHeaderContainer.Size = UDim2.fromScale(1, 0)
			CollapsingHeaderContainer.BackgroundTransparency = 1
			CollapsingHeaderContainer.BorderSizePixel = 0
			CollapsingHeaderContainer.LayoutOrder = 1
			CollapsingHeaderContainer.Visible = false
			utils.UIListLayout(CollapsingHeaderContainer, Enum.FillDirection.Vertical, UDim.new(0, iris._config.ItemSpacing.Y))
			utils.UIPadding(CollapsingHeaderContainer, Vector2.zero).PaddingTop = UDim.new(0, iris._config.ItemSpacing.Y)
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
			Button.BackgroundColor3 = iris._config.HeaderColor
			Button.BackgroundTransparency = iris._config.HeaderTransparency
			Button.BorderSizePixel = 0
			Button.Text = ""
			Button.AutoButtonColor = false
			Button.ClipsDescendants = true
			utils.UIPadding(Button, iris._config.FramePadding)
			utils.applyFrameStyle(Button, true)
			utils.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, 2 * iris._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			utils.applyInteractionHighlights("Background", Button, Button, {
				Color = iris._config.HeaderColor,
				Transparency = iris._config.HeaderTransparency,
				HoveredColor = iris._config.HeaderHoveredColor,
				HoveredTransparency = iris._config.HeaderHoveredTransparency,
				ActiveColor = iris._config.HeaderActiveColor,
				ActiveTransparency = iris._config.HeaderActiveTransparency
			})
			Button.Parent = Header
			local Arrow = Instance.new("ImageLabel")
			Arrow.Name = "Arrow"
			Arrow.AutomaticSize = Enum.AutomaticSize.Y
			Arrow.Size = UDim2.fromOffset(iris._config.TextSize, (math.ceil(iris._config.TextSize * 0.8)))
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = iris._config.TextColor
			Arrow.ImageTransparency = iris._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.Parent = Button
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			utils.UIPadding(TextLabel, Vector2.zero).PaddingRight = UDim.new(0, 21)
			utils.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			utils.applyButtonClick(Button, function()
				widget.state.isUncollapsed:set(not widget.state.isUncollapsed.value)
			end)
			widget.ChildContainer = CollapsingHeaderContainer
			return Iris_CollapsingHeader
		end,
		Update = function(iris)
			iris.Instance.Header.Button.TextLabel.Text = iris.arguments.Text or "Collapsing Header"
		end
	}))
end
