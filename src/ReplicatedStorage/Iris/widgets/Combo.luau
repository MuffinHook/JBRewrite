-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	p1.WidgetConstructor("Selectable", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2,
			NoClick = 3
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
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance.SelectableButton
			end),
			rightClicked = p2.EVENTS.rightClick(function(p1)
				return p1.Instance.SelectableButton
			end),
			doubleClicked = p2.EVENTS.doubleClick(function(p1)
				return p1.Instance.SelectableButton
			end),
			ctrlClicked = p2.EVENTS.ctrlClick(function(p1)
				return p1.Instance.SelectableButton
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance.SelectableButton
			end)
		},
		Generate = function(p12)
			local Iris_Selectable = Instance.new("Frame")
			Iris_Selectable.Name = "Iris_Selectable"
			Iris_Selectable.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, p1._config.TextSize + 2 * p1._config.FramePadding.Y - p1._config.ItemSpacing.Y))
			Iris_Selectable.BackgroundTransparency = 1
			Iris_Selectable.BorderSizePixel = 0
			local SelectableButton = Instance.new("TextButton")
			SelectableButton.Name = "SelectableButton"
			SelectableButton.Size = UDim2.new(1, 0, 0, p1._config.TextSize + 2 * p1._config.FramePadding.Y)
			local fromOffset = UDim2.fromOffset
			SelectableButton.Position = fromOffset(0, -bit32.rshift(p1._config.ItemSpacing.Y, 1))
			SelectableButton.BackgroundColor3 = p1._config.HeaderColor
			SelectableButton.ClipsDescendants = true
			p2.applyFrameStyle(SelectableButton)
			p2.applyTextStyle(SelectableButton)
			p2.UISizeConstraint(SelectableButton, Vector2.xAxis)
			p12.ButtonColors = {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderActiveColor,
				ActiveTransparency = p1._config.HeaderActiveTransparency
			}
			p2.applyInteractionHighlights("Background", SelectableButton, SelectableButton, p12.ButtonColors)
			p2.applyButtonClick(SelectableButton, function()
				if p12.arguments.NoClick ~= true then
					if type(p12.state.index.value) == "boolean" then
						p12.state.index:set(not p12.state.index.value)
						return
					end
					p12.state.index:set(p12.arguments.Index)
				end
			end)
			SelectableButton.Parent = Iris_Selectable
			return Iris_Selectable
		end,
		GenerateState = function(p12)
			if p12.state.index == nil then
				if p12.arguments.Index ~= nil then
					error("A shared state index is required for Iris.Selectables() with an Index argument.", 5)
				end
				p12.state.index = p1._widgetState(p12, "index", false)
			end
		end,
		Update = function(p1)
			p1.Instance.SelectableButton.Text = p1.arguments.Text or "Selectable"
		end,
		UpdateState = function(p12)
			local SelectableButton = p12.Instance.SelectableButton
			if p12.state.index.value == p12.arguments.Index or p12.state.index.value == true then
				p12.ButtonColors.Transparency = p1._config.HeaderTransparency
				SelectableButton.BackgroundTransparency = p1._config.HeaderTransparency
				p12.lastSelectedTick = p1._cycleTick + 1
			else
				p12.ButtonColors.Transparency = 1
				SelectableButton.BackgroundTransparency = 1
				p12.lastUnselectedTick = p1._cycleTick + 1
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
	local v1 = false
	local v2 = -1
	local v3 = nil
	local v4 = 0
	local function UpdateChildContainerTransform(p12)
		local PreviewContainer = p12.Instance.PreviewContainer
		local ChildContainer = p12.ChildContainer
		local v1 = PreviewContainer.AbsolutePosition - p2.GuiOffset
		local PopupBorderSize = p1._config.PopupBorderSize
		local AbsoluteSize_2 = ChildContainer.Parent.AbsoluteSize
		local Y = p12.UIListLayout.AbsoluteContentSize.Y
		v4 = Y
		local v2 = Y + 2 * p1._config.WindowPadding.Y
		local v3 = v1.Y + PreviewContainer.AbsoluteSize.Y + PopupBorderSize
		local zero = Vector2.zero
		local v42 = AbsoluteSize_2.Y - v3
		if v42 < v2 and AbsoluteSize_2.Y / 2 < v3 then
			v3 = v1.Y - PopupBorderSize
			zero = Vector2.yAxis
			v42 = v3
		end
		ChildContainer.AnchorPoint = zero
		ChildContainer.Position = UDim2.fromOffset(v1.X, v3)
		ChildContainer.Size = UDim2.fromOffset(PreviewContainer.AbsoluteSize.X, (math.min(v2, v42)))
	end
	local function f5()
		if v1 and (v3 and v3.UIListLayout.AbsoluteContentSize.Y ~= v4) then
			UpdateChildContainerTransform(v3)
		end
	end
	table.insert(p1._postCycleCallbacks, f5)
	local function UpdateComboState(p12)
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.MouseButton2 or (p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.MouseWheel))) then
			if v1 == false or not v3 or v2 == p1._cycleTick then
				return
			end
			local v12 = p2.getMouseLocation()
			local PreviewContainer = v3.Instance.PreviewContainer
			local ChildContainer = v3.ChildContainer
			if p2.isPosInsideRect(v12, PreviewContainer.AbsolutePosition - p2.GuiOffset, PreviewContainer.AbsolutePosition - p2.GuiOffset + PreviewContainer.AbsoluteSize) then
				return
			end
			if not p2.isPosInsideRect(v12, ChildContainer.AbsolutePosition - p2.GuiOffset, ChildContainer.AbsolutePosition - p2.GuiOffset + ChildContainer.AbsoluteSize) then
				v3.state.isOpened:set(false)
			end
		end
	end
	p2.registerEvent("InputBegan", UpdateComboState)
	p2.registerEvent("InputChanged", UpdateComboState)
	p1.WidgetConstructor("Combo", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1,
			NoButton = 2,
			NoPreview = 3
		},
		Events = {
			opened = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			closed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastClosedTick == p1._cycleTick
				end
			},
			changed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastChangedTick == p1._cycleTick
				end
			},
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance.PreviewContainer
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local v12 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
			local Iris_Combo = Instance.new("Frame")
			Iris_Combo.Name = "Iris_Combo"
			Iris_Combo.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Combo.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_Combo.BackgroundTransparency = 1
			Iris_Combo.BorderSizePixel = 0
			p2.UIListLayout(Iris_Combo, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local PreviewContainer = Instance.new("TextButton")
			PreviewContainer.Name = "PreviewContainer"
			PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			PreviewContainer.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
			PreviewContainer.BackgroundTransparency = 1
			PreviewContainer.Text = ""
			PreviewContainer.AutoButtonColor = false
			PreviewContainer.ZIndex = 2
			p2.applyFrameStyle(PreviewContainer, true)
			p2.UIListLayout(PreviewContainer, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			p2.UISizeConstraint(PreviewContainer, Vector2.new(v12))
			PreviewContainer.Parent = Iris_Combo
			local PreviewLabel = Instance.new("TextLabel")
			PreviewLabel.Name = "PreviewLabel"
			PreviewLabel.AutomaticSize = Enum.AutomaticSize.Y
			PreviewLabel.Size = UDim2.new(UDim.new(1, 0), p1._config.ContentHeight)
			PreviewLabel.BackgroundColor3 = p1._config.FrameBgColor
			PreviewLabel.BackgroundTransparency = p1._config.FrameBgTransparency
			PreviewLabel.BorderSizePixel = 0
			PreviewLabel.ClipsDescendants = true
			p2.applyTextStyle(PreviewLabel)
			p2.UIPadding(PreviewLabel, p1._config.FramePadding)
			PreviewLabel.Parent = PreviewContainer
			local DropdownButton = Instance.new("TextLabel")
			DropdownButton.Name = "DropdownButton"
			DropdownButton.Size = UDim2.new(0, v12, p1._config.ContentHeight.Scale, (math.max(p1._config.ContentHeight.Offset, v12)))
			DropdownButton.BackgroundColor3 = p1._config.ButtonColor
			DropdownButton.BackgroundTransparency = p1._config.ButtonTransparency
			DropdownButton.BorderSizePixel = 0
			DropdownButton.Text = ""
			local v32 = v12 - math.round(v12 * 0.2) * 2
			local Dropdown = Instance.new("ImageLabel")
			Dropdown.Name = "Dropdown"
			Dropdown.AnchorPoint = Vector2.new(0.5, 0.5)
			Dropdown.Size = UDim2.fromOffset(v32, v32)
			Dropdown.Position = UDim2.fromScale(0.5, 0.5)
			Dropdown.BackgroundTransparency = 1
			Dropdown.BorderSizePixel = 0
			Dropdown.ImageColor3 = p1._config.TextColor
			Dropdown.ImageTransparency = p1._config.TextTransparency
			Dropdown.Parent = DropdownButton
			DropdownButton.Parent = PreviewContainer
			p2.applyInteractionHighlightsWithMultiHighlightee("Background", PreviewContainer, {
				{
					PreviewLabel,
					{
						Color = p1._config.FrameBgColor,
						Transparency = p1._config.FrameBgTransparency,
						HoveredColor = p1._config.FrameBgHoveredColor,
						HoveredTransparency = p1._config.FrameBgHoveredTransparency,
						ActiveColor = p1._config.FrameBgActiveColor,
						ActiveTransparency = p1._config.FrameBgActiveTransparency
					}
				},
				{
					DropdownButton,
					{
						Color = p1._config.ButtonColor,
						Transparency = p1._config.ButtonTransparency,
						HoveredColor = p1._config.ButtonHoveredColor,
						HoveredTransparency = p1._config.ButtonHoveredTransparency,
						ActiveColor = p1._config.ButtonHoveredColor,
						ActiveTransparency = p1._config.ButtonHoveredTransparency
					}
				}
			})
			p2.applyButtonClick(PreviewContainer, function()
				if not v1 or v3 == p12 then
					p12.state.isOpened:set(not p12.state.isOpened.value)
				end
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.Size = UDim2.fromOffset(0, v12)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_Combo
			local ComboContainer = Instance.new("ScrollingFrame")
			ComboContainer.Name = "ComboContainer"
			ComboContainer.BackgroundColor3 = p1._config.PopupBgColor
			ComboContainer.BackgroundTransparency = p1._config.PopupBgTransparency
			ComboContainer.BorderSizePixel = 0
			ComboContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ComboContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			ComboContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			ComboContainer.ScrollBarThickness = p1._config.ScrollbarSize
			ComboContainer.CanvasSize = UDim2.fromScale(0, 0)
			ComboContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			ComboContainer.TopImage = p2.ICONS.BLANK_SQUARE
			ComboContainer.MidImage = p2.ICONS.BLANK_SQUARE
			ComboContainer.BottomImage = p2.ICONS.BLANK_SQUARE
			ComboContainer.ClipsDescendants = true
			p2.UIStroke(ComboContainer, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			p2.UIPadding(ComboContainer, Vector2.new(2, p1._config.WindowPadding.Y))
			p2.UISizeConstraint(ComboContainer, Vector2.new(100))
			local v4 = p2.UIListLayout(ComboContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			v4.VerticalAlignment = Enum.VerticalAlignment.Top
			ComboContainer.Parent = p1._rootInstance and p1._rootInstance:WaitForChild("PopupScreenGui")
			p12.ChildContainer = ComboContainer
			p12.UIListLayout = v4
			return Iris_Combo
		end,
		GenerateState = function(p12)
			if p12.state.index == nil then
				p12.state.index = p1._widgetState(p12, "index", "No Selection")
			end
			if p12.state.isOpened == nil then
				p12.state.isOpened = p1._widgetState(p12, "isOpened", false)
			end
			p12.state.index:onChange(function()
				p12.lastChangedTick = p1._cycleTick + 1
				if p12.state.isOpened.value then
					p12.state.isOpened:set(false)
				end
			end)
		end,
		Update = function(p12)
			local v1 = p12.Instance
			local PreviewContainer = v1.PreviewContainer
			local PreviewLabel = PreviewContainer.PreviewLabel
			local DropdownButton = PreviewContainer.DropdownButton
			v1.TextLabel.Text = p12.arguments.Text or "Combo"
			if p12.arguments.NoButton then
				DropdownButton.Visible = false
				PreviewLabel.Size = UDim2.new(UDim.new(1, 0), PreviewLabel.Size.Height)
			else
				DropdownButton.Visible = true
				PreviewLabel.Size = UDim2.new(UDim.new(1, -(p1._config.TextSize + 2 * p1._config.FramePadding.Y)), PreviewLabel.Size.Height)
			end
			if p12.arguments.NoPreview then
				PreviewLabel.Visible = false
				PreviewContainer.Size = UDim2.new(0, 0, 0, 0)
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.XY
			else
				PreviewLabel.Visible = true
				PreviewContainer.Size = UDim2.new(p1._config.ContentWidth, p1._config.ContentHeight)
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			end
		end,
		UpdateState = function(p12)
			local ChildContainer = p12.ChildContainer
			local PreviewContainer = p12.Instance.PreviewContainer
			local Dropdown = PreviewContainer.DropdownButton.Dropdown
			if p12.state.isOpened.value then
				v1 = true
				v3 = p12
				v2 = p1._cycleTick
				p12.lastOpenedTick = p1._cycleTick + 1
				Dropdown.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
				ChildContainer.Visible = true
				UpdateChildContainerTransform(p12)
			else
				if v1 then
					v1 = false
					v3 = nil
					p12.lastClosedTick = p1._cycleTick + 1
				end
				Dropdown.Image = p2.ICONS.DOWN_POINTING_TRIANGLE
				ChildContainer.Visible = false
			end
			local value = p12.state.index.value
			PreviewContainer.PreviewLabel.Text = if typeof(value) == "EnumItem" then value.Name else tostring(value)
		end,
		ChildAdded = function(p1, p2)
			UpdateChildContainerTransform(p1)
			return p1.ChildContainer
		end,
		Discard = function(p1)
			if v3 and v3 == p1 then
				v3 = nil
				v1 = false
			end
			p1.Instance:Destroy()
			p1.ChildContainer:Destroy()
			p2.discardState(p1)
		end
	})
end
