require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Checkbox", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			checked = {
				Init = function(p1) --[[ Line: 13 ]] end,
				Get = function(p12) --[[ Line: 14 | Upvalues: p1 (copy) ]]
					return p12.lastCheckedTick == p1._cycleTick
				end
			},
			unchecked = {
				Init = function(p1) --[[ Line: 19 ]] end,
				Get = function(p12) --[[ Line: 20 | Upvalues: p1 (copy) ]]
					return p12.lastUncheckedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 24 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Name: Generate | Line: 28 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_Checkbox = Instance.new("TextButton")
			Iris_Checkbox.Name = "Iris_Checkbox"
			Iris_Checkbox.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Checkbox.Size = UDim2.fromOffset(0, 0)
			Iris_Checkbox.BackgroundTransparency = 1
			Iris_Checkbox.BorderSizePixel = 0
			Iris_Checkbox.Text = ""
			Iris_Checkbox.AutoButtonColor = false
			p2.UIListLayout(Iris_Checkbox, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
			local Box = Instance.new("Frame")
			Box.Name = "Box"
			Box.Size = UDim2.fromOffset(v1, v1)
			Box.BackgroundColor3 = p1._config.FrameBgColor
			Box.BackgroundTransparency = p1._config.FrameBgTransparency
			p2.applyFrameStyle(Box, true)
			p2.UIPadding(Box, Vector2.new(math.floor(v1 / 10), (math.floor(v1 / 10))))
			p2.applyInteractionHighlights("Background", Iris_Checkbox, Box, {
				Color = p1._config.FrameBgColor,
				Transparency = p1._config.FrameBgTransparency,
				HoveredColor = p1._config.FrameBgHoveredColor,
				HoveredTransparency = p1._config.FrameBgHoveredTransparency,
				ActiveColor = p1._config.FrameBgActiveColor,
				ActiveTransparency = p1._config.FrameBgActiveTransparency
			})
			Box.Parent = Iris_Checkbox
			local Checkmark = Instance.new("ImageLabel")
			Checkmark.Name = "Checkmark"
			Checkmark.Size = UDim2.fromScale(1, 1)
			Checkmark.BackgroundTransparency = 1
			Checkmark.Image = p2.ICONS.CHECK_MARK
			Checkmark.ImageColor3 = p1._config.CheckMarkColor
			Checkmark.ImageTransparency = 1
			Checkmark.ScaleType = Enum.ScaleType.Fit
			Checkmark.Parent = Box
			p2.applyButtonClick(Iris_Checkbox, function() --[[ Line: 73 | Upvalues: p12 (copy) ]]
				p12.state.isChecked:set(not p12.state.isChecked.value)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_Checkbox
			return Iris_Checkbox
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 89 | Upvalues: p1 (copy) ]]
			if p12.state.isChecked == nil then
				p12.state.isChecked = p1._widgetState(p12, "checked", false)
			end
		end,
		Update = function(p1) --[[ Name: Update | Line: 94 ]]
			p1.Instance.TextLabel.Text = p1.arguments.Text or "Checkbox"
		end,
		UpdateState = function(p12) --[[ Name: UpdateState | Line: 98 | Upvalues: p1 (copy) ]]
			local Checkmark = p12.Instance.Box.Checkmark
			if p12.state.isChecked.value then
				Checkmark.ImageTransparency = p1._config.CheckMarkTransparency
				p12.lastCheckedTick = p1._cycleTick + 1
			else
				Checkmark.ImageTransparency = 1
				p12.lastUncheckedTick = p1._cycleTick + 1
			end
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 110 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end