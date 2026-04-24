-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local t = {
		Init = function(p1) end,
		Get = function(p12)
			return p12.lastNumberChangedTick == p1._cycleTick
		end
	}
	local function getValueByIndex(p1, p2, p3)
		if typeof(p1) == "number" then
			return p1
		else
			if typeof(p1) == "Vector2" then
				if p2 == 1 then
					return p1.X
				end
				if p2 == 2 then
					return p1.Y
				end
				return
			elseif typeof(p1) == "Vector3" then
				if p2 == 1 then
					return p1.X
				end
				if p2 == 2 then
					return p1.Y
				end
				if p2 == 3 then
					return p1.Z
				end
				return
			elseif typeof(p1) == "UDim" then
				if p2 == 1 then
					return p1.Scale
				end
				if p2 == 2 then
					return p1.Offset
				end
				return
			elseif typeof(p1) == "UDim2" then
				if p2 == 1 then
					return p1.X.Scale
				end
				if p2 == 2 then
					return p1.X.Offset
				end
				if p2 == 3 then
					return p1.Y.Scale
				end
				if p2 == 4 then
					return p1.Y.Offset
				end
				return
			elseif typeof(p1) == "Color3" then
				local instance = if p3.UseHSV then { p1:ToHSV() } else { p1.R, p1.G, p1.B }
				if p2 == 1 then
					return instance[1]
				end
				if p2 == 2 then
					return instance[2]
				end
				if p2 == 3 then
					return instance[3]
				end
				return
			elseif typeof(p1) == "Rect" then
				if p2 == 1 then
					return p1.Min.X
				end
				if p2 == 2 then
					return p1.Min.Y
				end
				if p2 == 3 then
					return p1.Max.X
				end
				if p2 == 4 then
					return p1.Max.Y
				end
			elseif typeof(p1) == "table" then
				return p1[p2]
			end
			error((("Incorrect datatype or value: %* %* %*."):format(p1, typeof(p1), p2)))
		end
	end
	local function updateValueByIndex(p1, p2, p3, p4)
		if typeof(p1) == "number" then
			return p3
		else
			if typeof(p1) == "Vector2" then
				if p2 == 1 then
					return Vector2.new(p3, p1.Y)
				end
				if p2 == 2 then
					return Vector2.new(p1.X, p3)
				end
				return
			elseif typeof(p1) == "Vector3" then
				if p2 == 1 then
					return Vector3.new(p3, p1.Y, p1.Z)
				end
				if p2 == 2 then
					return Vector3.new(p1.X, p3, p1.Z)
				end
				if p2 == 3 then
					return Vector3.new(p1.X, p1.Y, p3)
				end
				return
			elseif typeof(p1) == "UDim" then
				if p2 == 1 then
					return UDim.new(p3, p1.Offset)
				end
				if p2 == 2 then
					return UDim.new(p1.Scale, p3)
				end
				return
			elseif typeof(p1) == "UDim2" then
				if p2 == 1 then
					return UDim2.new(UDim.new(p3, p1.X.Offset), p1.Y)
				end
				if p2 == 2 then
					return UDim2.new(UDim.new(p1.X.Scale, p3), p1.Y)
				end
				if p2 == 3 then
					return UDim2.new(p1.X, UDim.new(p3, p1.Y.Offset))
				end
				if p2 == 4 then
					return UDim2.new(p1.X, UDim.new(p1.Y.Scale, p3))
				end
				return
			elseif typeof(p1) == "Rect" then
				if p2 == 1 then
					return Rect.new(Vector2.new(p3, p1.Min.Y), p1.Max)
				end
				if p2 == 2 then
					return Rect.new(Vector2.new(p1.Min.X, p3), p1.Max)
				end
				if p2 == 3 then
					return Rect.new(p1.Min, Vector2.new(p3, p1.Max.Y))
				end
				if p2 == 4 then
					return Rect.new(p1.Min, Vector2.new(p1.Max.X, p3))
				end
				return
			elseif typeof(p1) == "Color3" then
				if p4.UseHSV then
					local instance, instance2, var3 = p1:ToHSV()
					if p2 == 1 then
						return Color3.fromHSV(p3, instance2, var3)
					end
					if p2 == 2 then
						return Color3.fromHSV(instance, p3, var3)
					end
					if p2 == 3 then
						return Color3.fromHSV(instance, instance2, p3)
					end
				end
				if p2 == 1 then
					return Color3.new(p3, p1.G, p1.B)
				end
				if p2 == 2 then
					return Color3.new(p1.R, p3, p1.B)
				end
				if p2 == 3 then
					return Color3.new(p1.R, p1.G, p3)
				end
			else
				return
			end
			error((("Incorrect datatype or value %* %* %*."):format(p1, typeof(p1), p2)))
		end
	end
	local t2 = {
		Num = { 1 },
		Vector2 = { 1, 1 },
		Vector3 = { 1, 1, 1 },
		UDim = { 0.01, 1 },
		UDim2 = { 0.01, 1, 0.01, 1 },
		Color3 = { 1, 1, 1 },
		Color4 = { 1, 1, 1, 1 },
		Rect = { 1, 1, 1, 1 }
	}
	local t3 = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 0, 0 },
		UDim2 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}
	local t4 = {
		Num = { 100 },
		Vector2 = { 100, 100 },
		Vector3 = { 100, 100, 100 },
		UDim = { 1, 960 },
		UDim2 = { 1, 960, 1, 960 },
		Rect = { 960, 960, 960, 960 }
	}
	local t5 = {
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
	local t6 = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 3, 0 },
		UDim2 = { 3, 0, 3, 0 },
		Color3 = { 0, 0, 0 },
		Color4 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}
	local function generateAbstract(p12, p22, p3, p4)
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
				numberChanged = t,
				hovered = p2.EVENTS.hover(function(p1)
					return p1.Instance
				end)
			},
			GenerateState = function(p12)
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p4)
				end
				if p12.state.editingText == nil then
					p12.state.editingText = p1._widgetState(p12, "editingText", 0)
				end
			end,
			Update = function(p13)
				local instance = p13.Instance
				instance.TextLabel.Text = p13.arguments.Text or ("Input %*"):format(p22)
				local var3, var4, var5, var6, var7, var8, var9, var10, v11, var12, v13, v14, v15, v16, v17, v18, v19
				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						if not p13.arguments.Format then
							var3 = {}
							for i = 1, p3 do
								var4 = t6[p22][i]
								if p13.arguments.Increment then
									var5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
									var6 = if var5 == 0 then 1 else var5
									var7 = -math.log10(var6)
									var8 = math.ceil(var7)
									var9 = math.max(var4, var8, var4)
									var4 = var9
								end
								if p13.arguments.Max then
									var10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
									v11 = if var10 == 0 then 1 else var10
									var12 = -math.log10(v11)
									v13 = math.ceil(var12)
									v14 = math.max(var4, v13, var4)
									var4 = v14
								end
								if p13.arguments.Min then
									v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
									v16 = if v15 == 0 then 1 else v15
									v17 = -math.log10(v16)
									v18 = math.ceil(v17)
									v19 = math.max(var4, v18, var4)
									var4 = v19
								end
								if var4 > 0 then
									var3[i] = ("%%.%*f"):format(var4)
								else
									var3[i] = "%d"
								end
							end
							p13.arguments.Format = var3
							p13.arguments.Prefix = t5[p22]
						end
					else
						p13.arguments.Format = { p13.arguments.Format }
					end
				elseif not p13.arguments.Format then
					var3 = {}
					for i = 1, p3 do
						var4 = t6[p22][i]
						if p13.arguments.Increment then
							var5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							var6 = if var5 == 0 then 1 else var5
							var7 = -math.log10(var6)
							var8 = math.ceil(var7)
							var9 = math.max(var4, var8, var4)
							var4 = var9
						end
						if p13.arguments.Max then
							var10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
							v11 = if var10 == 0 then 1 else var10
							var12 = -math.log10(v11)
							v13 = math.ceil(var12)
							v14 = math.max(var4, v13, var4)
							var4 = v14
						end
						if p13.arguments.Min then
							v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
							v16 = if v15 == 0 then 1 else v15
							v17 = -math.log10(v16)
							v18 = math.ceil(v17)
							v19 = math.max(var4, v18, var4)
							var4 = v19
						end
						if var4 > 0 then
							var3[i] = ("%%.%*f"):format(var4)
						else
							var3[i] = "%d"
						end
					end
					p13.arguments.Format = var3
					p13.arguments.Prefix = t5[p22]
				end
				if p12 == "Input" and p22 == "Num" then
					instance.SubButton.Visible = not p13.arguments.NoButtons
					instance.AddButton.Visible = not p13.arguments.NoButtons
					instance.InputField1.Size = UDim2.new(UDim.new(p1._config.ContentWidth.Scale, p1._config.ContentWidth.Offset - if p13.arguments.NoButtons then 0 else 2 * p1._config.ItemInnerSpacing.X + 2 * (p1._config.TextSize + 2 * p1._config.FramePadding.Y)), p1._config.ContentHeight)
				end
				if p12 == "Slider" then
					for j = 1, p3 do
						local v21, var22, v23
						local GrabBar = instance:FindFirstChild("SliderField" .. tostring(j)).GrabBar
						v21 = p13.arguments.Increment and getValueByIndex(p13.arguments.Increment, j, p13.arguments) or t2[p22][j]
						var22 = p13.arguments.Min and getValueByIndex(p13.arguments.Min, j, p13.arguments) or t3[p22][j]
						v23 = p13.arguments.Max and getValueByIndex(p13.arguments.Max, j, p13.arguments) or t4[p22][j]
						GrabBar.Size = UDim2.fromScale(1 / math.floor((1 + v23 - var22) / v21), 1)
					end
					local var25 = #p1._postCycleCallbacks + 1
					local var26 = p1._cycleTick + 1
					p1._postCycleCallbacks[var25] = function()
						if var26 <= p1._cycleTick then
							if p13.lastCycleTick ~= -1 then
								p13.state.number.lastChangeTick = p1._cycleTick
								p1._widgets[("Slider%*"):format(p22)].UpdateState(p13)
							end
							p1._postCycleCallbacks[var25] = nil
						end
					end
				end
			end,
			Discard = function(p1)
				p1.Instance:Destroy()
				p2.discardState(p1)
			end
		}
	end
	local function focusLost(p12, p2, p3, p4)
		local instance = tonumber(p2.Text:match("-?%d*%.?%d*"))
		local number = p12.state.number
		if p4 == "Color4" and p3 == 4 then
			number = p12.state.transparency
		elseif p4 == "Color3" or p4 == "Color4" then
			number = p12.state.color
		end
		if instance ~= nil then
			if p4 == "Color3" or p4 == "Color4" and not p12.arguments.UseFloats then
				instance = instance / 255
			end
			if p12.arguments.Min ~= nil then
				instance = math.max(instance, getValueByIndex(p12.arguments.Min, p3, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				instance = math.min(instance, getValueByIndex(p12.arguments.Max, p3, p12.arguments))
			end
			if p12.arguments.Increment then
				local var6 = instance / getValueByIndex(p12.arguments.Increment, p3, p12.arguments)
				instance = math.round(var6) * getValueByIndex(p12.arguments.Increment, p3, p12.arguments)
			end
			number:set(updateValueByIndex(number.value, p3, instance, p12.arguments))
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end
		local var7 = getValueByIndex(number.value, p3, p12.arguments)
		if p4 == "Color3" or p4 == "Color4" and not p12.arguments.UseFloats then
			var7 = math.round(var7 * 255)
		end
		local var9 = p12.arguments.Format[p3] or p12.arguments.Format[1]
		if p12.arguments.Prefix then
			var9 = p12.arguments.Prefix[p3] .. var9
		end
		p2.Text = string.format(var9, var7)
		p12.state.editingText:set(0)
		p2:ReleaseFocus(true)
	end
	local function generateButtons(p12, p22, p3)
		local SubButton = p2.abstractButton.Generate(p12)
		SubButton.Name = "SubButton"
		SubButton.Size = UDim2.fromOffset(p1._config.TextSize + 2 * p1._config.FramePadding.Y, p1._config.TextSize)
		SubButton.Text = "-"
		SubButton.TextXAlignment = Enum.TextXAlignment.Center
		SubButton.ZIndex = 5
		SubButton.LayoutOrder = 5
		SubButton.Parent = p22
		p2.applyButtonClick(SubButton, function()
			local instance = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local var4 = p12.state.number.value - (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * if instance then 100 else 1
			if p12.arguments.Min ~= nil then
				var4 = math.max(var4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				var4 = math.min(var4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end
			p12.state.number:set(var4)
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end)
		local AddButton = p2.abstractButton.Generate(p12)
		AddButton.Name = "AddButton"
		AddButton.Size = UDim2.fromOffset(p1._config.TextSize + 2 * p1._config.FramePadding.Y, p1._config.TextSize)
		AddButton.Text = "+"
		AddButton.TextXAlignment = Enum.TextXAlignment.Center
		AddButton.ZIndex = 6
		AddButton.LayoutOrder = 6
		AddButton.Parent = p22
		p2.applyButtonClick(AddButton, function()
			local instance = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local var4 = p12.state.number.value + (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * if instance then 100 else 1
			if p12.arguments.Min ~= nil then
				var4 = math.max(var4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				var4 = math.min(var4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end
			p12.state.number:set(var4)
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end)
		return 2 * p1._config.ItemInnerSpacing.X + p3 * 2
	end
	local function generateField(p12, p22, p3, p4)
		local TextBox = Instance.new("TextBox")
		TextBox.Name = "InputField" .. tostring(p22)
		TextBox.AutomaticSize = Enum.AutomaticSize.Y
		TextBox.Size = UDim2.new(p3, p1._config.ContentHeight)
		TextBox.BackgroundColor3 = p1._config.FrameBgColor
		TextBox.BackgroundTransparency = p1._config.FrameBgTransparency
		TextBox.TextTruncate = Enum.TextTruncate.AtEnd
		TextBox.ClearTextOnFocus = false
		TextBox.ZIndex = p22
		TextBox.LayoutOrder = p22
		TextBox.ClipsDescendants = true
		p2.applyFrameStyle(TextBox)
		p2.applyTextStyle(TextBox)
		p2.UISizeConstraint(TextBox, Vector2.xAxis)
		TextBox.FocusLost:Connect(function()
			focusLost(p12, TextBox, p22, p4)
		end)
		TextBox.Focused:Connect(function()
			TextBox.CursorPosition = #TextBox.Text + 1
			TextBox.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		return TextBox
	end
	local function generateInputScalar(p12, p22, p3)
		return p2.extend(generateAbstract("Input", p12, p22, p3), {
			Generate = function(p13)
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Input" .. p12
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local instance2 = if p22 == 1 then generateButtons(p13, Frame, p1._config.TextSize + 2 * p1._config.FramePadding.Y) else 0
				local var4 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - instance2) / p22)
				local var6 = p1._config.ContentWidth - UDim.new(var4.Scale * (p22 - 1), var4.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + instance2)
				for i = 1, p22 do
					local var7
					var7 = if i == p22 then var6 else var4
					generateField(p13, i, var7, p12).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 7
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(p1)
				local instance = p1.Instance
				for i = 1, p22 do
					local instance2 = instance:FindFirstChild("InputField" .. tostring(i))
					local var3 = p1.arguments.Format[i] or p1.arguments.Format[1]
					if p1.arguments.Prefix then
						var3 = p1.arguments.Prefix[i] .. var3
					end
					instance2.Text = string.format(var3, getValueByIndex(p1.state.number.value, i, p1.arguments))
				end
			end
		})
	end
	local instance = 0
	local instance2 = false
	local var3 = nil
	local var4 = 0
	local var5 = ""
	local function updateActiveDrag()
		local X = p2.getMouseLocation().X
		local var12 = X - instance
		instance = X
		if instance2 == false then
		elseif var3 ~= nil then
			local number = var3.state.number
			if var5 == "Color3" or var5 == "Color4" then
				local var22 = var3
				number = var22.state.color
				if var4 == 4 then
					number = var22.state.transparency
				end
			end
			local var32 = var3.arguments.Increment and getValueByIndex(var3.arguments.Increment, var4, var3.arguments) or t2[var5][var4]
			local var52 = var32 * if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then 10 else 1
			local var7 = var52 * if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then 0.1 else 1
			local var9 = getValueByIndex(number.value, var4, var3.arguments) + var12 * (var7 * if var5 == "Color3" or var5 == "Color4" then 5 else 1)
			if var3.arguments.Min ~= nil then
				var9 = math.max(var9, getValueByIndex(var3.arguments.Min, var4, var3.arguments))
			end
			if var3.arguments.Max ~= nil then
				var9 = math.min(var9, getValueByIndex(var3.arguments.Max, var4, var3.arguments))
			end
			number:set(updateValueByIndex(number.value, var4, var9, var3.arguments))
			var3.lastNumberChangedTick = p1._cycleTick + 1
		end
	end
	local function DragMouseDown(p12, p22, p3, p4, p5)
		local instance = p2.getTime()
		local var32 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
		if instance - p12.lastClickedTime < p1._config.MouseDoubleClickTime and (Vector2.new(p4, p5) - p12.lastClickedPosition).Magnitude < p1._config.MouseDoubleClickMaxDist or var32 then
			p12.state.editingText:set(p3)
		else
			p12.lastClickedTime = instance
			p12.lastClickedPosition = Vector2.new(p4, p5)
			instance2 = true
			var3 = p12
			var4 = p3
			var5 = p22
			updateActiveDrag()
		end
	end
	p2.registerEvent("InputChanged", function()
		if p1._started then
			updateActiveDrag()
		end
	end)
	p2.registerEvent("InputEnded", function(p12)
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and instance2) then
			instance2 = false
			var3 = nil
			var4 = 0
		end
	end)
	local function generateField_2(p12, p22, p3, p4)
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "DragField" .. tostring(p22)
		TextButton.AutomaticSize = Enum.AutomaticSize.Y
		TextButton.Size = p3
		TextButton.BackgroundColor3 = p1._config.FrameBgColor
		TextButton.BackgroundTransparency = p1._config.FrameBgTransparency
		TextButton.Text = ""
		TextButton.AutoButtonColor = false
		TextButton.LayoutOrder = p22
		TextButton.ClipsDescendants = true
		p2.applyFrameStyle(TextButton)
		p2.applyTextStyle(TextButton)
		p2.UISizeConstraint(TextButton, Vector2.xAxis)
		TextButton.TextXAlignment = Enum.TextXAlignment.Center
		p2.applyInteractionHighlights("Background", TextButton, TextButton, {
			Color = p1._config.FrameBgColor,
			Transparency = p1._config.FrameBgTransparency,
			HoveredColor = p1._config.FrameBgHoveredColor,
			HoveredTransparency = p1._config.FrameBgHoveredTransparency,
			ActiveColor = p1._config.FrameBgActiveColor,
			ActiveTransparency = p1._config.FrameBgActiveTransparency
		})
		local InputField = Instance.new("TextBox")
		InputField.Name = "InputField"
		InputField.Size = UDim2.fromScale(1, 1)
		InputField.BackgroundTransparency = 1
		InputField.ClearTextOnFocus = false
		InputField.TextTruncate = Enum.TextTruncate.AtEnd
		InputField.ClipsDescendants = true
		InputField.Visible = false
		p2.applyFrameStyle(InputField, true)
		p2.applyTextStyle(InputField)
		InputField.Parent = TextButton
		InputField.FocusLost:Connect(function()
			focusLost(p12, InputField, p22, p4)
		end)
		InputField.Focused:Connect(function()
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		p2.applyButtonDown(TextButton, function(p1, p2)
			DragMouseDown(p12, p4, p22, p1, p2)
		end)
		return TextButton
	end
	local function generateDragScalar(p12, p22, p3)
		return p2.extend(generateAbstract("Drag", p12, p22, p3), {
			Generate = function(p13)
				p13.lastClickedTime = -1
				p13.lastClickedPosition = Vector2.zero
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Drag" .. p12
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local sum = 0
				local instance = p1._config.TextSize + 2 * p1._config.FramePadding.Y
				if p12 == "Color3" or p12 == "Color4" then
					sum = sum + (p1._config.ItemInnerSpacing.X + instance)
					local ColorBox = Instance.new("ImageLabel")
					ColorBox.Name = "ColorBox"
					ColorBox.Size = UDim2.fromOffset(instance, instance)
					ColorBox.BorderSizePixel = 0
					ColorBox.Image = p2.ICONS.ALPHA_BACKGROUND_TEXTURE
					ColorBox.ImageTransparency = 1
					ColorBox.LayoutOrder = 5
					p2.applyFrameStyle(ColorBox, true)
					ColorBox.Parent = Frame
				end
				local instance2 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - sum) / p22)
				local var4 = p1._config.ContentWidth - UDim.new(instance2.Scale * (p22 - 1), instance2.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + sum)
				for i = 1, p22 do
					local var5
					var5 = if i == p22 then UDim2.new(var4, p1._config.ContentHeight) else UDim2.new(instance2, p1._config.ContentHeight)
					generateField_2(p13, i, var5, p12).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 6
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(p13)
				local instance = p13.Instance
				for i = 1, p22 do
					local number = p13.state.number
					if p12 == "Color3" or p12 == "Color4" then
						number = p13.state.color
						if i == 4 then
							number = p13.state.transparency
						end
					end
					local instance2 = instance:FindFirstChild("DragField" .. tostring(i))
					local InputField = instance2.InputField
					local var3 = getValueByIndex(number.value, i, p13.arguments)
					if (p12 == "Color3" or p12 == "Color4") and not p13.arguments.UseFloats then
						var3 = math.round(var3 * 255)
					end
					local var5 = p13.arguments.Format[i] or p13.arguments.Format[1]
					if p13.arguments.Prefix then
						var5 = p13.arguments.Prefix[i] .. var5
					end
					instance2.Text = string.format(var5, var3)
					InputField.Text = tostring(var3)
					if p13.state.editingText.value == i then
						InputField.Visible = true
						InputField:CaptureFocus()
						instance2.TextTransparency = 1
					else
						InputField.Visible = false
						instance2.TextTransparency = p1._config.TextTransparency
					end
				end
				if p12 == "Color3" or p12 == "Color4" then
					local ColorBox = instance.ColorBox
					ColorBox.BackgroundColor3 = p13.state.color.value
					if p12 == "Color4" then
						ColorBox.ImageTransparency = 1 - p13.state.transparency.value
					end
				end
			end
		})
	end
	local function generateColorDragScalar(p12, ...)
		local t = { ... }
		return p2.extend(generateDragScalar(p12, if p12 == "Color4" then 4 else 3, t[1]), {
			Args = {
				Text = 1,
				UseFloats = 2,
				UseHSV = 3,
				Format = 4
			},
			Update = function(p13)
				local Text = p13.arguments.Text
				if not Text then
					Text = ("Drag %*"):format(p12)
				end
				p13.Instance.TextLabel.Text = Text
				local instance2, var3, var4, var5
				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						if not p13.arguments.Format then
							if p13.arguments.UseFloats then
								p13.arguments.Format = { "%.3f" }
							else
								p13.arguments.Format = { "%d" }
							end
							instance2 = p13.arguments
							var3 = t5
							var4 = p12
							var5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
							instance2.Prefix = t5[p12 .. var5]
						end
					else
						p13.arguments.Format = { p13.arguments.Format }
					end
				elseif not p13.arguments.Format then
					if p13.arguments.UseFloats then
						p13.arguments.Format = { "%.3f" }
					else
						p13.arguments.Format = { "%d" }
					end
					instance2 = p13.arguments
					var3 = t5
					var4 = p12
					var5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
					instance2.Prefix = t5[p12 .. var5]
				end
				p13.arguments.Min = { 0, 0, 0, 0 }
				p13.arguments.Max = { 1, 1, 1, 1 }
				p13.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 }
				if p13.state then
					p13.state.color.lastChangeTick = p1._cycleTick
					if p12 == "Color4" then
						p13.state.transparency.lastChangeTick = p1._cycleTick
					end
					p1._widgets[p13.type].UpdateState(p13)
				end
			end,
			GenerateState = function(p13)
				if p13.state.color == nil then
					p13.state.color = p1._widgetState(p13, "color", t[1])
				end
				if p12 == "Color4" and p13.state.transparency == nil then
					p13.state.transparency = p1._widgetState(p13, "transparency", t[2])
				end
				if p13.state.editingText == nil then
					p13.state.editingText = p1._widgetState(p13, "editingText", false)
				end
			end
		})
	end
	local var6 = false
	local var7 = nil
	local var8 = 0
	local var9 = ""
	local function updateActiveSlider()
		if var6 == false then
		elseif var7 ~= nil then
			local instance2 = var7.Instance:FindFirstChild("SliderField" .. tostring(var8))
			local var3 = var7.arguments.Increment and getValueByIndex(var7.arguments.Increment, var8, var7.arguments) or t2[var9][var8]
			local var4 = var7.arguments.Min and getValueByIndex(var7.arguments.Min, var8, var7.arguments) or t3[var9][var8]
			local var5 = var7.arguments.Max and getValueByIndex(var7.arguments.Max, var8, var7.arguments) or t4[var9][var8]
			local X = instance2.GrabBar.AbsoluteSize.X
			var7.state.number:set(updateValueByIndex(var7.state.number.value, var8, math.clamp(math.round((p2.getMouseLocation().X - (instance2.AbsolutePosition.X - p2.GuiOffset.X + X / 2)) / (instance2.AbsoluteSize.X - X) * math.floor((var5 - var4) / var3)) * var3 + var4, var4, var5), var7.arguments))
			var7.lastNumberChangedTick = p1._cycleTick + 1
		end
	end
	local function SliderMouseDown(p1, p22, p3)
		if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			p1.state.editingText:set(p3)
		else
			var6 = true
			var7 = p1
			var8 = p3
			var9 = p22
			updateActiveSlider()
		end
	end
	p2.registerEvent("InputChanged", function()
		if p1._started then
			updateActiveSlider()
		end
	end)
	p2.registerEvent("InputEnded", function(p12)
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and var6) then
			var6 = false
			var7 = nil
			var8 = 0
			var9 = ""
		end
	end)
	local function generateField_3(p12, p22, p3, p4)
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "SliderField" .. tostring(p22)
		TextButton.AutomaticSize = Enum.AutomaticSize.Y
		TextButton.Size = p3
		TextButton.BackgroundColor3 = p1._config.FrameBgColor
		TextButton.BackgroundTransparency = p1._config.FrameBgTransparency
		TextButton.Text = ""
		TextButton.AutoButtonColor = false
		TextButton.LayoutOrder = p22
		TextButton.ClipsDescendants = true
		p2.applyFrameStyle(TextButton)
		p2.applyTextStyle(TextButton)
		p2.UISizeConstraint(TextButton, Vector2.xAxis)
		local OverlayText = Instance.new("TextLabel")
		OverlayText.Name = "OverlayText"
		OverlayText.Size = UDim2.fromScale(1, 1)
		OverlayText.BackgroundTransparency = 1
		OverlayText.BorderSizePixel = 0
		OverlayText.ZIndex = 10
		OverlayText.ClipsDescendants = true
		p2.applyTextStyle(OverlayText)
		OverlayText.TextXAlignment = Enum.TextXAlignment.Center
		OverlayText.Parent = TextButton
		p2.applyInteractionHighlights("Background", TextButton, TextButton, {
			Color = p1._config.FrameBgColor,
			Transparency = p1._config.FrameBgTransparency,
			HoveredColor = p1._config.FrameBgHoveredColor,
			HoveredTransparency = p1._config.FrameBgHoveredTransparency,
			ActiveColor = p1._config.FrameBgActiveColor,
			ActiveTransparency = p1._config.FrameBgActiveTransparency
		})
		local InputField = Instance.new("TextBox")
		InputField.Name = "InputField"
		InputField.Size = UDim2.fromScale(1, 1)
		InputField.BackgroundTransparency = 1
		InputField.ClearTextOnFocus = false
		InputField.TextTruncate = Enum.TextTruncate.AtEnd
		InputField.ClipsDescendants = true
		InputField.Visible = false
		p2.applyFrameStyle(InputField, true)
		p2.applyTextStyle(InputField)
		InputField.Parent = TextButton
		InputField.FocusLost:Connect(function()
			focusLost(p12, InputField, p22, p4)
		end)
		InputField.Focused:Connect(function()
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		p2.applyButtonDown(TextButton, function()
			SliderMouseDown(p12, p4, p22)
		end)
		local GrabBar = Instance.new("Frame")
		GrabBar.Name = "GrabBar"
		GrabBar.AnchorPoint = Vector2.new(0.5, 0.5)
		GrabBar.Position = UDim2.fromScale(0, 0.5)
		GrabBar.BackgroundColor3 = p1._config.SliderGrabColor
		GrabBar.Transparency = p1._config.SliderGrabTransparency
		GrabBar.BorderSizePixel = 0
		GrabBar.ZIndex = 5
		p2.applyInteractionHighlights("Background", TextButton, GrabBar, {
			Color = p1._config.SliderGrabColor,
			Transparency = p1._config.SliderGrabTransparency,
			HoveredColor = p1._config.SliderGrabColor,
			HoveredTransparency = p1._config.SliderGrabTransparency,
			ActiveColor = p1._config.SliderGrabActiveColor,
			ActiveTransparency = p1._config.SliderGrabActiveTransparency
		})
		if p1._config.GrabRounding > 0 then
			p2.UICorner(GrabBar, p1._config.GrabRounding)
		end
		p2.UISizeConstraint(GrabBar, Vector2.new(p1._config.GrabMinSize, 0))
		GrabBar.Parent = TextButton
		return TextButton
	end
	local function generateSliderScalar(p12, p22, p3)
		return p2.extend(generateAbstract("Slider", p12, p22, p3), {
			Generate = function(p13)
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Slider" .. p12
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local instance = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1)) / p22)
				local var3 = p1._config.ContentWidth - UDim.new(instance.Scale * (p22 - 1), instance.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1))
				for i = 1, p22 do
					local var4
					var4 = if i == p22 then UDim2.new(var3, p1._config.ContentHeight) else UDim2.new(instance, p1._config.ContentHeight)
					generateField_3(p13, i, var4, p12).Parent = Frame
				end
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.LayoutOrder = 5
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame
				return Frame
			end,
			UpdateState = function(p1)
				local instance = p1.Instance
				for i = 1, p22 do
					local instance2 = instance:FindFirstChild("SliderField" .. tostring(i))
					local InputField = instance2.InputField
					local OverlayText = instance2.OverlayText
					local GrabBar = instance2.GrabBar
					local var3 = getValueByIndex(p1.state.number.value, i, p1.arguments)
					local var4 = p1.arguments.Format[i] or p1.arguments.Format[1]
					if p1.arguments.Prefix then
						var4 = p1.arguments.Prefix[i] .. var4
					end
					OverlayText.Text = string.format(var4, var3)
					InputField.Text = tostring(var3)
					local var5 = p1.arguments.Increment and getValueByIndex(p1.arguments.Increment, i, p1.arguments) or t2[p12][i]
					local var6 = p1.arguments.Min and getValueByIndex(p1.arguments.Min, i, p1.arguments) or t3[p12][i]
					local var7 = p1.arguments.Max and getValueByIndex(p1.arguments.Max, i, p1.arguments) or t4[p12][i]
					local X = instance2.AbsoluteSize.X
					local var8 = X - GrabBar.AbsoluteSize.X
					local var9 = math.floor((var7 - var6) / var5)
					GrabBar.Position = UDim2.fromScale(var8 / X * math.clamp(math.floor((var3 - var6) / (var7 - var6) * var9) / var9, 0, 1) + (1 - var8 / X) / 2, 0.5)
					if p1.state.editingText.value == i then
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
	local function generateEnumSliderScalar(p12, p22)
		local instance = generateSliderScalar("Enum", 1, p22.Value)
		local t = { string }
		for instance2, var3 in p12:GetEnumItems() do
			t[var3.Value] = var3.Name
		end
		return p2.extend(instance, {
			Args = {
				Text = 1
			},
			Update = function(p1)
				local instance = p1.Instance
				instance.TextLabel.Text = p1.arguments.Text or "Input Enum"
				p1.arguments.Increment = 1
				p1.arguments.Min = 0
				p1.arguments.Max = #p12:GetEnumItems() - 1
				local GrabBar = instance:FindFirstChild("SliderField1").GrabBar
				GrabBar.Size = UDim2.fromScale(1 / math.floor(#p12:GetEnumItems()), 1)
			end,
			GenerateState = function(p12)
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p22.Value)
				end
				if p12.state.enumItem == nil then
					p12.state.enumItem = p1._widgetState(p12, "enumItem", p22)
				end
				if p12.state.editingText == nil then
					p12.state.editingText = p1._widgetState(p12, "editingText", false)
				end
			end
		})
	end
	local var10 = generateInputScalar("Num", 1, 0)
	var10.Args.NoButtons = 6
	p1.WidgetConstructor("InputNum", var10)
	p1.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("DragNum", generateDragScalar("Num", 1, 0))
	p1.WidgetConstructor("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("DragUDim", generateDragScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)))
	p1.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0))
	p1.WidgetConstructor("SliderNum", generateSliderScalar("Num", 1, 0))
	p1.WidgetConstructor("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("InputText", {
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
				Init = function(p1)
					p1.lastTextChangedTick = 0
				end,
				Get = function(p12)
					return p12.lastTextChangedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_InputText = Instance.new("Frame")
			Iris_InputText.Name = "Iris_InputText"
			Iris_InputText.AutomaticSize = Enum.AutomaticSize.Y
			Iris_InputText.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_InputText.BackgroundTransparency = 1
			Iris_InputText.BorderSizePixel = 0
			p2.UIListLayout(Iris_InputText, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local InputField = Instance.new("TextBox")
			InputField.Name = "InputField"
			InputField.AutomaticSize = Enum.AutomaticSize.Y
			InputField.Size = UDim2.new(p1._config.ContentWidth, p1._config.ContentHeight)
			InputField.BackgroundColor3 = p1._config.FrameBgColor
			InputField.BackgroundTransparency = p1._config.FrameBgTransparency
			InputField.Text = ""
			InputField.TextYAlignment = Enum.TextYAlignment.Top
			InputField.PlaceholderColor3 = p1._config.TextDisabledColor
			InputField.ClearTextOnFocus = false
			InputField.ClipsDescendants = true
			p2.applyFrameStyle(InputField)
			p2.applyTextStyle(InputField)
			p2.UISizeConstraint(InputField, Vector2.xAxis)
			InputField.Parent = Iris_InputText
			InputField.FocusLost:Connect(function()
				p12.state.text:set(InputField.Text)
				p12.lastTextChangedTick = p1._cycleTick + 1
			end)
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.Size = UDim2.fromOffset(0, p1._config.TextSize + 2 * p1._config.FramePadding.Y)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_InputText
			return Iris_InputText
		end,
		GenerateState = function(p12)
			if p12.state.text == nil then
				p12.state.text = p1._widgetState(p12, "text", "")
			end
		end,
		Update = function(p1)
			local instance = p1.Instance
			local InputField = instance.InputField
			instance.TextLabel.Text = p1.arguments.Text or "Input Text"
			InputField.PlaceholderText = p1.arguments.TextHint or ""
			InputField.TextEditable = not p1.arguments.ReadOnly
			InputField.MultiLine = p1.arguments.MultiLine or false
		end,
		UpdateState = function(p1)
			p1.Instance.InputField.Text = p1.state.text.value
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end
