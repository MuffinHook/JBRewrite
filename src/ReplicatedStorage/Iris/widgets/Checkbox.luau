require(script.Parent.Parent.Types)
return function(irisContext, irisAPI)
	irisContext.WidgetConstructor("Checkbox", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			checked = {
				Init = function(irisContext) end,
				Get = function(widget)
					return widget.lastCheckedTick == irisContext._cycleTick
				end
			},
			unchecked = {
				Init = function(irisContext) end,
				Get = function(widget)
					return widget.lastUncheckedTick == irisContext._cycleTick
				end
			},
			hovered = irisAPI.EVENTS.hover(function(irisContext)
				return irisContext.Instance
			end)
		},
		Generate = function(widget)
			local Iris_Checkbox = Instance.new("TextButton")
			Iris_Checkbox.Name = "Iris_Checkbox"
			Iris_Checkbox.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Checkbox.Size = UDim2.fromOffset(0, 0)
			Iris_Checkbox.BackgroundTransparency = 1
			Iris_Checkbox.BorderSizePixel = 0
			Iris_Checkbox.Text = ""
			Iris_Checkbox.AutoButtonColor = false
			irisAPI.UIListLayout(Iris_Checkbox, Enum.FillDirection.Horizontal, UDim.new(0, irisContext._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local boxSize = irisContext._config.TextSize + 2 * irisContext._config.FramePadding.Y
			local Box = Instance.new("Frame")
			Box.Name = "Box"
			Box.Size = UDim2.fromOffset(boxSize, boxSize)
			Box.BackgroundColor3 = irisContext._config.FrameBgColor
			Box.BackgroundTransparency = irisContext._config.FrameBgTransparency
			irisAPI.applyFrameStyle(Box, true)
			irisAPI.UIPadding(Box, Vector2.new(math.floor(boxSize / 10), (math.floor(boxSize / 10))))
			irisAPI.applyInteractionHighlights("Background", Iris_Checkbox, Box, {
				Color = irisContext._config.FrameBgColor,
				Transparency = irisContext._config.FrameBgTransparency,
				HoveredColor = irisContext._config.FrameBgHoveredColor,
				HoveredTransparency = irisContext._config.FrameBgHoveredTransparency,
				ActiveColor = irisContext._config.FrameBgActiveColor,
				ActiveTransparency = irisContext._config.FrameBgActiveTransparency
			})
			Box.Parent = Iris_Checkbox
			local Checkmark = Instance.new("ImageLabel")
			Checkmark.Name = "Checkmark"
			Checkmark.Size = UDim2.fromScale(1, 1)
			Checkmark.BackgroundTransparency = 1
			Checkmark.Image = irisAPI.ICONS.CHECK_MARK
			Checkmark.ImageColor3 = irisContext._config.CheckMarkColor
			Checkmark.ImageTransparency = 1
			Checkmark.ScaleType = Enum.ScaleType.Fit
			Checkmark.Parent = Box
			irisAPI.applyButtonClick(Iris_Checkbox, function()
				widget.state.isChecked:set(not widget.state.isChecked.value)
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			irisAPI.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_Checkbox
			return Iris_Checkbox
		end,
		GenerateState = function(widget)
			if widget.state.isChecked == nil then
				widget.state.isChecked = irisContext._widgetState(widget, "checked", false)
			end
		end,
		Update = function(irisContext)
			irisContext.Instance.TextLabel.Text = irisContext.arguments.Text or "Checkbox"
		end,
		UpdateState = function(widget)
			local Checkmark = widget.Instance.Box.Checkmark
			if widget.state.isChecked.value then
				Checkmark.ImageTransparency = irisContext._config.CheckMarkTransparency
				widget.lastCheckedTick = irisContext._cycleTick + 1
			else
				Checkmark.ImageTransparency = 1
				widget.lastUncheckedTick = irisContext._cycleTick + 1
			end
		end,
		Discard = function(irisContext)
			irisContext.Instance:Destroy()
			irisAPI.discardState(irisContext)
		end
	})
end
