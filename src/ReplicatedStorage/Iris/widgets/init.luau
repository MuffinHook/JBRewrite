require(script.Parent.Types)
local utilities = {}
return function(iris)
	utilities.GuiService = game:GetService("GuiService")
	utilities.RunService = game:GetService("RunService")
	utilities.UserInputService = game:GetService("UserInputService")
	utilities.ContextActionService = game:GetService("ContextActionService")
	utilities.TextService = game:GetService("TextService")
	utilities.ICONS = {
		BLANK_SQUARE = "rbxasset://textures/SurfacesDefault.png",
		RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
		DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
		MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
		BOTTOM_RIGHT_CORNER = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
		CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
		BORDER = "rbxasset://textures/ui/InspectMenu/gr-item-selector.png",
		ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png",
		UNKNOWN_TEXTURE = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	}
	utilities.IS_STUDIO = utilities.RunService:IsStudio()
	function utilities.getTime()
		if utilities.IS_STUDIO then
			return os.clock()
		else
			return time()
		end
	end
	utilities.GuiOffset = if iris._config.IgnoreGuiInset then -utilities.GuiService:GetGuiInset() else Vector2.zero
	utilities.MouseOffset = if iris._config.IgnoreGuiInset then Vector2.zero else utilities.GuiService:GetGuiInset()
	local topbarInsetConnection = nil
	topbarInsetConnection = utilities.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function()
		utilities.MouseOffset = if iris._config.IgnoreGuiInset then Vector2.zero else utilities.GuiService:GetGuiInset()
		utilities.GuiOffset = if iris._config.IgnoreGuiInset then -utilities.GuiService:GetGuiInset() else Vector2.zero
		topbarInsetConnection:Disconnect()
	end)
	task.delay(5, function()
		topbarInsetConnection:Disconnect()
	end)
	function utilities.getMouseLocation()
		return utilities.UserInputService:GetMouseLocation() - utilities.MouseOffset
	end
	function utilities.isPosInsideRect(position, minBounds, maxBounds)
		return if position.X >= minBounds.X and (position.X <= maxBounds.X and position.Y >= minBounds.Y) then position.Y <= maxBounds.Y else false
	end
	function utilities.findBestWindowPosForPopup(position, size, minBounds, screenBounds)
		local adjustedPosition = if position.X + size.X + 20 > screenBounds.X then if position.Y + size.Y + 20 > screenBounds.Y then position + Vector2.new(0, -(20 + size.Y)) else position + Vector2.new(0, 20) else position + Vector2.new(20)
		return Vector2.new(math.max(math.min(adjustedPosition.X + size.X, screenBounds.X) - size.X, minBounds.X), (math.max(math.min(adjustedPosition.Y + size.Y, screenBounds.Y) - size.Y, minBounds.Y)))
	end
	function utilities.getScreenSizeForWindow(guiElement)
		if guiElement.Instance:IsA("GuiBase2d") then
			return guiElement.Instance.AbsoluteSize
		else
			local parentElement = guiElement.Instance.Parent
			if parentElement:IsA("GuiBase2d") or parentElement.Parent:IsA("GuiBase2d") then
				return parentElement.AbsoluteSize
			else
				return workspace.CurrentCamera.ViewportSize
			end
		end
	end
	function utilities.extend(sourceTable, overrideTable)
		local mergedTable = table.clone(sourceTable)
		for key, value in overrideTable do
			mergedTable[key] = value
		end
		return mergedTable
	end
	function utilities.UIPadding(guiElement, padding)
		local UIPadding = Instance.new("UIPadding")
		UIPadding.PaddingLeft = UDim.new(0, padding.X)
		UIPadding.PaddingRight = UDim.new(0, padding.X)
		UIPadding.PaddingTop = UDim.new(0, padding.Y)
		UIPadding.PaddingBottom = UDim.new(0, padding.Y)
		UIPadding.Parent = guiElement
		return UIPadding
	end
	function utilities.UIListLayout(guiElement, fillDirection, padding)
		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = padding
		UIListLayout.FillDirection = fillDirection
		UIListLayout.Parent = guiElement
		return UIListLayout
	end
	function utilities.UIStroke(guiElement, thickness, color, transparency)
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Thickness = thickness
		UIStroke.Color = color
		UIStroke.Transparency = transparency
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Parent = guiElement
		return UIStroke
	end
	function utilities.UICorner(guiElement, cornerRadius)
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(if cornerRadius then 0 else 1, cornerRadius or 0)
		UICorner.Parent = guiElement
		return UICorner
	end
	function utilities.UISizeConstraint(guiElement, minSize, maxSize)
		local UISizeConstraint = Instance.new("UISizeConstraint")
		UISizeConstraint.MinSize = minSize or UISizeConstraint.MinSize
		UISizeConstraint.MaxSize = maxSize or UISizeConstraint.MaxSize
		UISizeConstraint.Parent = guiElement
		return UISizeConstraint
	end
	function utilities.applyTextStyle(textLabel)
		textLabel.FontFace = iris._config.TextFont
		textLabel.TextSize = iris._config.TextSize
		textLabel.TextColor3 = iris._config.TextColor
		textLabel.TextTransparency = iris._config.TextTransparency
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextYAlignment = Enum.TextYAlignment.Center
		textLabel.RichText = iris._config.RichText
		textLabel.TextWrapped = iris._config.TextWrapped
		textLabel.AutoLocalize = false
	end
	function utilities.applyInteractionHighlights(propertyPrefix, guiElement, properties, styleConfig)
		local isMouseDown = false
		utilities.applyMouseEnter(guiElement, function()
			properties[propertyPrefix .. "Color3"] = styleConfig.HoveredColor
			properties[propertyPrefix .. "Transparency"] = styleConfig.HoveredTransparency
			isMouseDown = false
		end)
		utilities.applyMouseLeave(guiElement, function()
			properties[propertyPrefix .. "Color3"] = styleConfig.Color
			properties[propertyPrefix .. "Transparency"] = styleConfig.Transparency
			isMouseDown = true
		end)
		utilities.applyInputBegan(guiElement, function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
				properties[propertyPrefix .. "Color3"] = styleConfig.ActiveColor
				properties[propertyPrefix .. "Transparency"] = styleConfig.ActiveTransparency
			end
		end)
		utilities.applyInputEnded(guiElement, function(inputEvent)
			if (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Gamepad1) and not isMouseDown then
				if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then
					properties[propertyPrefix .. "Color3"] = styleConfig.HoveredColor
					properties[propertyPrefix .. "Transparency"] = styleConfig.HoveredTransparency
				end
				if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
					properties[propertyPrefix .. "Color3"] = styleConfig.Color
					properties[propertyPrefix .. "Transparency"] = styleConfig.Transparency
				end
			end
		end)
		guiElement.SelectionImageObject = iris.SelectionImageObject
	end
	function utilities.applyInteractionHighlightsWithMultiHighlightee(propertyPrefix, guiElement, highlightTargets)
		local isMouseDown = false
		utilities.applyMouseEnter(guiElement, function()
			for index, highlightInfo in highlightTargets do
				highlightInfo[1][propertyPrefix .. "Color3"] = highlightInfo[2].HoveredColor
				highlightInfo[1][propertyPrefix .. "Transparency"] = highlightInfo[2].HoveredTransparency
				isMouseDown = false
			end
		end)
		utilities.applyMouseLeave(guiElement, function()
			for index, highlightInfo in highlightTargets do
				highlightInfo[1][propertyPrefix .. "Color3"] = highlightInfo[2].Color
				highlightInfo[1][propertyPrefix .. "Transparency"] = highlightInfo[2].Transparency
				isMouseDown = true
			end
		end)
		utilities.applyInputBegan(guiElement, function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
				for index, highlightInfo in highlightTargets do
					highlightInfo[1][propertyPrefix .. "Color3"] = highlightInfo[2].ActiveColor
					highlightInfo[1][propertyPrefix .. "Transparency"] = highlightInfo[2].ActiveTransparency
				end
			end
		end)
		utilities.applyInputEnded(guiElement, function(inputEvent)
			if (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Gamepad1) and not isMouseDown then
				for index, highlightInfo in highlightTargets do
					if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then
						highlightInfo[1][propertyPrefix .. "Color3"] = highlightInfo[2].HoveredColor
						highlightInfo[1][propertyPrefix .. "Transparency"] = highlightInfo[2].HoveredTransparency
					end
					if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
						highlightInfo[1][propertyPrefix .. "Color3"] = highlightInfo[2].Color
						highlightInfo[1][propertyPrefix .. "Transparency"] = highlightInfo[2].Transparency
					end
				end
			end
		end)
		guiElement.SelectionImageObject = iris.SelectionImageObject
	end
	function utilities.applyFrameStyle(frame, skipPadding, skipCorner)
		local frameBorderSize = iris._config.FrameBorderSize
		local frameRounding = iris._config.FrameRounding
		frame.BorderSizePixel = 0
		if frameBorderSize > 0 then
			utilities.UIStroke(frame, frameBorderSize, iris._config.BorderColor, iris._config.BorderTransparency)
		end
		if frameRounding > 0 and not skipCorner then
			utilities.UICorner(frame, frameRounding)
		end
		if not skipPadding then
			utilities.UIPadding(frame, iris._config.FramePadding)
		end
	end
	function utilities.applyButtonClick(button, callback)
		button.MouseButton1Click:Connect(function()
			callback()
		end)
	end
	function utilities.applyButtonDown(button, callback)
		button.MouseButton1Down:Connect(function(mouseX, mouseY)
			local offsetPosition = Vector2.new(mouseX, mouseY) - utilities.MouseOffset
			callback(offsetPosition.X, offsetPosition.Y)
		end)
	end
	function utilities.applyMouseEnter(guiElement, callback)
		guiElement.MouseEnter:Connect(function(mouseX, mouseY)
			local offsetPosition = Vector2.new(mouseX, mouseY) - utilities.MouseOffset
			callback(offsetPosition.X, offsetPosition.Y)
		end)
	end
	function utilities.applyMouseMoved(guiElement, callback)
		guiElement.MouseMoved:Connect(function(mouseX, mouseY)
			local offsetPosition = Vector2.new(mouseX, mouseY) - utilities.MouseOffset
			callback(offsetPosition.X, offsetPosition.Y)
		end)
	end
	function utilities.applyMouseLeave(guiElement, callback)
		guiElement.MouseLeave:Connect(function(mouseX, mouseY)
			local offsetPosition = Vector2.new(mouseX, mouseY) - utilities.MouseOffset
			callback(offsetPosition.X, offsetPosition.Y)
		end)
	end
	function utilities.applyInputBegan(guiElement, callback)
		guiElement.InputBegan:Connect(function(...)
			callback(...)
		end)
	end
	function utilities.applyInputEnded(guiElement, callback)
		guiElement.InputEnded:Connect(function(...)
			callback(...)
		end)
	end
	function utilities.discardState(widget)
		for index, stateObject in widget.state do
			stateObject.ConnectedWidgets[widget.ID] = nil
		end
	end
	function utilities.registerEvent(eventName, callback)
		local function registerConnection()
			table.insert(iris._connections, utilities.UserInputService[eventName]:Connect(callback))
		end
		table.insert(iris._initFunctions, registerConnection)
	end
	utilities.EVENTS = {
		hover = function(getGuiElement)
			return {
				Init = function(widget)
					local guiElement = getGuiElement(widget)
					utilities.applyMouseEnter(guiElement, function()
						widget.isHoveredEvent = true
					end)
					utilities.applyMouseLeave(guiElement, function()
						widget.isHoveredEvent = false
					end)
					widget.isHoveredEvent = false
				end,
				Get = function(widget)
					return widget.isHoveredEvent
				end
			}
		end,
		click = function(getGuiElement)
			return {
				Init = function(widget)
					local guiElement = getGuiElement(widget)
					widget.lastClickedTick = -1
					utilities.applyButtonClick(guiElement, function()
						widget.lastClickedTick = iris._cycleTick + 1
					end)
				end,
				Get = function(widget)
					return widget.lastClickedTick == iris._cycleTick
				end
			}
		end,
		rightClick = function(getGuiElement)
			return {
				Init = function(widget)
					local guiElement = getGuiElement(widget)
					widget.lastRightClickedTick = -1
					guiElement.MouseButton2Click:Connect(function()
						widget.lastRightClickedTick = iris._cycleTick + 1
					end)
				end,
				Get = function(widget)
					return widget.lastRightClickedTick == iris._cycleTick
				end
			}
		end,
		doubleClick = function(getGuiElement)
			return {
				Init = function(widget)
					local guiElement = getGuiElement(widget)
					widget.lastClickedTime = -1
					widget.lastClickedPosition = Vector2.zero
					widget.lastDoubleClickedTick = -1
					utilities.applyButtonDown(guiElement, function(mouseX, mouseY)
						local currentTime = utilities.getTime()
						if currentTime - widget.lastClickedTime < iris._config.MouseDoubleClickTime and (Vector2.new(mouseX, mouseY) - widget.lastClickedPosition).Magnitude < iris._config.MouseDoubleClickMaxDist then
							widget.lastDoubleClickedTick = iris._cycleTick + 1
						else
							widget.lastClickedTime = currentTime
							widget.lastClickedPosition = Vector2.new(mouseX, mouseY)
						end
					end)
				end,
				Get = function(widget)
					return widget.lastDoubleClickedTick == iris._cycleTick
				end
			}
		end,
		ctrlClick = function(getGuiElement)
			return {
				Init = function(widget)
					local guiElement = getGuiElement(widget)
					widget.lastCtrlClickedTick = -1
					utilities.applyButtonClick(guiElement, function()
						if utilities.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or utilities.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
							widget.lastCtrlClickedTick = iris._cycleTick + 1
						end
					end)
				end,
				Get = function(widget)
					return widget.lastCtrlClickedTick == iris._cycleTick
				end
			}
		end,
	}
	iris._utility = utilities
	require(script.Root)(iris, utilities)
	require(script.Window)(iris, utilities)
	require(script.Menu)(iris, utilities)
	require(script.Format)(iris, utilities)
	require(script.Text)(iris, utilities)
	require(script.Button)(iris, utilities)
	require(script.Checkbox)(iris, utilities)
	require(script.RadioButton)(iris, utilities)
	require(script.Image)(iris, utilities)
	require(script.Tree)(iris, utilities)
	require(script.Tab)(iris, utilities)
	require(script.Input)(iris, utilities)
	require(script.Combo)(iris, utilities)
	require(script.Plot)(iris, utilities)
	require(script.Table)(iris, utilities)
end
