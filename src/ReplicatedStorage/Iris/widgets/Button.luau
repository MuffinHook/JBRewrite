require(script.Parent.Parent.Types)
return function(Iris, utilities)
	local buttonConfig = {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			Size = 2
		},
		Events = {
			clicked = utilities.EVENTS.click(function(eventData)
				return eventData.Instance
			end),
			rightClicked = utilities.EVENTS.rightClick(function(eventData)
				return eventData.Instance
			end),
			doubleClicked = utilities.EVENTS.doubleClick(function(eventData)
				return eventData.Instance
			end),
			ctrlClicked = utilities.EVENTS.ctrlClick(function(eventData)
				return eventData.Instance
			end),
			hovered = utilities.EVENTS.hover(function(eventData)
				return eventData.Instance
			end)
		},
		Generate = function(context)
			local TextButton = Instance.new("TextButton")
			TextButton.AutomaticSize = Enum.AutomaticSize.XY
			TextButton.Size = UDim2.fromOffset(0, 0)
			TextButton.BackgroundColor3 = Iris._config.ButtonColor
			TextButton.BackgroundTransparency = Iris._config.ButtonTransparency
			TextButton.AutoButtonColor = false
			utilities.applyTextStyle(TextButton)
			TextButton.TextXAlignment = Enum.TextXAlignment.Center
			utilities.applyFrameStyle(TextButton)
			utilities.applyInteractionHighlights("Background", TextButton, TextButton, {
				Color = Iris._config.ButtonColor,
				Transparency = Iris._config.ButtonTransparency,
				HoveredColor = Iris._config.ButtonHoveredColor,
				HoveredTransparency = Iris._config.ButtonHoveredTransparency,
				ActiveColor = Iris._config.ButtonActiveColor,
				ActiveTransparency = Iris._config.ButtonActiveTransparency
			})
			return TextButton
		end,
		Update = function(state)
			local instance = state.Instance
			instance.Text = state.arguments.Text or "Button"
			instance.Size = state.arguments.Size or UDim2.fromOffset(0, 0)
		end,
		Discard = function(state)
			state.Instance:Destroy()
		end
	}
	utilities.abstractButton = buttonConfig
	Iris.WidgetConstructor("Button", utilities.extend(buttonConfig, {
		Generate = function(context)
			local Iris_Button = buttonConfig.Generate(context)
			Iris_Button.Name = "Iris_Button"
			return Iris_Button
		end
	}))
	Iris.WidgetConstructor("SmallButton", utilities.extend(buttonConfig, {
		Generate = function(context)
			local Iris_SmallButton = buttonConfig.Generate(context)
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
