require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Text", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			Wrapped = 2,
			Color = 3,
			RichText = 4
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 15 ]]
				return p1.Instance
			end)
		},
		Generate = function(p1) --[[ Name: Generate | Line: 19 | Upvalues: p2 (copy) ]]
			local Iris_Text = Instance.new("TextLabel")
			Iris_Text.Name = "Iris_Text"
			Iris_Text.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Text.Size = UDim2.fromOffset(0, 0)
			Iris_Text.BackgroundTransparency = 1
			Iris_Text.BorderSizePixel = 0
			p2.applyTextStyle(Iris_Text)
			p2.UIPadding(Iris_Text, Vector2.new(0, 2))
			return Iris_Text
		end,
		Update = function(p12) --[[ Name: Update | Line: 32 | Upvalues: p1 (copy) ]]
			local v1 = p12.Instance
			if p12.arguments.Text == nil then
				error("Text argument is required for Iris.Text().", 5)
			end
			if p12.arguments.Wrapped == nil then
				v1.TextWrapped = p1._config.TextWrapped
			else
				v1.TextWrapped = p12.arguments.Wrapped
			end
			if p12.arguments.Color then
				v1.TextColor3 = p12.arguments.Color
			else
				v1.TextColor3 = p1._config.TextColor
			end
			if p12.arguments.RichText == nil then
				v1.RichText = p1._config.RichText
			else
				v1.RichText = p12.arguments.RichText
			end
			v1.Text = p12.arguments.Text
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 55 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("SeparatorText", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 68 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Name: Generate | Line: 72 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_SeparatorText = Instance.new("Frame")
			Iris_SeparatorText.Name = "Iris_SeparatorText"
			Iris_SeparatorText.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SeparatorText.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_SeparatorText.BackgroundTransparency = 1
			Iris_SeparatorText.BorderSizePixel = 0
			Iris_SeparatorText.ClipsDescendants = true
			p2.UIPadding(Iris_SeparatorText, Vector2.new(0, p1._config.SeparatorTextPadding.Y))
			p2.UIListLayout(Iris_SeparatorText, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemSpacing.X))
			Iris_SeparatorText.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_SeparatorText
			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.AnchorPoint = Vector2.new(1, 0.5)
			Left.Size = UDim2.fromOffset(p1._config.SeparatorTextPadding.X - p1._config.ItemSpacing.X, p1._config.SeparatorTextBorderSize)
			Left.BackgroundColor3 = p1._config.SeparatorColor
			Left.BackgroundTransparency = p1._config.SeparatorTransparency
			Left.BorderSizePixel = 0
			Left.Parent = Iris_SeparatorText
			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.AnchorPoint = Vector2.new(1, 0.5)
			Right.Size = UDim2.new(1, 0, 0, p1._config.SeparatorTextBorderSize)
			Right.BackgroundColor3 = p1._config.SeparatorColor
			Right.BackgroundTransparency = p1._config.SeparatorTransparency
			Right.BorderSizePixel = 0
			Right.LayoutOrder = 2
			Right.Parent = Iris_SeparatorText
			return Iris_SeparatorText
		end,
		Update = function(p1) --[[ Name: Update | Line: 120 ]]
			if p1.arguments.Text == nil then
				error("Text argument is required for Iris.SeparatorText().", 5)
			end
			p1.Instance.TextLabel.Text = p1.arguments.Text
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 128 ]]
			p1.Instance:Destroy()
		end
	})
end