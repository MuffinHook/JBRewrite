-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	p1.WidgetConstructor("RadioButton", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2
		},
		Events = {
			selected = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastSelectedTick == p1._cycleTick
				end
			},
			unselected = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastUnselectedTick == p1._cycleTick
				end
			},
			active = {
				Init = function(p1) end,
				Get = function(p1)
					return p1.state.index.value == p1.arguments.Index
				end
			},
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_RadioButton = Instance.new("TextButton")
			Iris_RadioButton.Name = "Iris_RadioButton"
			Iris_RadioButton.AutomaticSize = Enum.AutomaticSize.XY
			Iris_RadioButton.Size = UDim2.fromOffset(0, 0)
			Iris_RadioButton.BackgroundTransparency = 1
			Iris_RadioButton.BorderSizePixel = 0
			Iris_RadioButton.Text = ""
			Iris_RadioButton.AutoButtonColor = false
			p2.UIListLayout(Iris_RadioButton, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local v1 = p1._config.TextSize + 2 * (p1._config.FramePadding.Y - 1)
			local Button = Instance.new("Frame")
			Button.Name = "Button"
			Button.Size = UDim2.fromOffset(v1, v1)
			Button.BackgroundColor3 = p1._config.FrameBgColor
			Button.BackgroundTransparency = p1._config.FrameBgTransparency
			Button.Parent = Iris_RadioButton
			p2.UICorner(Button)
			p2.UIPadding(Button, Vector2.new(math.max(1, (math.floor(v1 / 5))), (math.max(1, (math.floor(v1 / 5))))))
			local Circle = Instance.new("Frame")
			Circle.Name = "Circle"
			Circle.Size = UDim2.fromScale(1, 1)
			Circle.BackgroundColor3 = p1._config.CheckMarkColor
			Circle.BackgroundTransparency = p1._config.CheckMarkTransparency
			p2.UICorner(Circle)
			Circle.Parent = Button
			p2.applyInteractionHighlights("Background", Iris_RadioButton, Button, {
				Color = p1._config.FrameBgColor,
				Transparency = p1._config.FrameBgTransparency,
				HoveredColor = p1._config.FrameBgHoveredColor,
				HoveredTransparency = p1._config.FrameBgHoveredTransparency,
				ActiveColor = p1._config.FrameBgActiveColor,
				ActiveTransparency = p1._config.FrameBgActiveTransparency
			})
			p2.applyButtonClick(Iris_RadioButton, function()
				p12.state.index:set(p12.arguments.Index)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_RadioButton
			return Iris_RadioButton
		end,
		Update = function(p12)
			p12.Instance.TextLabel.Text = p12.arguments.Text or "Radio Button"
			if p12.state then
				p12.state.index.lastChangeTick = p1._cycleTick
				p1._widgets[p12.type].UpdateState(p12)
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12)
			if p12.state.index == nil then
				p12.state.index = p1._widgetState(p12, "index", p12.arguments.Index)
			end
		end,
		UpdateState = function(p12)
			local Circle = p12.Instance.Button.Circle
			if p12.state.index.value == p12.arguments.Index then
				Circle.BackgroundTransparency = p1._config.CheckMarkTransparency
				p12.lastSelectedTick = p1._cycleTick + 1
			else
				Circle.BackgroundTransparency = 1
				p12.lastUnselectedTick = p1._cycleTick + 1
			end
		end
	})
end
