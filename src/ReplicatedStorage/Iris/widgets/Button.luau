-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local t = {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			Size = 2
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance
			end),
			rightClicked = p2.EVENTS.rightClick(function(p1)
				return p1.Instance
			end),
			doubleClicked = p2.EVENTS.doubleClick(function(p1)
				return p1.Instance
			end),
			ctrlClicked = p2.EVENTS.ctrlClick(function(p1)
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local TextButton = Instance.new("TextButton")
			TextButton.AutomaticSize = Enum.AutomaticSize.XY
			TextButton.Size = UDim2.fromOffset(0, 0)
			TextButton.BackgroundColor3 = p1._config.ButtonColor
			TextButton.BackgroundTransparency = p1._config.ButtonTransparency
			TextButton.AutoButtonColor = false
			p2.applyTextStyle(TextButton)
			TextButton.TextXAlignment = Enum.TextXAlignment.Center
			p2.applyFrameStyle(TextButton)
			p2.applyInteractionHighlights("Background", TextButton, TextButton, {
				Color = p1._config.ButtonColor,
				Transparency = p1._config.ButtonTransparency,
				HoveredColor = p1._config.ButtonHoveredColor,
				HoveredTransparency = p1._config.ButtonHoveredTransparency,
				ActiveColor = p1._config.ButtonActiveColor,
				ActiveTransparency = p1._config.ButtonActiveTransparency
			})
			return TextButton
		end,
		Update = function(p1)
			local v1 = p1.Instance
			v1.Text = p1.arguments.Text or "Button"
			v1.Size = p1.arguments.Size or UDim2.fromOffset(0, 0)
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
		end
	}
	p2.abstractButton = t
	p1.WidgetConstructor("Button", p2.extend(t, {
		Generate = function(p1)
			local Iris_Button = t.Generate(p1)
			Iris_Button.Name = "Iris_Button"
			return Iris_Button
		end
	}))
	p1.WidgetConstructor("SmallButton", p2.extend(t, {
		Generate = function(p1)
			local Iris_SmallButton = t.Generate(p1)
			Iris_SmallButton.Name = "Iris_SmallButton"
			local UIPadding = Iris_SmallButton.UIPadding
			UIPadding.PaddingLeft = UDim.new(0, 2)
			UIPadding.PaddingRight = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 0)
			UIPadding.PaddingBottom = UDim.new(0, 0)
			return Iris_SmallButton
		end
	}))
end
