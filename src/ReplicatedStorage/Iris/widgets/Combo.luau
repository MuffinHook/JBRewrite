require(script.Parent.Parent.Types)
return function(iris, irisUtils)
	iris.WidgetConstructor("Selectable", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2,
			NoClick = 3
		},
		Events = {
			selected = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastSelectedTick == iris._cycleTick
				end
			},
			unselected = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastUnselectedTick == iris._cycleTick
				end
			},
			active = {
				Init = function(iris) end,
				Get = function(iris)
					return iris.state.index.value == iris.arguments.Index
				end
			},
			clicked = irisUtils.EVENTS.click(function(iris)
				return iris.Instance.SelectableButton
			end),
			rightClicked = irisUtils.EVENTS.rightClick(function(iris)
				return iris.Instance.SelectableButton
			end),
			doubleClicked = irisUtils.EVENTS.doubleClick(function(iris)
				return iris.Instance.SelectableButton
			end),
			ctrlClicked = irisUtils.EVENTS.ctrlClick(function(iris)
				return iris.Instance.SelectableButton
			end),
			hovered = irisUtils.EVENTS.hover(function(iris)
				return iris.Instance.SelectableButton
			end)
		},
		Generate = function(widget)
			local Iris_Selectable = Instance.new("Frame")
			Iris_Selectable.Name = "Iris_Selectable"
			Iris_Selectable.Size = UDim2.new(iris._config.ItemWidth, UDim.new(0, iris._config.TextSize + 2 * iris._config.FramePadding.Y - iris._config.ItemSpacing.Y))
			Iris_Selectable.BackgroundTransparency = 1
			Iris_Selectable.BorderSizePixel = 0
			local SelectableButton = Instance.new("TextButton")
			SelectableButton.Name = "SelectableButton"
			SelectableButton.Size = UDim2.new(1, 0, 0, iris._config.TextSize + 2 * iris._config.FramePadding.Y)
			local fromOffset = UDim2.fromOffset
			SelectableButton.Position = fromOffset(0, -bit32.rshift(iris._config.ItemSpacing.Y, 1))
			SelectableButton.BackgroundColor3 = iris._config.HeaderColor
			SelectableButton.ClipsDescendants = true
			irisUtils.applyFrameStyle(SelectableButton)
			irisUtils.applyTextStyle(SelectableButton)
			irisUtils.UISizeConstraint(SelectableButton, Vector2.xAxis)
			widget.ButtonColors = {
				Color = iris._config.HeaderColor,
				Transparency = 1,
				HoveredColor = iris._config.HeaderHoveredColor,
				HoveredTransparency = iris._config.HeaderHoveredTransparency,
				ActiveColor = iris._config.HeaderActiveColor,
				ActiveTransparency = iris._config.HeaderActiveTransparency
			}
			irisUtils.applyInteractionHighlights("Background", SelectableButton, SelectableButton, widget.ButtonColors)
			irisUtils.applyButtonClick(SelectableButton, function()
				if widget.arguments.NoClick ~= true then
					if type(widget.state.index.value) == "boolean" then
						widget.state.index:set(not widget.state.index.value)
						return
					end
					widget.state.index:set(widget.arguments.Index)
				end
			end)
			SelectableButton.Parent = Iris_Selectable
			return Iris_Selectable
		end,
		GenerateState = function(widget)
			if widget.state.index == nil then
				if widget.arguments.Index ~= nil then
					error("A shared state index is required for Iris.Selectables() with an Index argument.", 5)
				end
				widget.state.index = iris._widgetState(widget, "index", false)
			end
		end,
		Update = function(iris)
			iris.Instance.SelectableButton.Text = iris.arguments.Text or "Selectable"
		end,
		UpdateState = function(widget)
			local SelectableButton = widget.Instance.SelectableButton
			if widget.state.index.value == widget.arguments.Index or widget.state.index.value == true then
				widget.ButtonColors.Transparency = iris._config.HeaderTransparency
				SelectableButton.BackgroundTransparency = iris._config.HeaderTransparency
				widget.lastSelectedTick = iris._cycleTick + 1
			else
				widget.ButtonColors.Transparency = 1
				SelectableButton.BackgroundTransparency = 1
				widget.lastUnselectedTick = iris._cycleTick + 1
			end
		end,
		Discard = function(iris)
			iris.Instance:Destroy()
			irisUtils.discardState(iris)
		end
	})
	local isComboOpen = false
	local lastToggleTick = -1
	local openedCombo = nil
	local lastContentHeight = 0
	local function UpdateChildContainerTransform(widget)
		local PreviewContainer = widget.Instance.PreviewContainer
		local ChildContainer = widget.ChildContainer
		local containerPosition = PreviewContainer.AbsolutePosition - irisUtils.GuiOffset
		local PopupBorderSize = iris._config.PopupBorderSize
		local AbsoluteSize_2 = ChildContainer.Parent.AbsoluteSize
		local Y = widget.UIListLayout.AbsoluteContentSize.Y
		lastContentHeight = Y
		local contentHeightWithPadding = Y + 2 * iris._config.WindowPadding.Y
		local popupYPosition = containerPosition.Y + PreviewContainer.AbsoluteSize.Y + PopupBorderSize
		local anchorPoint = Vector2.zero
		local availableSpace = AbsoluteSize_2.Y - popupYPosition
		if availableSpace < contentHeightWithPadding and AbsoluteSize_2.Y / 2 < popupYPosition then
			popupYPosition = containerPosition.Y - PopupBorderSize
			anchorPoint = Vector2.yAxis
			availableSpace = popupYPosition
		end
		ChildContainer.AnchorPoint = anchorPoint
		ChildContainer.Position = UDim2.fromOffset(containerPosition.X, popupYPosition)
		ChildContainer.Size = UDim2.fromOffset(PreviewContainer.AbsoluteSize.X, (math.min(contentHeightWithPadding, availableSpace)))
	end
	local function checkContentSizeChanged()
		if isComboOpen and (openedCombo and openedCombo.UIListLayout.AbsoluteContentSize.Y ~= lastContentHeight) then
			UpdateChildContainerTransform(openedCombo)
		end
	end
	table.insert(iris._postCycleCallbacks, checkContentSizeChanged)
	local function UpdateComboState(inputObject)
		if iris._started and (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or (inputObject.UserInputType == Enum.UserInputType.MouseButton2 or (inputObject.UserInputType == Enum.UserInputType.Touch or inputObject.UserInputType == Enum.UserInputType.MouseWheel))) then
			if isComboOpen == false or not openedCombo or lastToggleTick == iris._cycleTick then
				return
			end
			local mouseLocation = irisUtils.getMouseLocation()
			local PreviewContainer = openedCombo.Instance.PreviewContainer
			local ChildContainer = openedCombo.ChildContainer
			if irisUtils.isPosInsideRect(mouseLocation, PreviewContainer.AbsolutePosition - irisUtils.GuiOffset, PreviewContainer.AbsolutePosition - irisUtils.GuiOffset + PreviewContainer.AbsoluteSize) then
				return
			end
			if not irisUtils.isPosInsideRect(mouseLocation, ChildContainer.AbsolutePosition - irisUtils.GuiOffset, ChildContainer.AbsolutePosition - irisUtils.GuiOffset + ChildContainer.AbsoluteSize) then
				openedCombo.state.isOpened:set(false)
			end
		end
	end
	irisUtils.registerEvent("InputBegan", UpdateComboState)
	irisUtils.registerEvent("InputChanged", UpdateComboState)
	iris.WidgetConstructor("Combo", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1,
			NoButton = 2,
			NoPreview = 3
		},
		Events = {
			opened = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastOpenedTick == iris._cycleTick
				end
			},
			closed = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastClosedTick == iris._cycleTick
				end
			},
			changed = {
				Init = function(iris) end,
				Get = function(widget)
					return widget.lastChangedTick == iris._cycleTick
				end
			},
			clicked = irisUtils.EVENTS.click(function(iris)
				return iris.Instance.PreviewContainer
			end),
			hovered = irisUtils.EVENTS.hover(function(iris)
				return iris.Instance
			end)
		},
		Generate = function(widget)
			local buttonHeight = iris._config.TextSize + 2 * iris._config.FramePadding.Y
			local Iris_Combo = Instance.new("Frame")
			Iris_Combo.Name = "Iris_Combo"
			Iris_Combo.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Combo.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_Combo.BackgroundTransparency = 1
			Iris_Combo.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_Combo, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local PreviewContainer = Instance.new("TextButton")
			PreviewContainer.Name = "PreviewContainer"
			PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			PreviewContainer.Size = UDim2.new(iris._config.ContentWidth, UDim.new(0, 0))
			PreviewContainer.BackgroundTransparency = 1
			PreviewContainer.Text = ""
			PreviewContainer.AutoButtonColor = false
			PreviewContainer.ZIndex = 2
			irisUtils.applyFrameStyle(PreviewContainer, true)
			irisUtils.UIListLayout(PreviewContainer, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			irisUtils.UISizeConstraint(PreviewContainer, Vector2.new(buttonHeight))
			PreviewContainer.Parent = Iris_Combo
			local PreviewLabel = Instance.new("TextLabel")
			PreviewLabel.Name = "PreviewLabel"
			PreviewLabel.AutomaticSize = Enum.AutomaticSize.Y
			PreviewLabel.Size = UDim2.new(UDim.new(1, 0), iris._config.ContentHeight)
			PreviewLabel.BackgroundColor3 = iris._config.FrameBgColor
			PreviewLabel.BackgroundTransparency = iris._config.FrameBgTransparency
			PreviewLabel.BorderSizePixel = 0
			PreviewLabel.ClipsDescendants = true
			irisUtils.applyTextStyle(PreviewLabel)
			irisUtils.UIPadding(PreviewLabel, iris._config.FramePadding)
			PreviewLabel.Parent = PreviewContainer
			local DropdownButton = Instance.new("TextLabel")
			DropdownButton.Name = "DropdownButton"
			DropdownButton.Size = UDim2.new(0, buttonHeight, iris._config.ContentHeight.Scale, (math.max(iris._config.ContentHeight.Offset, buttonHeight)))
			DropdownButton.BackgroundColor3 = iris._config.ButtonColor
			DropdownButton.BackgroundTransparency = iris._config.ButtonTransparency
			DropdownButton.BorderSizePixel = 0
			DropdownButton.Text = ""
			local dropdownIconSize = buttonHeight - math.round(buttonHeight * 0.2) * 2
			local Dropdown = Instance.new("ImageLabel")
			Dropdown.Name = "Dropdown"
			Dropdown.AnchorPoint = Vector2.new(0.5, 0.5)
			Dropdown.Size = UDim2.fromOffset(dropdownIconSize, dropdownIconSize)
			Dropdown.Position = UDim2.fromScale(0.5, 0.5)
			Dropdown.BackgroundTransparency = 1
			Dropdown.BorderSizePixel = 0
			Dropdown.ImageColor3 = iris._config.TextColor
			Dropdown.ImageTransparency = iris._config.TextTransparency
			Dropdown.Parent = DropdownButton
			DropdownButton.Parent = PreviewContainer
			irisUtils.applyInteractionHighlightsWithMultiHighlightee("Background", PreviewContainer, {
				{
					PreviewLabel,
					{
						Color = iris._config.FrameBgColor,
						Transparency = iris._config.FrameBgTransparency,
						HoveredColor = iris._config.FrameBgHoveredColor,
						HoveredTransparency = iris._config.FrameBgHoveredTransparency,
						ActiveColor = iris._config.FrameBgActiveColor,
						ActiveTransparency = iris._config.FrameBgActiveTransparency
					}
				},
				{
					DropdownButton,
					{
						Color = iris._config.ButtonColor,
						Transparency = iris._config.ButtonTransparency,
						HoveredColor = iris._config.ButtonHoveredColor,
						HoveredTransparency = iris._config.ButtonHoveredTransparency,
						ActiveColor = iris._config.ButtonHoveredColor,
						ActiveTransparency = iris._config.ButtonHoveredTransparency
					}
				}
			})
			irisUtils.applyButtonClick(PreviewContainer, function()
				if not isComboOpen or openedCombo == widget then
					widget.state.isOpened:set(not widget.state.isOpened.value)
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.Size = UDim2.fromOffset(0, buttonHeight)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			irisUtils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_Combo
			local ComboContainer = Instance.new("ScrollingFrame")
			ComboContainer.Name = "ComboContainer"
			ComboContainer.BackgroundColor3 = iris._config.PopupBgColor
			ComboContainer.BackgroundTransparency = iris._config.PopupBgTransparency
			ComboContainer.BorderSizePixel = 0
			ComboContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ComboContainer.ScrollBarImageTransparency = iris._config.ScrollbarGrabTransparency
			ComboContainer.ScrollBarImageColor3 = iris._config.ScrollbarGrabColor
			ComboContainer.ScrollBarThickness = iris._config.ScrollbarSize
			ComboContainer.CanvasSize = UDim2.fromScale(0, 0)
			ComboContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			ComboContainer.TopImage = irisUtils.ICONS.BLANK_SQUARE
			ComboContainer.MidImage = irisUtils.ICONS.BLANK_SQUARE
			ComboContainer.BottomImage = irisUtils.ICONS.BLANK_SQUARE
			ComboContainer.ClipsDescendants = true
			irisUtils.UIStroke(ComboContainer, iris._config.WindowBorderSize, iris._config.BorderColor, iris._config.BorderTransparency)
			irisUtils.UIPadding(ComboContainer, Vector2.new(2, iris._config.WindowPadding.Y))
			irisUtils.UISizeConstraint(ComboContainer, Vector2.new(100))
			local comboListLayout = irisUtils.UIListLayout(ComboContainer, Enum.FillDirection.Vertical, UDim.new(0, iris._config.ItemSpacing.Y))
			comboListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			ComboContainer.Parent = iris._rootInstance and iris._rootInstance:WaitForChild("PopupScreenGui")
			widget.ChildContainer = ComboContainer
			widget.UIListLayout = comboListLayout
			return Iris_Combo
		end,
		GenerateState = function(widget)
			if widget.state.index == nil then
				widget.state.index = iris._widgetState(widget, "index", "No Selection")
			end
			if widget.state.isOpened == nil then
				widget.state.isOpened = iris._widgetState(widget, "isOpened", false)
			end
			widget.state.index:onChange(function()
				widget.lastChangedTick = iris._cycleTick + 1
				if widget.state.isOpened.value then
					widget.state.isOpened:set(false)
				end
			end)
		end,
		Update = function(widget)
			local instance = widget.Instance
			local PreviewContainer = instance.PreviewContainer
			local PreviewLabel = PreviewContainer.PreviewLabel
			local DropdownButton = PreviewContainer.DropdownButton
			instance.TextLabel.Text = widget.arguments.Text or "Combo"
			if widget.arguments.NoButton then
				DropdownButton.Visible = false
				PreviewLabel.Size = UDim2.new(UDim.new(1, 0), PreviewLabel.Size.Height)
			else
				DropdownButton.Visible = true
				PreviewLabel.Size = UDim2.new(UDim.new(1, -(iris._config.TextSize + 2 * iris._config.FramePadding.Y)), PreviewLabel.Size.Height)
			end
			if widget.arguments.NoPreview then
				PreviewLabel.Visible = false
				PreviewContainer.Size = UDim2.new(0, 0, 0, 0)
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.XY
			else
				PreviewLabel.Visible = true
				PreviewContainer.Size = UDim2.new(iris._config.ContentWidth, iris._config.ContentHeight)
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			end
		end,
		UpdateState = function(widget)
			local ChildContainer = widget.ChildContainer
			local PreviewContainer = widget.Instance.PreviewContainer
			local Dropdown = PreviewContainer.DropdownButton.Dropdown
			if widget.state.isOpened.value then
				isComboOpen = true
				openedCombo = widget
				lastToggleTick = iris._cycleTick
				widget.lastOpenedTick = iris._cycleTick + 1
				Dropdown.Image = irisUtils.ICONS.RIGHT_POINTING_TRIANGLE
				ChildContainer.Visible = true
				UpdateChildContainerTransform(widget)
			else
				if isComboOpen then
					isComboOpen = false
					openedCombo = nil
					widget.lastClosedTick = iris._cycleTick + 1
				end
				Dropdown.Image = irisUtils.ICONS.DOWN_POINTING_TRIANGLE
				ChildContainer.Visible = false
			end
			local value = widget.state.index.value
			PreviewContainer.PreviewLabel.Text = if typeof(value) == "EnumItem" then value.Name else tostring(value)
		end,
		ChildAdded = function(widget, irisUtils)
			UpdateChildContainerTransform(widget)
			return widget.ChildContainer
		end,
		Discard = function(widget)
			if openedCombo and openedCombo == widget then
				openedCombo = nil
				isComboOpen = false
			end
			widget.Instance:Destroy()
			widget.ChildContainer:Destroy()
			irisUtils.discardState(widget)
		end
	})
end
