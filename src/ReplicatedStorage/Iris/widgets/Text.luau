require(script.Parent.Parent.Types)
return function(irisLib, utilities)
	irisLib.WidgetConstructor("Text", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			Wrapped = 2,
			Color = 3,
			RichText = 4
		},
		Events = {
			hovered = utilities.EVENTS.hover(function(widgetInstance)
				return widgetInstance.Instance
			end)
		},
		Generate = function(widgetInstance)
			local Iris_Text = Instance.new("TextLabel")
			Iris_Text.Name = "Iris_Text"
			Iris_Text.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Text.Size = UDim2.fromOffset(0, 0)
			Iris_Text.BackgroundTransparency = 1
			Iris_Text.BorderSizePixel = 0
			utilities.applyTextStyle(Iris_Text)
			utilities.UIPadding(Iris_Text, Vector2.new(0, 2))
			return Iris_Text
		end,
		Update = function(widgetProps)
			local instance = widgetProps.Instance
			if widgetProps.arguments.Text == nil then
				error("Text argument is required for Iris.Text().", 5)
			end
			if widgetProps.arguments.Wrapped == nil then
				instance.TextWrapped = irisLib._config.TextWrapped
			else
				instance.TextWrapped = widgetProps.arguments.Wrapped
			end
			if widgetProps.arguments.Color then
				instance.TextColor3 = widgetProps.arguments.Color
			else
				instance.TextColor3 = irisLib._config.TextColor
			end
			if widgetProps.arguments.RichText == nil then
				instance.RichText = irisLib._config.RichText
			else
				instance.RichText = widgetProps.arguments.RichText
			end
			instance.Text = widgetProps.arguments.Text
		end,
		Discard = function(widgetInstance)
			widgetInstance.Instance:Destroy()
		end
	})
	irisLib.WidgetConstructor("SeparatorText", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			hovered = utilities.EVENTS.hover(function(widgetInstance)
				return widgetInstance.Instance
			end)
		},
		Generate = function(widgetProps)
			local Iris_SeparatorText = Instance.new("Frame")
			Iris_SeparatorText.Name = "Iris_SeparatorText"
			Iris_SeparatorText.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SeparatorText.Size = UDim2.new(irisLib._config.ItemWidth, UDim.new())
			Iris_SeparatorText.BackgroundTransparency = 1
			Iris_SeparatorText.BorderSizePixel = 0
			Iris_SeparatorText.ClipsDescendants = true
			utilities.UIPadding(Iris_SeparatorText, Vector2.new(0, irisLib._config.SeparatorTextPadding.Y))
			utilities.UIListLayout(Iris_SeparatorText, Enum.FillDirection.Horizontal, UDim.new(0, irisLib._config.ItemSpacing.X))
			Iris_SeparatorText.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			utilities.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_SeparatorText
			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.AnchorPoint = Vector2.new(1, 0.5)
			Left.Size = UDim2.fromOffset(irisLib._config.SeparatorTextPadding.X - irisLib._config.ItemSpacing.X, irisLib._config.SeparatorTextBorderSize)
			Left.BackgroundColor3 = irisLib._config.SeparatorColor
			Left.BackgroundTransparency = irisLib._config.SeparatorTransparency
			Left.BorderSizePixel = 0
			Left.Parent = Iris_SeparatorText
			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.AnchorPoint = Vector2.new(1, 0.5)
			Right.Size = UDim2.new(1, 0, 0, irisLib._config.SeparatorTextBorderSize)
			Right.BackgroundColor3 = irisLib._config.SeparatorColor
			Right.BackgroundTransparency = irisLib._config.SeparatorTransparency
			Right.BorderSizePixel = 0
			Right.LayoutOrder = 2
			Right.Parent = Iris_SeparatorText
			return Iris_SeparatorText
		end,
		Update = function(widgetInstance)
			if widgetInstance.arguments.Text == nil then
				error("Text argument is required for Iris.SeparatorText().", 5)
			end
			widgetInstance.Instance.TextLabel.Text = widgetInstance.arguments.Text
		end,
		Discard = function(widgetInstance)
			widgetInstance.Instance:Destroy()
		end
	})
end
