require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 6 ]]
	local t = {
		Init = function(p1) --[[ Line: 8 ]] end,
		Get = function(p12) --[[ Line: 9 | Upvalues: p1 (copy) ]]
			return p12.lastNumberChangedTick == p1._cycleTick
		end
	}
	local function getValueByIndex(p1, p2, p3) --[[ Line: 14 ]]
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
				local v1 = if p3.UseHSV then { p1:ToHSV() } else { p1.R, p1.G, p1.B }
				if p2 == 1 then
					return v1[1]
				end
				if p2 == 2 then
					return v1[2]
				end
				if p2 == 3 then
					return v1[3]
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
	local function updateValueByIndex(p1, p2, p3, p4) --[[ Line: 74 ]]
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
					local v1, v2, v3 = p1:ToHSV()
					if p2 == 1 then
						return Color3.fromHSV(p3, v2, v3)
					end
					if p2 == 2 then
						return Color3.fromHSV(v1, p3, v3)
					end
					if p2 == 3 then
						return Color3.fromHSV(v1, v2, p3)
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
	local function generateAbstract(p12, p22, p3, p4) --[[ Line: 194 | Upvalues: t (copy), p2 (copy), p1 (copy), t6 (copy), getValueByIndex (copy), t5 (copy), t2 (copy), t3 (copy), t4 (copy) ]]
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
				hovered = p2.EVENTS.hover(function(p1) --[[ Line: 207 ]]
					return p1.Instance
				end)
			},
			GenerateState = function(p12) --[[ Name: GenerateState | Line: 211 | Upvalues: p1 (ref), p4 (copy) ]]
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p4)
				end
				if p12.state.editingText == nil then
					p12.state.editingText = p1._widgetState(p12, "editingText", 0)
				end
			end,
			Update = function(p13) --[[ Name: Update | Line: 219 | Upvalues: p22 (copy), p3 (copy), t6 (ref), getValueByIndex (ref), t5 (ref), p12 (copy), p1 (ref), t2 (ref), t3 (ref), t4 (ref) ]]
				local v1 = p13.Instance
				v1.TextLabel.Text = p13.arguments.Text or ("Input %*"):format(p22)
				local v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19
				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						if not p13.arguments.Format then
							v3 = {}
							for i = 1, p3 do
								v4 = t6[p22][i]
								if p13.arguments.Increment then
									v5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
									v6 = if v5 == 0 then 1 else v5
									v7 = -math.log10(v6)
									v8 = math.ceil(v7)
									v9 = math.max(v4, v8, v4)
									v4 = v9
								end
								if p13.arguments.Max then
									v10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
									v11 = if v10 == 0 then 1 else v10
									v12 = -math.log10(v11)
									v13 = math.ceil(v12)
									v14 = math.max(v4, v13, v4)
									v4 = v14
								end
								if p13.arguments.Min then
									v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
									v16 = if v15 == 0 then 1 else v15
									v17 = -math.log10(v16)
									v18 = math.ceil(v17)
									v19 = math.max(v4, v18, v4)
									v4 = v19
								end
								if v4 > 0 then
									v3[i] = ("%%.%*f"):format(v4)
								else
									v3[i] = "%d"
								end
							end
							p13.arguments.Format = v3
							p13.arguments.Prefix = t5[p22]
						end
					else
						p13.arguments.Format = { p13.arguments.Format }
					end
				elseif not p13.arguments.Format then
					v3 = {}
					for i = 1, p3 do
						v4 = t6[p22][i]
						if p13.arguments.Increment then
							v5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							v6 = if v5 == 0 then 1 else v5
							v7 = -math.log10(v6)
							v8 = math.ceil(v7)
							v9 = math.max(v4, v8, v4)
							v4 = v9
						end
						if p13.arguments.Max then
							v10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
							v11 = if v10 == 0 then 1 else v10
							v12 = -math.log10(v11)
							v13 = math.ceil(v12)
							v14 = math.max(v4, v13, v4)
							v4 = v14
						end
						if p13.arguments.Min then
							v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
							v16 = if v15 == 0 then 1 else v15
							v17 = -math.log10(v16)
							v18 = math.ceil(v17)
							v19 = math.max(v4, v18, v4)
							v4 = v19
						end
						if v4 > 0 then
							v3[i] = ("%%.%*f"):format(v4)
						else
							v3[i] = "%d"
						end
					end
					p13.arguments.Format = v3
					p13.arguments.Prefix = t5[p22]
				end
				if p12 == "Input" and p22 == "Num" then
					v1.SubButton.Visible = not p13.arguments.NoButtons
					v1.AddButton.Visible = not p13.arguments.NoButtons
					v1.InputField1.Size = UDim2.new(UDim.new(p1._config.ContentWidth.Scale, p1._config.ContentWidth.Offset - if p13.arguments.NoButtons then 0 else 2 * p1._config.ItemInnerSpacing.X + 2 * (p1._config.TextSize + 2 * p1._config.FramePadding.Y)), p1._config.ContentHeight)
				end
				if p12 == "Slider" then
					for j = 1, p3 do
						local v21, v22, v23
						local GrabBar = v1:FindFirstChild("SliderField" .. tostring(j)).GrabBar
						v21 = p13.arguments.Increment and getValueByIndex(p13.arguments.Increment, j, p13.arguments) or t2[p22][j]
						v22 = p13.arguments.Min and getValueByIndex(p13.arguments.Min, j, p13.arguments) or t3[p22][j]
						v23 = p13.arguments.Max and getValueByIndex(p13.arguments.Max, j, p13.arguments) or t4[p22][j]
						GrabBar.Size = UDim2.fromScale(1 / math.floor((1 + v23 - v22) / v21), 1)
					end
					local v25 = #p1._postCycleCallbacks + 1
					local v26 = p1._cycleTick + 1
					p1._postCycleCallbacks[v25] = function() --[[ Line: 283 | Upvalues: p1 (ref), v26 (copy), p13 (copy), p22 (ref), v25 (copy) ]]
						if v26 <= p1._cycleTick then
							if p13.lastCycleTick ~= -1 then
								p13.state.number.lastChangeTick = p1._cycleTick
								p1._widgets[("Slider%*"):format(p22)].UpdateState(p13)
							end
							p1._postCycleCallbacks[v25] = nil
						end
					end
				end
			end,
			Discard = function(p1) --[[ Name: Discard | Line: 294 | Upvalues: p2 (ref) ]]
				p1.Instance:Destroy()
				p2.discardState(p1)
			end
		}
	end
	local function focusLost(p12, p2, p3, p4) --[[ Line: 301 | Upvalues: getValueByIndex (copy), updateValueByIndex (copy), p1 (copy) ]]
		local v1 = tonumber(p2.Text:match("-?%d*%.?%d*"))
		local number = p12.state.number
		if p4 == "Color4" and p3 == 4 then
			number = p12.state.transparency
		elseif p4 == "Color3" or p4 == "Color4" then
			number = p12.state.color
		end
		if v1 ~= nil then
			if p4 == "Color3" or p4 == "Color4" and not p12.arguments.UseFloats then
				v1 = v1 / 255
			end
			if p12.arguments.Min ~= nil then
				v1 = math.max(v1, getValueByIndex(p12.arguments.Min, p3, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				v1 = math.min(v1, getValueByIndex(p12.arguments.Max, p3, p12.arguments))
			end
			if p12.arguments.Increment then
				local v6 = v1 / getValueByIndex(p12.arguments.Increment, p3, p12.arguments)
				v1 = math.round(v6) * getValueByIndex(p12.arguments.Increment, p3, p12.arguments)
			end
			number:set(updateValueByIndex(number.value, p3, v1, p12.arguments))
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end
		local v7 = getValueByIndex(number.value, p3, p12.arguments)
		if p4 == "Color3" or p4 == "Color4" and not p12.arguments.UseFloats then
			v7 = math.round(v7 * 255)
		end
		local v9 = p12.arguments.Format[p3] or p12.arguments.Format[1]
		if p12.arguments.Prefix then
			v9 = p12.arguments.Prefix[p3] .. v9
		end
		p2.Text = string.format(v9, v7)
		p12.state.editingText:set(0)
		p2:ReleaseFocus(true)
	end
	local function generateButtons(p12, p22, p3) --[[ Line: 349 | Upvalues: p2 (copy), p1 (copy), getValueByIndex (copy) ]]
		local SubButton = p2.abstractButton.Generate(p12)
		SubButton.Name = "SubButton"
		SubButton.Size = UDim2.fromOffset(p1._config.TextSize + 2 * p1._config.FramePadding.Y, p1._config.TextSize)
		SubButton.Text = "-"
		SubButton.TextXAlignment = Enum.TextXAlignment.Center
		SubButton.ZIndex = 5
		SubButton.LayoutOrder = 5
		SubButton.Parent = p22
		p2.applyButtonClick(SubButton, function() --[[ Line: 359 | Upvalues: p2 (ref), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
			local v1 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v4 = p12.state.number.value - (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * if v1 then 100 else 1
			if p12.arguments.Min ~= nil then
				v4 = math.max(v4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				v4 = math.min(v4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end
			p12.state.number:set(v4)
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
		p2.applyButtonClick(AddButton, function() --[[ Line: 382 | Upvalues: p2 (ref), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
			local v1 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v4 = p12.state.number.value + (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * if v1 then 100 else 1
			if p12.arguments.Min ~= nil then
				v4 = math.max(v4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end
			if p12.arguments.Max ~= nil then
				v4 = math.min(v4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end
			p12.state.number:set(v4)
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end)
		return 2 * p1._config.ItemInnerSpacing.X + p3 * 2
	end
	local function generateField(p12, p22, p3, p4) --[[ Line: 399 | Upvalues: p1 (copy), p2 (copy), focusLost (copy) ]]
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
		TextBox.FocusLost:Connect(function() --[[ Line: 416 | Upvalues: focusLost (ref), p12 (copy), TextBox (copy), p22 (copy), p4 (copy) ]]
			focusLost(p12, TextBox, p22, p4)
		end)
		TextBox.Focused:Connect(function() --[[ Line: 420 | Upvalues: TextBox (copy), p12 (copy), p22 (copy) ]]
			TextBox.CursorPosition = #TextBox.Text + 1
			TextBox.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		return TextBox
	end
	local function generateInputScalar(p12, p22, p3) --[[ Line: 431 | Upvalues: generateAbstract (copy), p2 (copy), p1 (copy), generateButtons (copy), generateField (copy), getValueByIndex (copy) ]]
		return p2.extend(generateAbstract("Input", p12, p22, p3), {
			Generate = function(p13) --[[ Name: Generate | Line: 435 | Upvalues: p12 (copy), p1 (ref), p2 (ref), p22 (copy), generateButtons (ref), generateField (ref) ]]
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Input" .. p12
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local v2 = if p22 == 1 then generateButtons(p13, Frame, p1._config.TextSize + 2 * p1._config.FramePadding.Y) else 0
				local v4 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - v2) / p22)
				local v6 = p1._config.ContentWidth - UDim.new(v4.Scale * (p22 - 1), v4.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + v2)
				for i = 1, p22 do
					local v7
					v7 = if i == p22 then v6 else v4
					generateField(p13, i, v7, p12).Parent = Frame
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
			UpdateState = function(p1) --[[ Name: UpdateState | Line: 478 | Upvalues: p22 (copy), getValueByIndex (ref) ]]
				local v1 = p1.Instance
				for i = 1, p22 do
					local v2 = v1:FindFirstChild("InputField" .. tostring(i))
					local v3 = p1.arguments.Format[i] or p1.arguments.Format[1]
					if p1.arguments.Prefix then
						v3 = p1.arguments.Prefix[i] .. v3
					end
					v2.Text = string.format(v3, getValueByIndex(p1.state.number.value, i, p1.arguments))
				end
			end
		})
	end
	local v1 = 0
	local v2 = false
	local v3 = nil
	local v4 = 0
	local v5 = ""
	local function updateActiveDrag() --[[ Line: 506 | Upvalues: p2 (copy), v1 (ref), v2 (ref), v3 (ref), v5 (ref), v4 (ref), getValueByIndex (copy), t2 (copy), updateValueByIndex (copy), p1 (copy) ]]
		local X = p2.getMouseLocation().X
		local v12 = X - v1
		v1 = X
		if v2 == false then
		elseif v3 ~= nil then
			local number = v3.state.number
			if v5 == "Color3" or v5 == "Color4" then
				local v22 = v3
				number = v22.state.color
				if v4 == 4 then
					number = v22.state.transparency
				end
			end
			local v32 = v3.arguments.Increment and getValueByIndex(v3.arguments.Increment, v4, v3.arguments) or t2[v5][v4]
			local v52 = v32 * if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then 10 else 1
			local v7 = v52 * if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then 0.1 else 1
			local v9 = getValueByIndex(number.value, v4, v3.arguments) + v12 * (v7 * if v5 == "Color3" or v5 == "Color4" then 5 else 1)
			if v3.arguments.Min ~= nil then
				v9 = math.max(v9, getValueByIndex(v3.arguments.Min, v4, v3.arguments))
			end
			if v3.arguments.Max ~= nil then
				v9 = math.min(v9, getValueByIndex(v3.arguments.Max, v4, v3.arguments))
			end
			number:set(updateValueByIndex(number.value, v4, v9, v3.arguments))
			v3.lastNumberChangedTick = p1._cycleTick + 1
		end
	end
	local function DragMouseDown(p12, p22, p3, p4, p5) --[[ Line: 546 | Upvalues: p2 (copy), p1 (copy), v2 (ref), v3 (ref), v4 (ref), v5 (ref), updateActiveDrag (copy) ]]
		local v1 = p2.getTime()
		local v32 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
		if v1 - p12.lastClickedTime < p1._config.MouseDoubleClickTime and (Vector2.new(p4, p5) - p12.lastClickedPosition).Magnitude < p1._config.MouseDoubleClickMaxDist or v32 then
			p12.state.editingText:set(p3)
		else
			p12.lastClickedTime = v1
			p12.lastClickedPosition = Vector2.new(p4, p5)
			v2 = true
			v3 = p12
			v4 = p3
			v5 = p22
			updateActiveDrag()
		end
	end
	p2.registerEvent("InputChanged", function() --[[ Line: 564 | Upvalues: p1 (copy), updateActiveDrag (copy) ]]
		if p1._started then
			updateActiveDrag()
		end
	end)
	p2.registerEvent("InputEnded", function(p12) --[[ Line: 571 | Upvalues: p1 (copy), v2 (ref), v3 (ref), v4 (ref) ]]
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and v2) then
			v2 = false
			v3 = nil
			v4 = 0
		end
	end)
	local function generateField_2(p12, p22, p3, p4) --[[ Line: 582 | Upvalues: p1 (copy), p2 (copy), focusLost (copy), DragMouseDown (copy) ]]
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
		InputField.FocusLost:Connect(function() --[[ Line: 623 | Upvalues: focusLost (ref), p12 (copy), InputField (copy), p22 (copy), p4 (copy) ]]
			focusLost(p12, InputField, p22, p4)
		end)
		InputField.Focused:Connect(function() --[[ Line: 627 | Upvalues: InputField (copy), p12 (copy), p22 (copy) ]]
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		p2.applyButtonDown(TextButton, function(p1, p2) --[[ Line: 635 | Upvalues: DragMouseDown (ref), p12 (copy), p4 (copy), p22 (copy) ]]
			DragMouseDown(p12, p4, p22, p1, p2)
		end)
		return TextButton
	end
	local function generateDragScalar(p12, p22, p3) --[[ Line: 642 | Upvalues: generateAbstract (copy), p2 (copy), p1 (copy), generateField_2 (copy), getValueByIndex (copy) ]]
		return p2.extend(generateAbstract("Drag", p12, p22, p3), {
			Generate = function(p13) --[[ Name: Generate | Line: 646 | Upvalues: p12 (copy), p1 (ref), p2 (ref), p22 (copy), generateField_2 (ref) ]]
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
				local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
				if p12 == "Color3" or p12 == "Color4" then
					sum = sum + (p1._config.ItemInnerSpacing.X + v1)
					local ColorBox = Instance.new("ImageLabel")
					ColorBox.Name = "ColorBox"
					ColorBox.Size = UDim2.fromOffset(v1, v1)
					ColorBox.BorderSizePixel = 0
					ColorBox.Image = p2.ICONS.ALPHA_BACKGROUND_TEXTURE
					ColorBox.ImageTransparency = 1
					ColorBox.LayoutOrder = 5
					p2.applyFrameStyle(ColorBox, true)
					ColorBox.Parent = Frame
				end
				local v2 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - sum) / p22)
				local v4 = p1._config.ContentWidth - UDim.new(v2.Scale * (p22 - 1), v2.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + sum)
				for i = 1, p22 do
					local v5
					v5 = if i == p22 then UDim2.new(v4, p1._config.ContentHeight) else UDim2.new(v2, p1._config.ContentHeight)
					generateField_2(p13, i, v5, p12).Parent = Frame
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
			UpdateState = function(p13) --[[ Name: UpdateState | Line: 703 | Upvalues: p22 (copy), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
				local v1 = p13.Instance
				for i = 1, p22 do
					local number = p13.state.number
					if p12 == "Color3" or p12 == "Color4" then
						number = p13.state.color
						if i == 4 then
							number = p13.state.transparency
						end
					end
					local v2 = v1:FindFirstChild("DragField" .. tostring(i))
					local InputField = v2.InputField
					local v3 = getValueByIndex(number.value, i, p13.arguments)
					if (p12 == "Color3" or p12 == "Color4") and not p13.arguments.UseFloats then
						v3 = math.round(v3 * 255)
					end
					local v5 = p13.arguments.Format[i] or p13.arguments.Format[1]
					if p13.arguments.Prefix then
						v5 = p13.arguments.Prefix[i] .. v5
					end
					v2.Text = string.format(v5, v3)
					InputField.Text = tostring(v3)
					if p13.state.editingText.value == i then
						InputField.Visible = true
						InputField:CaptureFocus()
						v2.TextTransparency = 1
					else
						InputField.Visible = false
						v2.TextTransparency = p1._config.TextTransparency
					end
				end
				if p12 == "Color3" or p12 == "Color4" then
					local ColorBox = v1.ColorBox
					ColorBox.BackgroundColor3 = p13.state.color.value
					if p12 == "Color4" then
						ColorBox.ImageTransparency = 1 - p13.state.transparency.value
					end
				end
			end
		})
	end
	local function generateColorDragScalar(p12, ...) --[[ Line: 752 | Upvalues: generateDragScalar (ref), p2 (copy), t5 (copy), p1 (copy) ]]
		local t = { ... }
		return p2.extend(generateDragScalar(p12, if p12 == "Color4" then 4 else 3, t[1]), {
			Args = {
				Text = 1,
				UseFloats = 2,
				UseHSV = 3,
				Format = 4
			},
			Update = function(p13) --[[ Name: Update | Line: 763 | Upvalues: p12 (copy), t5 (ref), p1 (ref) ]]
				local Text = p13.arguments.Text
				if not Text then
					Text = ("Drag %*"):format(p12)
				end
				p13.Instance.TextLabel.Text = Text
				local v2, v3, v4, v5
				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						if not p13.arguments.Format then
							if p13.arguments.UseFloats then
								p13.arguments.Format = { "%.3f" }
							else
								p13.arguments.Format = { "%d" }
							end
							v2 = p13.arguments
							v3 = t5
							v4 = p12
							v5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
							v2.Prefix = t5[p12 .. v5]
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
					v2 = p13.arguments
					v3 = t5
					v4 = p12
					v5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
					v2.Prefix = t5[p12 .. v5]
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
			GenerateState = function(p13) --[[ Name: GenerateState | Line: 794 | Upvalues: p1 (ref), t (copy), p12 (copy) ]]
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
	local v6 = false
	local v7 = nil
	local v8 = 0
	local v9 = ""
	local function updateActiveSlider() --[[ Line: 822 | Upvalues: v6 (ref), v7 (ref), v8 (ref), getValueByIndex (copy), t2 (copy), v9 (ref), t3 (copy), t4 (copy), p2 (copy), updateValueByIndex (copy), p1 (copy) ]]
		if v6 == false then
		elseif v7 ~= nil then
			local v2 = v7.Instance:FindFirstChild("SliderField" .. tostring(v8))
			local v3 = v7.arguments.Increment and getValueByIndex(v7.arguments.Increment, v8, v7.arguments) or t2[v9][v8]
			local v4 = v7.arguments.Min and getValueByIndex(v7.arguments.Min, v8, v7.arguments) or t3[v9][v8]
			local v5 = v7.arguments.Max and getValueByIndex(v7.arguments.Max, v8, v7.arguments) or t4[v9][v8]
			local X = v2.GrabBar.AbsoluteSize.X
			v7.state.number:set(updateValueByIndex(v7.state.number.value, v8, math.clamp(math.round((p2.getMouseLocation().X - (v2.AbsolutePosition.X - p2.GuiOffset.X + X / 2)) / (v2.AbsoluteSize.X - X) * math.floor((v5 - v4) / v3)) * v3 + v4, v4, v5), v7.arguments))
			v7.lastNumberChangedTick = p1._cycleTick + 1
		end
	end
	local function SliderMouseDown(p1, p22, p3) --[[ Line: 848 | Upvalues: p2 (copy), v6 (ref), v7 (ref), v8 (ref), v9 (ref), updateActiveSlider (copy) ]]
		if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			p1.state.editingText:set(p3)
		else
			v6 = true
			v7 = p1
			v8 = p3
			v9 = p22
			updateActiveSlider()
		end
	end
	p2.registerEvent("InputChanged", function() --[[ Line: 861 | Upvalues: p1 (copy), updateActiveSlider (copy) ]]
		if p1._started then
			updateActiveSlider()
		end
	end)
	p2.registerEvent("InputEnded", function(p12) --[[ Line: 868 | Upvalues: p1 (copy), v6 (ref), v7 (ref), v8 (ref), v9 (ref) ]]
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and v6) then
			v6 = false
			v7 = nil
			v8 = 0
			v9 = ""
		end
	end)
	local function generateField_3(p12, p22, p3, p4) --[[ Line: 880 | Upvalues: p1 (copy), p2 (copy), focusLost (copy), SliderMouseDown (copy) ]]
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
		InputField.FocusLost:Connect(function() --[[ Line: 933 | Upvalues: focusLost (ref), p12 (copy), InputField (copy), p22 (copy), p4 (copy) ]]
			focusLost(p12, InputField, p22, p4)
		end)
		InputField.Focused:Connect(function() --[[ Line: 937 | Upvalues: InputField (copy), p12 (copy), p22 (copy) ]]
			InputField.CursorPosition = #InputField.Text + 1
			InputField.SelectionStart = 1
			p12.state.editingText:set(p22)
		end)
		p2.applyButtonDown(TextButton, function() --[[ Line: 945 | Upvalues: SliderMouseDown (ref), p12 (copy), p4 (copy), p22 (copy) ]]
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
	local function generateSliderScalar(p12, p22, p3) --[[ Line: 978 | Upvalues: generateAbstract (copy), p2 (copy), p1 (copy), generateField_3 (copy), getValueByIndex (copy), t2 (copy), t3 (copy), t4 (copy) ]]
		return p2.extend(generateAbstract("Slider", p12, p22, p3), {
			Generate = function(p13) --[[ Name: Generate | Line: 982 | Upvalues: p12 (copy), p1 (ref), p2 (ref), p22 (copy), generateField_3 (ref) ]]
				local Frame = Instance.new("Frame")
				Frame.Name = "Iris_Slider" .. p12
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				Frame.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local v1 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1)) / p22)
				local v3 = p1._config.ContentWidth - UDim.new(v1.Scale * (p22 - 1), v1.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1))
				for i = 1, p22 do
					local v4
					v4 = if i == p22 then UDim2.new(v3, p1._config.ContentHeight) else UDim2.new(v1, p1._config.ContentHeight)
					generateField_3(p13, i, v4, p12).Parent = Frame
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
			UpdateState = function(p1) --[[ Name: UpdateState | Line: 1016 | Upvalues: p22 (copy), getValueByIndex (ref), t2 (ref), p12 (copy), t3 (ref), t4 (ref) ]]
				local v1 = p1.Instance
				for i = 1, p22 do
					local v2 = v1:FindFirstChild("SliderField" .. tostring(i))
					local InputField = v2.InputField
					local OverlayText = v2.OverlayText
					local GrabBar = v2.GrabBar
					local v3 = getValueByIndex(p1.state.number.value, i, p1.arguments)
					local v4 = p1.arguments.Format[i] or p1.arguments.Format[1]
					if p1.arguments.Prefix then
						v4 = p1.arguments.Prefix[i] .. v4
					end
					OverlayText.Text = string.format(v4, v3)
					InputField.Text = tostring(v3)
					local v5 = p1.arguments.Increment and getValueByIndex(p1.arguments.Increment, i, p1.arguments) or t2[p12][i]
					local v6 = p1.arguments.Min and getValueByIndex(p1.arguments.Min, i, p1.arguments) or t3[p12][i]
					local v7 = p1.arguments.Max and getValueByIndex(p1.arguments.Max, i, p1.arguments) or t4[p12][i]
					local X = v2.AbsoluteSize.X
					local v8 = X - GrabBar.AbsoluteSize.X
					local v9 = math.floor((v7 - v6) / v5)
					GrabBar.Position = UDim2.fromScale(v8 / X * math.clamp(math.floor((v3 - v6) / (v7 - v6) * v9) / v9, 0, 1) + (1 - v8 / X) / 2, 0.5)
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
	local function generateEnumSliderScalar(p12, p22) --[[ Line: 1062 | Upvalues: generateSliderScalar (ref), p2 (copy), p1 (copy) ]]
		local v1 = generateSliderScalar("Enum", 1, p22.Value)
		local t = { string }
		for v2, v3 in p12:GetEnumItems() do
			t[v3.Value] = v3.Name
		end
		return p2.extend(v1, {
			Args = {
				Text = 1
			},
			Update = function(p1) --[[ Name: Update | Line: 1074 | Upvalues: p12 (copy) ]]
				local v1 = p1.Instance
				v1.TextLabel.Text = p1.arguments.Text or "Input Enum"
				p1.arguments.Increment = 1
				p1.arguments.Min = 0
				p1.arguments.Max = #p12:GetEnumItems() - 1
				local GrabBar = v1:FindFirstChild("SliderField1").GrabBar
				GrabBar.Size = UDim2.fromScale(1 / math.floor(#p12:GetEnumItems()), 1)
			end,
			GenerateState = function(p12) --[[ Name: GenerateState | Line: 1090 | Upvalues: p1 (ref), p22 (copy) ]]
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
	local v10 = generateInputScalar("Num", 1, 0)
	v10.Args.NoButtons = 6
	p1.WidgetConstructor("InputNum", v10)
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
				Init = function(p1) --[[ Line: 1146 ]]
					p1.lastTextChangedTick = 0
				end,
				Get = function(p12) --[[ Line: 1149 | Upvalues: p1 (copy) ]]
					return p12.lastTextChangedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 1153 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Name: Generate | Line: 1157 | Upvalues: p1 (copy), p2 (copy) ]]
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
			InputField.FocusLost:Connect(function() --[[ Line: 1185 | Upvalues: p12 (copy), InputField (copy), p1 (ref) ]]
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
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 1206 | Upvalues: p1 (copy) ]]
			if p12.state.text == nil then
				p12.state.text = p1._widgetState(p12, "text", "")
			end
		end,
		Update = function(p1) --[[ Name: Update | Line: 1211 ]]
			local v1 = p1.Instance
			local InputField = v1.InputField
			v1.TextLabel.Text = p1.arguments.Text or "Input Text"
			InputField.PlaceholderText = p1.arguments.TextHint or ""
			InputField.TextEditable = not p1.arguments.ReadOnly
			InputField.MultiLine = p1.arguments.MultiLine or false
		end,
		UpdateState = function(p1) --[[ Name: UpdateState | Line: 1221 ]]
			p1.Instance.InputField.Text = p1.state.text.value
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 1227 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end