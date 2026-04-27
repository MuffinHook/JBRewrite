require(script.Parent.Parent.Types)
return function(iris, util)
	local numberChangedEvent = {
		Init = function(widget) end,
		Get = function(widget)
			return widget.lastNumberChangedTick == iris._cycleTick
		end
	}
	local function getValueByIndex(value, componentIndex, config)
		if typeof(value) == "number" then
			return value
		else
			if typeof(value) == "Vector2" then
				if componentIndex == 1 then
					return value.X
				end
				if componentIndex == 2 then
					return value.Y
				end
				return
			elseif typeof(value) == "Vector3" then
				if componentIndex == 1 then
					return value.X
				end
				if componentIndex == 2 then
					return value.Y
				end
				if componentIndex == 3 then
					return value.Z
				end
				return
			elseif typeof(value) == "UDim" then
				if componentIndex == 1 then
					return value.Scale
				end
				if componentIndex == 2 then
					return value.Offset
				end
				return
			elseif typeof(value) == "UDim2" then
				if componentIndex == 1 then
					return value.X.Scale
				end
				if componentIndex == 2 then
					return value.X.Offset
				end
				if componentIndex == 3 then
					return value.Y.Scale
				end
				if componentIndex == 4 then
					return value.Y.Offset
				end
				return
			elseif typeof(value) == "Color3" then
				local colorComponents = if config.UseHSV then { value:ToHSV() } else { value.R, value.G, value.B }
				if componentIndex == 1 then
					return colorComponents[1]
				end
				if componentIndex == 2 then
					return colorComponents[2]
				end
				if componentIndex == 3 then
					return colorComponents[3]
				end
				return
			elseif typeof(value) == "Rect" then
				if componentIndex == 1 then
					return value.Min.X
				end
				if componentIndex == 2 then
					return value.Min.Y
				end
				if componentIndex == 3 then
					return value.Max.X
				end
				if componentIndex == 4 then
					return value.Max.Y
				end
			elseif typeof(value) == "table" then
				return value[componentIndex]
			end
			error((("Incorrect datatype or value: %* %* %*."):format(value, typeof(value), componentIndex)))
		end
	end
	local function updateValueByIndex(value, componentIndex, newValue, config)
		if typeof(value) == "number" then
			return newValue
		else
			if typeof(value) == "Vector2" then
				if componentIndex == 1 then
					return Vector2.new(newValue, value.Y)
				end
				if componentIndex == 2 then
					return Vector2.new(value.X, newValue)
				end
				return
			elseif typeof(value) == "Vector3" then
				if componentIndex == 1 then
					return Vector3.new(newValue, value.Y, value.Z)
				end
				if componentIndex == 2 then
					return Vector3.new(value.X, newValue, value.Z)
				end
				if componentIndex == 3 then
					return Vector3.new(value.X, value.Y, newValue)
				end
				return
			elseif typeof(value) == "UDim" then
				if componentIndex == 1 then
					return UDim.new(newValue, value.Offset)
				end
				if componentIndex == 2 then
					return UDim.new(value.Scale, newValue)
				end
				return
			elseif typeof(value) == "UDim2" then
				if componentIndex == 1 then
					return UDim2.new(UDim.new(newValue, value.X.Offset), value.Y)
				end
				if componentIndex == 2 then
					return UDim2.new(UDim.new(value.X.Scale, newValue), value.Y)
				end
				if componentIndex == 3 then
					return UDim2.new(value.X, UDim.new(newValue, value.Y.Offset))
				end
				if componentIndex == 4 then
					return UDim2.new(value.X, UDim.new(value.Y.Scale, newValue))
				end
				return
			elseif typeof(value) == "Rect" then
				if componentIndex == 1 then
					return Rect.new(Vector2.new(newValue, value.Min.Y), value.Max)
				end
				if componentIndex == 2 then
					return Rect.new(Vector2.new(value.Min.X, newValue), value.Max)
				end
				if componentIndex == 3 then
					return Rect.new(value.Min, Vector2.new(newValue, value.Max.Y))
				end
				if componentIndex == 4 then
					return Rect.new(value.Min, Vector2.new(value.Max.X, newValue))
				end
				return
			elseif typeof(value) == "Color3" then
				if config.UseHSV then
					local hue, saturation, brightness = value:ToHSV()
					if componentIndex == 1 then
						return Color3.fromHSV(newValue, saturation, brightness)
					end
					if componentIndex == 2 then
						return Color3.fromHSV(hue, newValue, brightness)
					end
					if componentIndex == 3 then
						return Color3.fromHSV(hue, saturation, newValue)
					end
				end
				if componentIndex == 1 then
					return Color3.new(newValue, value.G, value.B)
				end
				if componentIndex == 2 then
					return Color3.new(value.R, newValue, value.B)
				end
				if componentIndex == 3 then
					return Color3.new(value.R, value.G, newValue)
				end
			else
				return
			end
			error((("Incorrect datatype or value %* %* %*."):format(value, typeof(value), componentIndex)))
		end
	end
	local defaultIncrement = {
		Num = { 1 },
		Vector2 = { 1, 1 },
		Vector3 = { 1, 1, 1 },
		UDim = { 0.01, 1 },
		UDim2 = { 0.01, 1, 0.01, 1 },
		Color3 = { 1, 1, 1 },
		Color4 = { 1, 1, 1, 1 },
		Rect = { 1, 1, 1, 1 }
	}
	local defaultMin = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 0, 0 },
		UDim2 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}
	local defaultMax = {
		Num = { 100 },
		Vector2 = { 100, 100 },
		Vector3 = { 100, 100, 100 },
		UDim = { 1, 960 },
		UDim2 = { 1, 960, 1, 960 },
		Rect = { 960, 960, 960, 960 }
	}
	local defaultFormatPrefix = {
		Num = { "" },
		Vector2 = { "X: ", "Y: " },
		Vector3 = { "X: ", "Y: ", "Z: " },
		UDim = { "", "" },
		UDim2 = { "", "", "", "" },
		Color3_RGB = { "R: ", "G: ", "B: " },
		Color3_HSV = { "H: ", "S: ", "V: " },
		Color4_RGB = { "R: ", "G: ", "B: ", "T: " },
		Color4_HSV = { "H: ", "S: ", "V: ", "T: " },
		Rect = { "X: ", "Y: ", "X: ", "Y: " }
	}
	local defaultDecimalPlaces = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 3, 0 },
		UDim2 = { 3, 0, 3, 0 },
		Color3 = { 0, 0, 0 },
		Color4 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}
	local function generateAbstract(widgetType, widgetIndex, componentCount, defaultValue)
		return {
			hasState = true,
			hasChildren = false,
			Args = {
				Text = 1,
				Increment = 2,
				Min = 3,
				Max = 4,
				Format = 5
			},
			Events = {
				numberChanged = numberChangedEvent,
				hovered = util.EVENTS.hover(function(widget)
					return widget.Instance
				end)
			},
			GenerateState = function(widget)
				if widget.state.number == nil then
					widget.state.number = iris._widgetState(widget, "number", defaultValue)
				end
				if widget.state.editingText == nil then
					widget.state.editingText = iris._widgetState(widget, "editingText", 0)
				end
			end,
			Update = function(widget)
				local frameInstance = widget.Instance
				frameInstance.TextLabel.Text = widget.arguments.Text or ("Input %*"):format(widgetIndex)
				local formatTable, decimalPlaces, increment, incrementDivided, logValue, decimalCount, maxDecimals, maxValue, maxFromIncrement, maxFromMax, maxDividedValue, logMaxValue, maxDecimalFromMax, decimalFromMax, maxFromMin, maxDividedMinValue, logMinValue, maxDecimalFromMin, decimalFromMin
				if widget.arguments.Format then
					if typeof(widget.arguments.Format) == "table" then
						if not widget.arguments.Format then
							formatTable = {}
							for i = 1, componentCount do
								decimalPlaces = defaultDecimalPlaces[widgetIndex][i]
								if widget.arguments.Increment then
									increment = getValueByIndex(widget.arguments.Increment, i, widget.arguments)
									incrementDivided = if increment == 0 then 1 else increment
									logValue = -math.log10(incrementDivided)
									decimalCount = math.ceil(logValue)
									maxDecimals = math.max(decimalPlaces, decimalCount, decimalPlaces)
									decimalPlaces = maxDecimals
								end
								if widget.arguments.Max then
									maxValue = getValueByIndex(widget.arguments.Max, i, widget.arguments)
									maxDividedValue = if maxValue == 0 then 1 else maxValue
									logMaxValue = -math.log10(maxDividedValue)
									maxDecimalFromMax = math.ceil(logMaxValue)
									decimalFromMax = math.max(decimalPlaces, maxDecimalFromMax, decimalPlaces)
									decimalPlaces = decimalFromMax
								end
								if widget.arguments.Min then
									maxFromMin = getValueByIndex(widget.arguments.Min, i, widget.arguments)
									maxDividedMinValue = if maxFromMin == 0 then 1 else maxFromMin
									logMinValue = -math.log10(maxDividedMinValue)
									maxDecimalFromMin = math.ceil(logMinValue)
									decimalFromMin = math.max(decimalPlaces, maxDecimalFromMin, decimalPlaces)
									decimalPlaces = decimalFromMin
								end
								if decimalPlaces > 0 then
									formatTable[i] = ("%%.%*f"):format(decimalPlaces)
								else
									formatTable[i] = "%d"
								end
							end
							widget.arguments.Format = formatTable
							widget.arguments.Prefix = defaultFormatPrefix[widgetIndex]
						end
					else
						widget.arguments.Format = { widget.arguments.Format }
					end
				elseif not widget.arguments.Format then
					formatTable = {}
					for i = 1, componentCount do
						decimalPlaces = defaultDecimalPlaces[widgetIndex][i]
						if widget.arguments.Increment then
							increment = getValueByIndex(widget.arguments.Increment, i, widget.arguments)
							incrementDivided = if increment == 0 then 1 else increment
							logValue = -math.log10(incrementDivided)
							decimalCount = math.ceil(logValue)
							maxDecimals = math.max(decimalPlaces, decimalCount, decimalPlaces)
							decimalPlaces = maxDecimals
						end
						if widget.arguments.Max then
							maxValue = getValueByIndex(widget.arguments.Max, i, widget.arguments)
							maxDividedValue = if maxValue == 0 then 1 else maxValue
							logMaxValue = -math.log10(maxDividedValue)
							maxDecimalFromMax = math.ceil(logMaxValue)
							decimalFromMax = math.max(decimalPlaces, maxDecimalFromMax, decimalPlaces)
							decimalPlaces = decimalFromMax
						end
						if widget.arguments.Min then
							maxFromMin = getValueByIndex(widget.arguments.Min, i, widget.arguments)
							maxDividedMinValue = if maxFromMin == 0 then 1 else maxFromMin
							logMinValue = -math.log10(maxDividedMinValue)
							maxDecimalFromMin = math.ceil(logMinValue)
							decimalFromMin = math.max(decimalPlaces, maxDecimalFromMin, decimalPlaces)
							decimalPlaces = decimalFromMin
						end
						if decimalPlaces > 0 then
							formatTable[i] = ("%%.%*f"):format(decimalPlaces)
						else
							formatTable[i] = "%d"
						end
					end
					widget.arguments.Format = formatTable
					widget.arguments.Prefix = defaultFormatPrefix[widgetIndex]
				end
				if widgetType == "Input" and widgetIndex == "Num" then
					frameInstance.SubButton.Visible = not widget.arguments.NoButtons
					frameInstance.AddButton.Visible = not widget.arguments.NoButtons
					frameInstance.InputField1.Size = UDim2.new(UDim.new(iris._config.ContentWidth.Scale, iris._config.ContentWidth.Offset - if widget.arguments.NoButtons then 0 else 2 * iris._config.ItemInnerSpacing.X + 2 * (iris._config.TextSize + 2 * iris._config.FramePadding.Y)), iris._config.ContentHeight)
				end
				if widgetType == "Slider" then
					for j = 1, componentCount do
						local sliderField, sliderMin, sliderMax
						local GrabBar = frameInstance:FindFirstChild("SliderField" .. tostring(j)).GrabBar
						sliderField = widget.arguments.Increment and getValueByIndex(widget.arguments.Increment, j, widget.arguments) or defaultIncrement[widgetIndex][j]
						sliderMin = widget.arguments.Min and getValueByIndex(widget.arguments.Min, j, widget.arguments) or defaultMin[widgetIndex][j]
						sliderMax = widget.arguments.Max and getValueByIndex(widget.arguments.Max, j, widget.arguments) or defaultMax[widgetIndex][j]
						GrabBar.Size = UDim2.fromScale(1 / math.floor((1 + sliderMax - sliderMin) / sliderField), 1)
					end
					local callbackIndex = #iris._postCycleCallbacks + 1
					local targetCycleTick = iris._cycleTick + 1
					iris._postCycleCallbacks[callbackIndex] = function()
						if targetCycleTick <= iris._cycleTick then
							if widget.lastCycleTick ~= -1 then
								widget.state.number.lastChangeTick = iris._cycleTick
								iris._widgets[("Slider%*"):format(widgetIndex)].UpdateState(widget)
							end
							iris._postCycleCallbacks[callbackIndex] = nil
						end
					end
				end
			end,
			Discard = function(widget)
				widget.Instance:Destroy()
				util.discardState(widget)
			end
		}
	end
	local function focusLost(widget, textBox, componentIndex, dataType)
		local parsedNumber = tonumber(textBox.Text:match("-?%d*%.?%d*"))
		local numberState = widget.state.number
		if dataType == "Color4" and componentIndex == 4 then
			numberState = widget.state.transparency
		elseif dataType == "Color3" or dataType == "Color4" then
			numberState = widget.state.color
		end
		if parsedNumber ~= nil then
			if dataType == "Color3" or dataType == "Color4" and not widget.arguments.UseFloats then
				parsedNumber = parsedNumber / 255
			end
			if widget.arguments.Min ~= nil then
				parsedNumber = math.max(parsedNumber, getValueByIndex(widget.arguments.Min, componentIndex, widget.arguments))
			end
			if widget.arguments.Max ~= nil then
				parsedNumber = math.min(parsedNumber, getValueByIndex(widget.arguments.Max, componentIndex, widget.arguments))
			end
			if widget.arguments.Increment then
				local roundedValue = parsedNumber / getValueByIndex(widget.arguments.Increment, componentIndex, widget.arguments)
				parsedNumber = math.round(roundedValue) * getValueByIndex(widget.arguments.Increment, componentIndex, widget.arguments)
			end
			numberState:set(updateValueByIndex(numberState.value, componentIndex, parsedNumber, widget.arguments))
			widget.lastNumberChangedTick = iris._cycleTick + 1
		end
		local displayValue = getValueByIndex(numberState.value, componentIndex, widget.arguments)
		if dataType == "Color3" or dataType == "Color4" and not widget.arguments.UseFloats then
			displayValue = math.round(displayValue * 255)
		end
		local formatString = widget.arguments.Format[componentIndex] or widget.arguments.Format[1]
		if widget.arguments.Prefix then
			formatString = widget.arguments.Prefix[componentIndex] .. formatString
		end
		textBox.Text = string.format(formatString, displayValue)
		widget.state.editingText:set(0)
		textBox:ReleaseFocus(true)
	end
	local function generateButtons(widget, parent, buttonSize)
		local SubButton = util.abstractButton.Generate(widget)
		SubButton.Name = "SubButton"
		SubButton.Size = UDim2.fromOffset(iris._config.TextSize + 2 * iris._config.FramePadding.Y, iris._config.TextSize)
		SubButton.Text = "-"
		SubButton.TextXAlignment = Enum.TextXAlignment.Center
		SubButton.ZIndex = 5
		SubButton.LayoutOrder = 5
		SubButton.Parent = parent
		util.applyButtonClick(SubButton, function()
			local isCtrlHeld = util.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local newValue = widget.state.number.value - (widget.arguments.Increment and getValueByIndex(widget.arguments.Increment, 1, widget.arguments) or 1) * if isCtrlHeld then 100 else 1
			if widget.arguments.Min ~= nil then
				newValue = math.max(newValue, getValueByIndex(widget.arguments.Min, 1, widget.arguments))
			end
			if widget.arguments.Max ~= nil then
				newValue = math.min(newValue, getValueByIndex(widget.arguments.Max, 1, widget.arguments))
			end
			widget.state.number:set(newValue)
			widget.lastNumberChangedTick = iris._cycleTick + 1
		end)
		local AddButton = util.abstractButton.Generate(widget)
		AddButton.Name = "AddButton"
		AddButton.Size = UDim2.fromOffset(iris._config.TextSize + 2 * iris._config.FramePadding.Y, iris._config.TextSize)
		AddButton.Text = "+"
		AddButton.TextXAlignment = Enum.TextXAlignment.Center
		AddButton.ZIndex = 6
		AddButton.LayoutOrder = 6
		AddButton.Parent = parent
		util.applyButtonClick(AddButton, function()
			local isCtrlHeld = util.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local newValue = widget.state.number.value + (widget.arguments.Increment and getValueByIndex(widget.arguments.Increment, 1, widget.arguments) or 1) * if isCtrlHeld then 100 else 1
			if widget.arguments.Min ~= nil then
				newValue = math.max(newValue, getValueByIndex(widget.arguments.Min, 1, widget.arguments))
			end
			if widget.arguments.Max ~= nil then
				newValue = math.min(newValue, getValueByIndex(widget.arguments.Max, 1, widget.arguments))
			end
			widget.state.number:set(newValue)
			widget.lastNumberChangedTick = iris._cycleTick + 1
		end)
		return 2 * iris._config.ItemInnerSpacing.X + buttonSize * 2
	end
	local function generateField(widget, fieldIndex, fieldSize, dataType)
		local TextBox = Instance.new("TextBox")
		TextBox.Name = "InputField" .. tostring(fieldIndex)
		TextBox.AutomaticSize = Enum.AutomaticSize.Y
		TextBox.Size = UDim2.new(fieldSize, iris._config.ContentHeight)
		TextBox.BackgroundColor3 = iris._config.FrameBgColor
		TextBox.BackgroundTransparency = iris._config.FrameBgTransparency
		TextBox.TextTruncate = Enum.TextTruncate.AtEnd
		TextBox.ClearTextOnFocus = false
		TextBox.ZIndex = fieldIndex
		TextBox.LayoutOrder = fieldIndex
		TextBox.ClipsDescendants = true
		util.applyFrameStyle(TextBox)
		util.applyTextStyle(TextBox)
		util.UISizeConstraint(TextBox, Vector2.xAxis)
		TextBox.FocusLost:Connect(function()
			focusLost(widget, TextBox, fieldIndex, dataType)
		end)
		TextBox.Focused:Connect(function()
			TextBox.CursorPosition = #TextBox.Text + 1
			TextBox.SelectionStart = 1
			widget.state.editingText:set(fieldIndex)
		end)
		return TextBox
	end
	local function generateInputScalar(typeKey, componentCount, defaultVal)
		return util.extend(generateAbstract("Input", typeKey, componentCount, defaultVal), {
			Generate = function(widget)
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Input" .. typeKey
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				util.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local buttonWidth = if componentCount == 1 then generateButtons(widget, Frame, iris._config.TextSize + 2 * iris._config.FramePadding.Y) else 0
				local fieldDimension = UDim.new(iris._config.ContentWidth.Scale / componentCount, (iris._config.ContentWidth.Offset - iris._config.ItemInnerSpacing.X * (componentCount - 1) - buttonWidth) / componentCount)
				local lastFieldDimension = iris._config.ContentWidth - UDim.new(fieldDimension.Scale * (componentCount - 1), fieldDimension.Offset * (componentCount - 1) + iris._config.ItemInnerSpacing.X * (componentCount - 1) + buttonWidth)
				for i = 1, componentCount do
					local currentFieldDimension
					currentFieldDimension = if i == componentCount then lastFieldDimension else fieldDimension
					generateField(widget, i, currentFieldDimension, typeKey).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 7
				util.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(widget)
				local frameInstance = widget.Instance
				for i = 1, componentCount do
					local fieldTextBox = frameInstance:FindFirstChild("InputField" .. tostring(i))
					local formatStr = widget.arguments.Format[i] or widget.arguments.Format[1]
					if widget.arguments.Prefix then
						formatStr = widget.arguments.Prefix[i] .. formatStr
					end
					fieldTextBox.Text = string.format(formatStr, getValueByIndex(widget.state.number.value, i, widget.arguments))
				end
			end
		})
	end
	local lastMouseX = 0
	local isDragging = false
	local draggedWidget = nil
	local dragComponentIndex = 0
	local dragDataType = ""
	local function updateActiveDrag()
		local currentMouseX = util.getMouseLocation().X
		local mouseDeltaX = currentMouseX - lastMouseX
		lastMouseX = currentMouseX
		if isDragging == false then
		elseif draggedWidget ~= nil then
			local numberState = draggedWidget.state.number
			if dragDataType == "Color3" or dragDataType == "Color4" then
				local colorWidget = draggedWidget
				numberState = colorWidget.state.color
				if dragComponentIndex == 4 then
					numberState = colorWidget.state.transparency
				end
			end
			local incrementValue = draggedWidget.arguments.Increment and getValueByIndex(draggedWidget.arguments.Increment, dragComponentIndex, draggedWidget.arguments) or defaultIncrement[dragDataType][dragComponentIndex]
			local shiftMultiplier = incrementValue * if util.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then 10 else 1
			local altMultiplier = shiftMultiplier * if util.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then 0.1 else 1
			local newDragValue = getValueByIndex(numberState.value, dragComponentIndex, draggedWidget.arguments) + mouseDeltaX * (altMultiplier * if dragDataType == "Color3" or dragDataType == "Color4" then 5 else 1)
			if draggedWidget.arguments.Min ~= nil then
				newDragValue = math.max(newDragValue, getValueByIndex(draggedWidget.arguments.Min, dragComponentIndex, draggedWidget.arguments))
			end
			if draggedWidget.arguments.Max ~= nil then
				newDragValue = math.min(newDragValue, getValueByIndex(draggedWidget.arguments.Max, dragComponentIndex, draggedWidget.arguments))
			end
			numberState:set(updateValueByIndex(numberState.value, dragComponentIndex, newDragValue, draggedWidget.arguments))
			draggedWidget.lastNumberChangedTick = iris._cycleTick + 1
		end
	end
	local function DragMouseDown(widget, dataType, componentIndex, mouseX, mouseY)
		local currentTime = util.getTime()
		local isCtrlHeld = util.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
		if currentTime - widget.lastClickedTime < iris._config.MouseDoubleClickTime and (Vector2.new(mouseX, mouseY) - widget.lastClickedPosition).Magnitude < iris._config.MouseDoubleClickMaxDist or isCtrlHeld then
			widget.state.editingText:set(componentIndex)
		else
			widget.lastClickedTime = currentTime
			widget.lastClickedPosition = Vector2.new(mouseX, mouseY)
			isDragging = true
			draggedWidget = widget
			dragComponentIndex = componentIndex
			dragDataType = dataType
			updateActiveDrag()
		end
	end
	util.registerEvent("InputChanged", function()
		if iris._started then
			updateActiveDrag()
		end
	end)
	util.registerEvent("InputEnded", function(input)
		if iris._started and (input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging) then
			isDragging = false
			draggedWidget = nil
			dragComponentIndex = 0
		end
	end)
	local function generateField_2(widget, fieldIndex, fieldSize, dataType)
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "DragField" .. tostring(fieldIndex)
		TextButton.AutomaticSize = Enum.AutomaticSize.Y
		TextButton.Size = fieldSize
		TextButton.BackgroundColor3 = iris._config.FrameBgColor
		TextButton.BackgroundTransparency = iris._config.FrameBgTransparency
		TextButton.Text = ""
		TextButton.AutoButtonColor = false
		TextButton.LayoutOrder = fieldIndex
		TextButton.ClipsDescendants = true
		util.applyFrameStyle(TextButton)
		util.applyTextStyle(TextButton)
		util.UISizeConstraint(TextButton, Vector2.xAxis)
		TextButton.TextXAlignment = Enum.TextXAlignment.Center
		util.applyInteractionHighlights("Background", TextButton, TextButton, {
			Color = iris._config.FrameBgColor,
			Transparency = iris._config.FrameBgTransparency,
			HoveredColor = iris._config.FrameBgHoveredColor,
			HoveredTransparency = iris._config.FrameBgHoveredTransparency,
			ActiveColor = iris._config.FrameBgActiveColor,
			ActiveTransparency = iris._config.FrameBgActiveTransparency
		})
		local InputField = Instance.new("TextBox")
		InputField.Name = "InputField"
		InputField.Size = UDim2.fromScale(1, 1)
		InputField.BackgroundTransparency = 1
		InputField.ClearTextOnFocus = false
		InputField.TextTruncate = Enum.TextTruncate.AtEnd
		InputField.ClipsDescendants = true
		InputField.Visible = false
		util.applyFrameStyle(InputField, true)
		util.applyTextStyle(InputField)
		InputField.Parent = TextButton
		InputField.FocusLost:Connect(function()
			focusLost(widget, InputField, fieldIndex, dataType)
		end)
		InputField.Focused:Connect(function()
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			widget.state.editingText:set(fieldIndex)
		end)
		util.applyButtonDown(TextButton, function(mouseX, mouseY)
			DragMouseDown(widget, dataType, fieldIndex, mouseX, mouseY)
		end)
		return TextButton
	end
	local function generateDragScalar(typeKey, componentCount, defaultVal)
		return util.extend(generateAbstract("Drag", typeKey, componentCount, defaultVal), {
			Generate = function(widget)
				widget.lastClickedTime = -1
				widget.lastClickedPosition = Vector2.zero
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Drag" .. typeKey
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				util.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local colorBoxWidth = 0
				local buttonSize = iris._config.TextSize + 2 * iris._config.FramePadding.Y
				if typeKey == "Color3" or typeKey == "Color4" then
					colorBoxWidth = colorBoxWidth + (iris._config.ItemInnerSpacing.X + buttonSize)
					local ColorBox = Instance.new("ImageLabel")
					ColorBox.Name = "ColorBox"
					ColorBox.Size = UDim2.fromOffset(buttonSize, buttonSize)
					ColorBox.BorderSizePixel = 0
					ColorBox.Image = util.ICONS.ALPHA_BACKGROUND_TEXTURE
					ColorBox.ImageTransparency = 1
					ColorBox.LayoutOrder = 5
					util.applyFrameStyle(ColorBox, true)
					ColorBox.Parent = Frame
				end
				local fieldDimension = UDim.new(iris._config.ContentWidth.Scale / componentCount, (iris._config.ContentWidth.Offset - iris._config.ItemInnerSpacing.X * (componentCount - 1) - colorBoxWidth) / componentCount)
				local lastFieldDimension = iris._config.ContentWidth - UDim.new(fieldDimension.Scale * (componentCount - 1), fieldDimension.Offset * (componentCount - 1) + iris._config.ItemInnerSpacing.X * (componentCount - 1) + colorBoxWidth)
				for i = 1, componentCount do
					local currentFieldSize
					currentFieldSize = if i == componentCount then UDim2.new(lastFieldDimension, iris._config.ContentHeight) else UDim2.new(fieldDimension, iris._config.ContentHeight)
					generateField_2(widget, i, currentFieldSize, typeKey).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 6
				util.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(widget)
				local frameInstance = widget.Instance
				for i = 1, componentCount do
					local numberState = widget.state.number
					if typeKey == "Color3" or typeKey == "Color4" then
						numberState = widget.state.color
						if i == 4 then
							numberState = widget.state.transparency
						end
					end
					local dragField = frameInstance:FindFirstChild("DragField" .. tostring(i))
					local InputField = dragField.InputField
					local displayValue = getValueByIndex(numberState.value, i, widget.arguments)
					if (typeKey == "Color3" or typeKey == "Color4") and not widget.arguments.UseFloats then
						displayValue = math.round(displayValue * 255)
					end
					local formatStr = widget.arguments.Format[i] or widget.arguments.Format[1]
					if widget.arguments.Prefix then
						formatStr = widget.arguments.Prefix[i] .. formatStr
					end
					dragField.Text = string.format(formatStr, displayValue)
					InputField.Text = tostring(displayValue)
					if widget.state.editingText.value == i then
						InputField.Visible = true
						InputField:CaptureFocus()
						dragField.TextTransparency = 1
					else
						InputField.Visible = false
						dragField.TextTransparency = iris._config.TextTransparency
					end
				end
				if typeKey == "Color3" or typeKey == "Color4" then
					local ColorBox = frameInstance.ColorBox
					ColorBox.BackgroundColor3 = widget.state.color.value
					if typeKey == "Color4" then
						ColorBox.ImageTransparency = 1 - widget.state.transparency.value
					end
				end
			end
		})
	end
	local function generateColorDragScalar(colorType, ...)
		local defaultValues = { ... }
		return util.extend(generateDragScalar(colorType, if colorType == "Color4" then 4 else 3, defaultValues[1]), {
			Args = {
				Text = 1,
				UseFloats = 2,
				UseHSV = 3,
				Format = 4
			},
			Update = function(widget)
				local labelText = widget.arguments.Text
				if not labelText then
					labelText = ("Drag %*"):format(colorType)
				end
				widget.Instance.TextLabel.Text = labelText
				local argsCopy, prefixTable, colorKey, colorSuffix
				if widget.arguments.Format then
					if typeof(widget.arguments.Format) == "table" then
						if not widget.arguments.Format then
							if widget.arguments.UseFloats then
								widget.arguments.Format = { "%.3f" }
							else
								widget.arguments.Format = { "%d" }
							end
							argsCopy = widget.arguments
							prefixTable = defaultFormatPrefix
							colorKey = colorType
							colorSuffix = if widget.arguments.UseHSV then "_HSV" else "_RGB"
							argsCopy.Prefix = defaultFormatPrefix[colorType .. colorSuffix]
						end
					else
						widget.arguments.Format = { widget.arguments.Format }
					end
				elseif not widget.arguments.Format then
					if widget.arguments.UseFloats then
						widget.arguments.Format = { "%.3f" }
					else
						widget.arguments.Format = { "%d" }
					end
					argsCopy = widget.arguments
					prefixTable = defaultFormatPrefix
					colorKey = colorType
					colorSuffix = if widget.arguments.UseHSV then "_HSV" else "_RGB"
					argsCopy.Prefix = defaultFormatPrefix[colorType .. colorSuffix]
				end
				widget.arguments.Min = { 0, 0, 0, 0 }
				widget.arguments.Max = { 1, 1, 1, 1 }
				widget.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 }
				if widget.state then
					widget.state.color.lastChangeTick = iris._cycleTick
					if colorType == "Color4" then
						widget.state.transparency.lastChangeTick = iris._cycleTick
					end
					iris._widgets[widget.type].UpdateState(widget)
				end
			end,
			GenerateState = function(widget)
				if widget.state.color == nil then
					widget.state.color = iris._widgetState(widget, "color", defaultValues[1])
				end
				if colorType == "Color4" and widget.state.transparency == nil then
					widget.state.transparency = iris._widgetState(widget, "transparency", defaultValues[2])
				end
				if widget.state.editingText == nil then
					widget.state.editingText = iris._widgetState(widget, "editingText", false)
				end
			end
		})
	end
	local isSliderDragging = false
	local sliderDraggedWidget = nil
	local sliderDragComponentIndex = 0
	local sliderDragDataType = ""
	local function updateActiveSlider()
		if isSliderDragging == false then
		elseif sliderDraggedWidget ~= nil then
			local sliderField = sliderDraggedWidget.Instance:FindFirstChild("SliderField" .. tostring(sliderDragComponentIndex))
			local incrementValue = sliderDraggedWidget.arguments.Increment and getValueByIndex(sliderDraggedWidget.arguments.Increment, sliderDragComponentIndex, sliderDraggedWidget.arguments) or defaultIncrement[sliderDragDataType][sliderDragComponentIndex]
			local minValue = sliderDraggedWidget.arguments.Min and getValueByIndex(sliderDraggedWidget.arguments.Min, sliderDragComponentIndex, sliderDraggedWidget.arguments) or defaultMin[sliderDragDataType][sliderDragComponentIndex]
			local maxValue = sliderDraggedWidget.arguments.Max and getValueByIndex(sliderDraggedWidget.arguments.Max, sliderDragComponentIndex, sliderDraggedWidget.arguments) or defaultMax[sliderDragDataType][sliderDragComponentIndex]
			local grabBarWidth = sliderField.GrabBar.AbsoluteSize.X
			sliderDraggedWidget.state.number:set(updateValueByIndex(sliderDraggedWidget.state.number.value, sliderDragComponentIndex, math.clamp(math.round((util.getMouseLocation().X - (sliderField.AbsolutePosition.X - util.GuiOffset.X + grabBarWidth / 2)) / (sliderField.AbsoluteSize.X - grabBarWidth) * math.floor((maxValue - minValue) / incrementValue)) * incrementValue + minValue, minValue, maxValue), sliderDraggedWidget.arguments))
			sliderDraggedWidget.lastNumberChangedTick = iris._cycleTick + 1
		end
	end
	local function SliderMouseDown(widget, sliderDataType, sliderComponentIndex)
		if util.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or util.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			widget.state.editingText:set(sliderComponentIndex)
		else
			isSliderDragging = true
			sliderDraggedWidget = widget
			sliderDragComponentIndex = sliderComponentIndex
			sliderDragDataType = sliderDataType
			updateActiveSlider()
		end
	end
	util.registerEvent("InputChanged", function()
		if iris._started then
			updateActiveSlider()
		end
	end)
	util.registerEvent("InputEnded", function(input)
		if iris._started and (input.UserInputType == Enum.UserInputType.MouseButton1 and isSliderDragging) then
			isSliderDragging = false
			sliderDraggedWidget = nil
			sliderDragComponentIndex = 0
			sliderDragDataType = ""
		end
	end)
	local function generateField_3(widget, fieldIndex, fieldSize, dataType)
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "SliderField" .. tostring(fieldIndex)
		TextButton.AutomaticSize = Enum.AutomaticSize.Y
		TextButton.Size = fieldSize
		TextButton.BackgroundColor3 = iris._config.FrameBgColor
		TextButton.BackgroundTransparency = iris._config.FrameBgTransparency
		TextButton.Text = ""
		TextButton.AutoButtonColor = false
		TextButton.LayoutOrder = fieldIndex
		TextButton.ClipsDescendants = true
		util.applyFrameStyle(TextButton)
		util.applyTextStyle(TextButton)
		util.UISizeConstraint(TextButton, Vector2.xAxis)
		local OverlayText = Instance.new("TextLabel")
		OverlayText.Name = "OverlayText"
		OverlayText.Size = UDim2.fromScale(1, 1)
		OverlayText.BackgroundTransparency = 1
		OverlayText.BorderSizePixel = 0
		OverlayText.ZIndex = 10
		OverlayText.ClipsDescendants = true
		util.applyTextStyle(OverlayText)
		OverlayText.TextXAlignment = Enum.TextXAlignment.Center
		OverlayText.Parent = TextButton
		util.applyInteractionHighlights("Background", TextButton, TextButton, {
			Color = iris._config.FrameBgColor,
			Transparency = iris._config.FrameBgTransparency,
			HoveredColor = iris._config.FrameBgHoveredColor,
			HoveredTransparency = iris._config.FrameBgHoveredTransparency,
			ActiveColor = iris._config.FrameBgActiveColor,
			ActiveTransparency = iris._config.FrameBgActiveTransparency
		})
		local InputField = Instance.new("TextBox")
		InputField.Name = "InputField"
		InputField.Size = UDim2.fromScale(1, 1)
		InputField.BackgroundTransparency = 1
		InputField.ClearTextOnFocus = false
		InputField.TextTruncate = Enum.TextTruncate.AtEnd
		InputField.ClipsDescendants = true
		InputField.Visible = false
		util.applyFrameStyle(InputField, true)
		util.applyTextStyle(InputField)
		InputField.Parent = TextButton
		InputField.FocusLost:Connect(function()
			focusLost(widget, InputField, fieldIndex, dataType)
		end)
		InputField.Focused:Connect(function()
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			widget.state.editingText:set(fieldIndex)
		end)
		util.applyButtonDown(TextButton, function()
			SliderMouseDown(widget, dataType, fieldIndex)
		end)
		local GrabBar = Instance.new("Frame")
		GrabBar.Name = "GrabBar"
		GrabBar.AnchorPoint = Vector2.new(0.5, 0.5)
		GrabBar.Position = UDim2.fromScale(0, 0.5)
		GrabBar.BackgroundColor3 = iris._config.SliderGrabColor
		GrabBar.Transparency = iris._config.SliderGrabTransparency
		GrabBar.BorderSizePixel = 0
		GrabBar.ZIndex = 5
		util.applyInteractionHighlights("Background", TextButton, GrabBar, {
			Color = iris._config.SliderGrabColor,
			Transparency = iris._config.SliderGrabTransparency,
			HoveredColor = iris._config.SliderGrabColor,
			HoveredTransparency = iris._config.SliderGrabTransparency,
			ActiveColor = iris._config.SliderGrabActiveColor,
			ActiveTransparency = iris._config.SliderGrabActiveTransparency
		})
		if iris._config.GrabRounding > 0 then
			util.UICorner(GrabBar, iris._config.GrabRounding)
		end
		util.UISizeConstraint(GrabBar, Vector2.new(iris._config.GrabMinSize, 0))
		GrabBar.Parent = TextButton
		return TextButton
	end
	local function generateSliderScalar(typeKey, componentCount, defaultVal)
		return util.extend(generateAbstract("Slider", typeKey, componentCount, defaultVal), {
			Generate = function(widget)
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Slider" .. typeKey
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				util.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local fieldDimension = UDim.new(iris._config.ContentWidth.Scale / componentCount, (iris._config.ContentWidth.Offset - iris._config.ItemInnerSpacing.X * (componentCount - 1)) / componentCount)
				local lastFieldDimension = iris._config.ContentWidth - UDim.new(fieldDimension.Scale * (componentCount - 1), fieldDimension.Offset * (componentCount - 1) + iris._config.ItemInnerSpacing.X * (componentCount - 1))
				for i = 1, componentCount do
					local currentFieldSize
					currentFieldSize = if i == componentCount then UDim2.new(lastFieldDimension, iris._config.ContentHeight) else UDim2.new(fieldDimension, iris._config.ContentHeight)
					generateField_3(widget, i, currentFieldSize, typeKey).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 5
				util.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(widget)
				local frameInstance = widget.Instance
				for i = 1, componentCount do
					local sliderField = frameInstance:FindFirstChild("SliderField" .. tostring(i))
					local InputField = sliderField.InputField
					local OverlayText = sliderField.OverlayText
					local GrabBar = sliderField.GrabBar
					local displayValue = getValueByIndex(widget.state.number.value, i, widget.arguments)
					local formatStr = widget.arguments.Format[i] or widget.arguments.Format[1]
					if widget.arguments.Prefix then
						formatStr = widget.arguments.Prefix[i] .. formatStr
					end
					OverlayText.Text = string.format(formatStr, displayValue)
					InputField.Text = tostring(displayValue)
					local incrementValue = widget.arguments.Increment and getValueByIndex(widget.arguments.Increment, i, widget.arguments) or defaultIncrement[typeKey][i]
					local minValue = widget.arguments.Min and getValueByIndex(widget.arguments.Min, i, widget.arguments) or defaultMin[typeKey][i]
					local maxValue = widget.arguments.Max and getValueByIndex(widget.arguments.Max, i, widget.arguments) or defaultMax[typeKey][i]
					local sliderWidth = sliderField.AbsoluteSize.X
					local grabBarWidth = sliderWidth - GrabBar.AbsoluteSize.X
					local valueRange = math.floor((maxValue - minValue) / incrementValue)
					GrabBar.Position = UDim2.fromScale(grabBarWidth / sliderWidth * math.clamp(math.floor((displayValue - minValue) / (maxValue - minValue) * valueRange) / valueRange, 0, 1) + (1 - grabBarWidth / sliderWidth) / 2, 0.5)
					if widget.state.editingText.value == i then
						InputField.Visible = true
						OverlayText.Visible = false
						GrabBar.Visible = false
						InputField:CaptureFocus()
					else
						InputField.Visible = false
						OverlayText.Visible = true
						GrabBar.Visible = true
					end
				end
			end
		})
	end
	local function generateEnumSliderScalar(enumType, enumValue)
		local baseSlider = generateSliderScalar("Enum", 1, enumValue.Value)
		local enumLookupTable = { string }
		for enumItem, enumItemValue in enumType:GetEnumItems() do
			enumLookupTable[enumItemValue.Value] = enumItemValue.Name
		end
		return util.extend(baseSlider, {
			Args = {
				Text = 1
			},
			Update = function(widget)
				local frameInstance = widget.Instance
				frameInstance.TextLabel.Text = widget.arguments.Text or "Input Enum"
				widget.arguments.Increment = 1
				widget.arguments.Min = 0
				widget.arguments.Max = #enumType:GetEnumItems() - 1
				local GrabBar = frameInstance:FindFirstChild("SliderField1").GrabBar
				GrabBar.Size = UDim2.fromScale(1 / math.floor(#enumType:GetEnumItems()), 1)
			end,
			GenerateState = function(widget)
				if widget.state.number == nil then
					widget.state.number = iris._widgetState(widget, "number", enumValue.Value)
				end
				if widget.state.enumItem == nil then
					widget.state.enumItem = iris._widgetState(widget, "enumItem", enumValue)
				end
				if widget.state.editingText == nil then
					widget.state.editingText = iris._widgetState(widget, "editingText", false)
				end
			end
		})
	end
	local inputNumWidget = generateInputScalar("Num", 1, 0)
	inputNumWidget.Args.NoButtons = 6
	iris.WidgetConstructor("InputNum", inputNumWidget)
	iris.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero))
	iris.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	iris.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()))
	iris.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()))
	iris.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	iris.WidgetConstructor("DragNum", generateDragScalar("Num", 1, 0))
	iris.WidgetConstructor("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero))
	iris.WidgetConstructor("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	iris.WidgetConstructor("DragUDim", generateDragScalar("UDim", 2, UDim.new()))
	iris.WidgetConstructor("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()))
	iris.WidgetConstructor("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	iris.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)))
	iris.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0))
	iris.WidgetConstructor("SliderNum", generateSliderScalar("Num", 1, 0))
	iris.WidgetConstructor("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero))
	iris.WidgetConstructor("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	iris.WidgetConstructor("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()))
	iris.WidgetConstructor("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()))
	iris.WidgetConstructor("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	iris.WidgetConstructor("InputText", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			TextHint = 2,
			ReadOnly = 3,
			MultiLine = 4
		},
		Events = {
			textChanged = {
				Init = function(widget)
					widget.lastTextChangedTick = 0
				end,
				Get = function(widget)
					return widget.lastTextChangedTick == iris._cycleTick
				end
			},
			hovered = util.EVENTS.hover(function(widget)
				return widget.Instance
			end)
		},
		Generate = function(widget)
			local Iris_InputText = Instance.new("Frame")
			Iris_InputText.Name = "Iris_InputText"
			Iris_InputText.AutomaticSize = Enum.AutomaticSize.Y
			Iris_InputText.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_InputText.BackgroundTransparency = 1
			Iris_InputText.BorderSizePixel = 0
			util.UIListLayout(Iris_InputText, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local InputField = Instance.new("TextBox")
			InputField.Name = "InputField"
			InputField.AutomaticSize = Enum.AutomaticSize.Y
			InputField.Size = UDim2.new(iris._config.ContentWidth, iris._config.ContentHeight)
			InputField.BackgroundColor3 = iris._config.FrameBgColor
			InputField.BackgroundTransparency = iris._config.FrameBgTransparency
			InputField.Text = ""
			InputField.TextYAlignment = Enum.TextYAlignment.Top
			InputField.PlaceholderColor3 = iris._config.TextDisabledColor
			InputField.ClearTextOnFocus = false
			InputField.ClipsDescendants = true
			util.applyFrameStyle(InputField)
			util.applyTextStyle(InputField)
			util.UISizeConstraint(InputField, Vector2.xAxis)
			InputField.Parent = Iris_InputText
			InputField.FocusLost:Connect(function()
				widget.state.text:set(InputField.Text)
				widget.lastTextChangedTick = iris._cycleTick + 1
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.Size = UDim2.fromOffset(0, iris._config.TextSize + 2 * iris._config.FramePadding.Y)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			util.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_InputText
			return Iris_InputText
		end,
		GenerateState = function(widget)
			if widget.state.text == nil then
				widget.state.text = iris._widgetState(widget, "text", "")
			end
		end,
		Update = function(widget)
			local frameInstance = widget.Instance
			local InputField = frameInstance.InputField
			frameInstance.TextLabel.Text = widget.arguments.Text or "Input Text"
			InputField.PlaceholderText = widget.arguments.TextHint or ""
			InputField.TextEditable = not widget.arguments.ReadOnly
			InputField.MultiLine = widget.arguments.MultiLine or false
		end,
		UpdateState = function(widget)
			widget.Instance.InputField.Text = widget.state.text.value
		end,
		Discard = function(widget)
			widget.Instance:Destroy()
			util.discardState(widget)
		end
	})
end
