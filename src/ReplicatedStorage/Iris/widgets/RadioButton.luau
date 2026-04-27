require(script.Parent.Parent.Types)
return function(irisContext, utils)
	irisContext.WidgetConstructor("RadioButton", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2
		},
		Events = {
			selected = {
				Init = function(widgetData) end,
				Get = function(widgetData)
					return widgetData.lastSelectedTick == irisContext._cycleTick
				end
			},
			unselected = {
				Init = function(widgetData) end,
				Get = function(widgetData)
					return widgetData.lastUnselectedTick == irisContext._cycleTick
				end
			},
			active = {
				Init = function(widgetData) end,
				Get = function(widgetData)
					return widgetData.state.index.value == widgetData.arguments.Index
				end
			},
			hovered = utils.EVENTS.hover(function(widgetData)
				return widgetData.Instance
			end)
		},
		Generate = function(widgetData)
			local Iris_RadioButton = Instance.new("TextButton")
			Iris_RadioButton.Name = "Iris_RadioButton"
			Iris_RadioButton.AutomaticSize = Enum.AutomaticSize.XY
			Iris_RadioButton.Size = UDim2.fromOffset(0, 0)
			Iris_RadioButton.BackgroundTransparency = 1
			Iris_RadioButton.BorderSizePixel = 0
			Iris_RadioButton.Text = ""
			Iris_RadioButton.AutoButtonColor = false
			utils.UIListLayout(Iris_RadioButton, Enum.FillDirection.Horizontal, UDim.new(0, irisContext._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local delta = irisContext._config.TextSize + 2 * (irisContext._config.FramePadding.Y - 1)
			local Button = Instance.new("Frame")
			Button.Name = "Button"
			Button.Size = UDim2.fromOffset(delta, delta)
			Button.BackgroundColor3 = irisContext._config.FrameBgColor
			Button.BackgroundTransparency = irisContext._config.FrameBgTransparency
			Button.Parent = Iris_RadioButton
			utils.UICorner(Button)
			utils.UIPadding(Button, Vector2.new(math.max(1, (math.floor(delta / 5))), (math.max(1, (math.floor(delta / 5))))))
			local Circle = Instance.new("Frame")
			Circle.Name = "Circle"
			Circle.Size = UDim2.fromScale(1, 1)
			Circle.BackgroundColor3 = irisContext._config.CheckMarkColor
			Circle.BackgroundTransparency = irisContext._config.CheckMarkTransparency
			utils.UICorner(Circle)
			Circle.Parent = Button
			utils.applyInteractionHighlights("Background", Iris_RadioButton, Button, {
				Color = irisContext._config.FrameBgColor,
				Transparency = irisContext._config.FrameBgTransparency,
				HoveredColor = irisContext._config.FrameBgHoveredColor,
				HoveredTransparency = irisContext._config.FrameBgHoveredTransparency,
				ActiveColor = irisContext._config.FrameBgActiveColor,
				ActiveTransparency = irisContext._config.FrameBgActiveTransparency
			})
			utils.applyButtonClick(Iris_RadioButton, function()
				widgetData.state.index:set(widgetData.arguments.Index)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			utils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_RadioButton
			return Iris_RadioButton
		end,
		Update = function(widgetData)
			widgetData.Instance.TextLabel.Text = widgetData.arguments.Text or "Radio Button"
			if widgetData.state then
				widgetData.state.index.lastChangeTick = irisContext._cycleTick
				irisContext._widgets[widgetData.type].UpdateState(widgetData)
			end
		end,
		Discard = function(widgetData)
			widgetData.Instance:Destroy()
			utils.discardState(widgetData)
		end,
		GenerateState = function(widgetData)
			if widgetData.state.index == nil then
				widgetData.state.index = irisContext._widgetState(widgetData, "index", widgetData.arguments.Index)
			end
		end,
		UpdateState = function(widgetData)
			local Circle = widgetData.Instance.Button.Circle
			if widgetData.state.index.value == widgetData.arguments.Index then
				Circle.BackgroundTransparency = irisContext._config.CheckMarkTransparency
				widgetData.lastSelectedTick = irisContext._cycleTick + 1
			else
				Circle.BackgroundTransparency = 1
				widgetData.lastUnselectedTick = irisContext._cycleTick + 1
			end
		end
	})
end
