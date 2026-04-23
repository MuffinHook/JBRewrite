require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 32 ]]
	local t = {}
	local t2 = {}
	local v1 = false
	local v2 = nil
	local v3 = 0
	local v4 = -1
	local v5 = -1
	local v6 = 0
	local function CalculateMinColumnWidth(p12, p2) --[[ Line: 42 | Upvalues: p1 (copy) ]]
		local v1 = 0
		for v2, v3 in p12._cellInstances do
			for v4, v5 in v3[p2]:GetChildren() do
				if v5:IsA("GuiObject") then
					v1 = math.max(v1, v5.AbsoluteSize.X)
				end
			end
		end
		p12._minWidths[p2] = v1 + 2 * p1._config.CellPadding.X
	end
	table.insert(p1._postCycleCallbacks, function() --[[ Line: 56 | Upvalues: t (copy), p1 (copy), t2 (copy), CalculateMinColumnWidth (copy) ]]
		for v1, v2 in t do
			for v3, v4 in v2._rowCycles do
				if v4 < p1._cycleTick - 1 then
					local v5 = v2._rowInstances[v3]
					local v6 = v2._rowBorders[v3 - 1]
					if v5 ~= nil then
						v5:Destroy()
					end
					if v6 ~= nil then
						v6:Destroy()
					end
					v2._rowInstances[v3] = nil
					v2._rowBorders[v3 - 1] = nil
					v2._cellInstances[v3] = nil
					v2._rowCycles[v3] = nil
				end
			end
			v2._rowIndex = 1
			v2._columnIndex = 1
			v2.Instance.BorderContainer.Size = UDim2.new(1, 0, 0, v2._rowContainer.AbsoluteSize.Y)
			v2._columnBorders[0].Size = UDim2.fromOffset(5, v2._rowContainer.AbsoluteSize.Y)
		end
		for v7, v8 in t2 do
			local v9 = false
			for v10, v11 in v8 do
				CalculateMinColumnWidth(v7, v10)
				v9 = true
			end
			if v9 then
				table.clear(v8)
				p1._widgets.Table.UpdateState(v7)
			end
		end
	end)
	local function UpdateActiveColumn() --[[ Line: 98 | Upvalues: v1 (ref), v2 (ref), p1 (copy), v4 (ref), v3 (ref), v5 (ref), p2 (copy), v6 (ref) ]]
		if v1 ~= false and v2 ~= nil then
			local widths = v2.state.widths
			local NumColumns = v2.arguments.NumColumns
			local v12 = v2.Instance
			local BorderContainer = v12.BorderContainer
			local v22 = 2 * p1._config.CellPadding.X
			if v4 == -1 then
				v4 = widths.value[v3]
				if v4 == 0 then
					v4 = v22 / v12.AbsoluteSize.X
				end
				v5 = widths.value[v3 + 1] or -1
				if v5 == 0 then
					v5 = v22 / v12.AbsoluteSize.X
				end
			end
			local X = v12.AbsolutePosition.X
			local v32 = if v3 == 1 then 0 else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(v3 - 1))).AbsolutePosition.X + 3 - X)
			local v62 = if NumColumns - 1 <= v3 then v12.AbsoluteSize.X else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(v3 + 1))).AbsolutePosition.X + 3 - X)
			local v9 = X - p2.GuiOffset.X
			local X_2 = p2.getMouseLocation().X
			local v10 = math.clamp(X_2, v32 + v9 + v22, v62 + v9 - v22) - v6
			local v11 = v4 / (v6 - v9 - v32)
			if v2.arguments.FixedWidth then
				widths.value[v3] = math.clamp(math.round(v4 + v10), v22, v12.AbsoluteSize.X - v32)
			else
				local v16 = v11 * v10
				widths.value[v3] = math.clamp(v4 + v16, 0, (v62 - v32 - v22) / v12.AbsoluteSize.X)
				if v3 < NumColumns then
					widths.value[v3 + 1] = math.clamp(v5 - v16, 0, 1)
				end
			end
			widths:set(widths.value, true)
		end
	end
	local function ColumnMouseDown(p1, p22) --[[ Line: 154 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), p2 (copy) ]]
		v1 = true
		v2 = p1
		v3 = p22
		v4 = -1
		v5 = -1
		v6 = p2.getMouseLocation().X
	end
	p2.registerEvent("InputChanged", function() --[[ Line: 163 | Upvalues: p1 (copy), UpdateActiveColumn (copy) ]]
		if p1._started then
			UpdateActiveColumn()
		end
	end)
	p2.registerEvent("InputEnded", function(p12) --[[ Line: 170 | Upvalues: p1 (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and v1) then
			v1 = false
			v2 = nil
			v3 = 0
			v4 = -1
			v5 = -1
			v6 = 0
		end
	end)
	local function GenerateCell(p12, p22, p3, p4) --[[ Line: 184 | Upvalues: p2 (copy), p1 (copy) ]]
		local v1
		if p4 then
			local TextButton = Instance.new("TextButton")
			TextButton.Text = ""
			TextButton.AutoButtonColor = false
			v1 = TextButton
		else
			v1 = Instance.new("Frame")
		end
		v1.Name = ("Cell_%*"):format(p22)
		v1.AutomaticSize = Enum.AutomaticSize.Y
		v1.Size = UDim2.new(p3, UDim.new())
		v1.BackgroundTransparency = 1
		v1.ZIndex = p22
		v1.LayoutOrder = p22
		v1.ClipsDescendants = true
		if p4 then
			p2.applyInteractionHighlights("Background", v1, v1, {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderActiveColor,
				ActiveTransparency = p1._config.HeaderActiveTransparency
			})
		end
		p2.UIPadding(v1, p1._config.CellPadding)
		p2.UIListLayout(v1, Enum.FillDirection.Vertical, UDim.new())
		p2.UISizeConstraint(v1, Vector2.new(2 * p1._config.CellPadding.X, 0))
		return v1
	end
	local function GenerateColumnBorder(p12, p22, p3) --[[ Line: 219 | Upvalues: p1 (copy), p2 (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
		local ImageButton = Instance.new("ImageButton")
		ImageButton.Name = ("Border_%*"):format(p22)
		ImageButton.Size = UDim2.new(0, 5, 1, 0)
		ImageButton.BackgroundTransparency = 1
		ImageButton.Image = ""
		ImageButton.ImageTransparency = 1
		ImageButton.AutoButtonColor = false
		ImageButton.ZIndex = p22
		ImageButton.LayoutOrder = p22 * 2
		local v12 = if p22 == p12.arguments.NumColumns then 3 else 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.Size = UDim2.new(0, 1, 1, 0)
		Line.Position = UDim2.fromOffset(v12, 0)
		Line.BackgroundColor3 = p1._config[("TableBorder%*Color"):format(p3)]
		Line.BackgroundTransparency = p1._config[("TableBorder%*Transparency"):format(p3)]
		Line.BorderSizePixel = 0
		Line.Parent = ImageButton
		local Hover = Instance.new("Frame")
		Hover.Name = "Hover"
		Hover.Position = UDim2.fromOffset(v12, 0)
		Hover.Size = UDim2.new(0, 1, 1, 0)
		Hover.BackgroundColor3 = p1._config[("TableBorder%*Color"):format(p3)]
		Hover.BackgroundTransparency = p1._config[("TableBorder%*Transparency"):format(p3)]
		Hover.BorderSizePixel = 0
		Hover.Visible = p12.arguments.Resizable
		Hover.Parent = ImageButton
		p2.applyInteractionHighlights("Background", ImageButton, Hover, {
			Color = p1._config.ResizeGripColor,
			Transparency = 1,
			HoveredColor = p1._config.ResizeGripHoveredColor,
			HoveredTransparency = p1._config.ResizeGripHoveredTransparency,
			ActiveColor = p1._config.ResizeGripActiveColor,
			ActiveTransparency = p1._config.ResizeGripActiveTransparency
		})
		p2.applyButtonDown(ImageButton, function() --[[ Line: 263 | Upvalues: p12 (copy), p22 (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), p2 (ref) ]]
			if p12.arguments.Resizable then
				v1 = true
				v2 = p12
				v3 = p22
				v4 = -1
				v5 = -1
				v6 = p2.getMouseLocation().X
			end
		end)
		return ImageButton
	end
	local function GenerateRow(p12, p22) --[[ Line: 273 | Upvalues: p1 (copy), p2 (copy), GenerateCell (copy) ]]
		local Frame = Instance.new("Frame")
		Frame.Name = ("Row_%*"):format(p22)
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.Size = UDim2.fromScale(1, 0)
		if p22 == 0 then
			Frame.BackgroundColor3 = p1._config.TableHeaderColor
			Frame.BackgroundTransparency = p1._config.TableHeaderTransparency
		elseif p12.arguments.RowBackground == true then
			if p22 % 2 == 0 then
				Frame.BackgroundColor3 = p1._config.TableRowBgAltColor
				Frame.BackgroundTransparency = p1._config.TableRowBgAltTransparency
			else
				Frame.BackgroundColor3 = p1._config.TableRowBgColor
				Frame.BackgroundTransparency = p1._config.TableRowBgTransparency
			end
		else
			Frame.BackgroundTransparency = 1
		end
		Frame.BorderSizePixel = 0
		Frame.ZIndex = p22 * 2 - 1
		Frame.LayoutOrder = p22 * 2 - 1
		Frame.ClipsDescendants = true
		p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new())
		p12._cellInstances[p22] = table.create(p12.arguments.NumColumns)
		for i = 1, p12.arguments.NumColumns do
			local v1
			v1 = p22 == 0
			local v4 = GenerateCell(p12, i, p12._widths[i], v1)
			v4.Parent = Frame
			p12._cellInstances[p22][i] = v4
		end
		p12._rowInstances[p22] = Frame
		return Frame
	end
	local function GenerateRowBorder(p12, p2, p3) --[[ Line: 311 | Upvalues: p1 (copy) ]]
		local Frame = Instance.new("Frame")
		Frame.Name = ("Border_%*"):format(p2)
		Frame.Size = UDim2.fromScale(1, 0)
		Frame.BackgroundTransparency = 1
		Frame.ZIndex = p2 * 2
		Frame.LayoutOrder = p2 * 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.Size = UDim2.new(1, 0, 0, 1)
		Line.BackgroundColor3 = p1._config[("TableBorder%*Color"):format(p3)]
		Line.BackgroundTransparency = p1._config[("TableBorder%*Transparency"):format(p3)]
		Line.BorderSizePixel = 0
		Line.Parent = Frame
		return Frame
	end
	p1.WidgetConstructor("Table", {
		hasState = true,
		hasChildren = true,
		Args = {
			NumColumns = 1,
			Header = 2,
			RowBackground = 3,
			OuterBorders = 4,
			InnerBorders = 5,
			Resizable = 6,
			FixedWidth = 7,
			ProportionalWidth = 8,
			LimitTableWidth = 9
		},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 348 | Upvalues: t (copy), t2 (copy), p2 (copy), p1 (copy) ]]
			t[p12.ID] = p12
			t2[p12] = {}
			local Iris_Table = Instance.new("Frame")
			Iris_Table.Name = "Iris_Table"
			Iris_Table.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Table.Size = UDim2.fromScale(1, 0)
			Iris_Table.BackgroundTransparency = 1
			local RowContainer = Instance.new("Frame")
			RowContainer.Name = "RowContainer"
			RowContainer.AutomaticSize = Enum.AutomaticSize.Y
			RowContainer.Size = UDim2.fromScale(1, 0)
			RowContainer.BackgroundTransparency = 1
			RowContainer.ZIndex = 1
			p2.UISizeConstraint(RowContainer)
			p2.UIListLayout(RowContainer, Enum.FillDirection.Vertical, UDim.new())
			RowContainer.Parent = Iris_Table
			p12._rowContainer = RowContainer
			local BorderContainer = Instance.new("Frame")
			BorderContainer.Name = "BorderContainer"
			BorderContainer.Size = UDim2.fromScale(1, 1)
			BorderContainer.BackgroundTransparency = 1
			BorderContainer.ZIndex = 2
			BorderContainer.ClipsDescendants = true
			p2.UISizeConstraint(BorderContainer)
			p2.UIListLayout(BorderContainer, Enum.FillDirection.Horizontal, UDim.new())
			p2.UIStroke(BorderContainer, 1, p1._config.TableBorderStrongColor, p1._config.TableBorderStrongTransparency)
			BorderContainer.Parent = Iris_Table
			p12._columnIndex = 1
			p12._rowIndex = 1
			p12._rowInstances = {}
			p12._cellInstances = {}
			p12._rowBorders = {}
			p12._columnBorders = {}
			p12._rowCycles = {}
			local v1 = #p1._postCycleCallbacks + 1
			local v2 = p1._cycleTick + 1
			p1._postCycleCallbacks[v1] = function() --[[ Line: 394 | Upvalues: p1 (ref), v2 (copy), p12 (copy), v1 (copy) ]]
				if v2 <= p1._cycleTick then
					if p12.lastCycleTick ~= -1 then
						p12.state.widths.lastChangeTick = p1._cycleTick
						p1._widgets.Table.UpdateState(p12)
					end
					p1._postCycleCallbacks[v1] = nil
				end
			end
			return Iris_Table
		end,
		GenerateState = function(p12) --[[ Name: GenerateState | Line: 406 | Upvalues: p1 (copy), GenerateColumnBorder (copy), GenerateCell (copy) ]]
			local NumColumns = p12.arguments.NumColumns
			if p12.state.widths == nil then
				p12.state.widths = p1._widgetState(p12, "widths", (table.create(NumColumns, 1 / NumColumns)))
			end
			p12._widths = table.create(NumColumns, UDim.new())
			p12._minWidths = table.create(NumColumns, 0)
			local v2 = p12.Instance
			local BorderContainer = v2.BorderContainer
			p12._cellInstances[-1] = table.create(NumColumns)
			for i = 1, NumColumns do
				local v3, v4
				local v5 = GenerateColumnBorder(p12, i, "Light")
				v5.Visible = p12.arguments.InnerBorders
				p12._columnBorders[i] = v5
				v5.Parent = BorderContainer
				local v6 = GenerateCell(p12, i, p12._widths[i], false)
				local UISizeConstraint = v6:FindFirstChild("UISizeConstraint")
				v3 = if i > 1 then -2 else 0
				v4 = if i < NumColumns then -3 else 0
				UISizeConstraint.MinSize = Vector2.new(2 * p1._config.CellPadding.X + v3 + v4, 0)
				v6.LayoutOrder = i * 2 - 1
				p12._cellInstances[-1][i] = v6
				v6.Parent = BorderContainer
			end
			local v10 = GenerateColumnBorder(p12, NumColumns, "Strong")
			p12._columnBorders[0] = v10
			v10.Parent = v2
		end,
		Update = function(p12) --[[ Name: Update | Line: 440 | Upvalues: p1 (copy), t2 (copy) ]]
			local NumColumns = p12.arguments.NumColumns
			assert(NumColumns >= 1, "Iris.Table must have at least one column.")
			if p12._widths ~= nil and #p12._widths ~= NumColumns then
				p12.arguments.NumColumns = #p12._widths
				warn("NumColumns cannot change once set. See documentation.")
			end
			for v2, v3 in p12._rowInstances do
				if v2 == 0 then
					v3.BackgroundColor3 = p1._config.TableHeaderColor
					v3.BackgroundTransparency = p1._config.TableHeaderTransparency
				elseif p12.arguments.RowBackground == true then
					if v2 % 2 == 0 then
						v3.BackgroundColor3 = p1._config.TableRowBgAltColor
						v3.BackgroundTransparency = p1._config.TableRowBgAltTransparency
					else
						v3.BackgroundColor3 = p1._config.TableRowBgColor
						v3.BackgroundTransparency = p1._config.TableRowBgTransparency
					end
				else
					v3.BackgroundTransparency = 1
				end
			end
			for v4, v5 in p12._rowBorders do
				v5.Visible = p12.arguments.InnerBorders
			end
			for v6, v7 in p12._columnBorders do
				v7.Visible = p12.arguments.InnerBorders or p12.arguments.Resizable
			end
			for v9, v10 in p12._columnBorders do
				local Hover = v10:FindFirstChild("Hover")
				if Hover then
					Hover.Visible = p12.arguments.Resizable
				end
			end
			if p12._columnBorders[NumColumns] ~= nil then
				p12._columnBorders[NumColumns].Visible = not p12.arguments.LimitTableWidth and (p12.arguments.Resizable or p12.arguments.InnerBorders)
				p12._columnBorders[0].Visible = p12.arguments.LimitTableWidth and (p12.arguments.Resizable or p12.arguments.OuterBorders)
			end
			local v15 = p12._rowInstances[0]
			local v16 = p12._rowBorders[0]
			if v15 ~= nil then
				v15.Visible = p12.arguments.Header
			end
			if v16 ~= nil then
				v16.Visible = p12.arguments.Header and p12.arguments.InnerBorders
			end
			p12.Instance.BorderContainer.UIStroke.Enabled = p12.arguments.OuterBorders
			for i = 1, p12.arguments.NumColumns do
				t2[p12][i] = true
			end
			if p12._widths ~= nil then
				p1._widgets.Table.UpdateState(p12)
			end
		end,
		UpdateState = function(p1) --[[ Name: UpdateState | Line: 512 ]]
			local v1 = p1.Instance
			local NumColumns = p1.arguments.NumColumns
			local value = p1.state.widths.value
			local _minWidths = p1._minWidths
			local FixedWidth = p1.arguments.FixedWidth
			local ProportionalWidth = p1.arguments.ProportionalWidth
			if not p1.arguments.Resizable then
				if FixedWidth then
					if ProportionalWidth then
						for i = 1, NumColumns do
							value[i] = _minWidths[i]
						end
					else
						local v2 = 0
						for v3, v4 in _minWidths do
							v2 = math.max(v2, v4)
						end
						for j = 1, NumColumns do
							value[j] = v2
						end
					end
				elseif ProportionalWidth then
					local sum = 0
					for v6, v7 in _minWidths do
						sum = sum + v7
					end
					local v8 = 1 / sum
					for k = 1, NumColumns do
						value[k] = v8 * _minWidths[k]
					end
				else
					local v9 = 1 / NumColumns
					for n = 1, NumColumns do
						value[n] = v9
					end
				end
			end
			local sum = UDim.new()
			for m = 1, NumColumns do
				local v10, v11, v12
				local v13 = value[m]
				local v14 = UDim.new
				v10 = if FixedWidth then 0 else math.clamp(v13, 0, 1)
				v11 = if FixedWidth then math.max(v13, 0) else 0
				local v15 = v14(v10, v11)
				p1._widths[m] = v15
				sum = sum + v15
				for v16, v17 in p1._cellInstances do
					v17[m].Size = UDim2.new(v15, UDim.new())
				end
				v12 = if m > 1 then -2 else 0
				p1._cellInstances[-1][m].Size = UDim2.new(v15 + UDim.new(0, v12 - 3), UDim.new())
			end
			local Offset = sum.Offset
			if not (p1.arguments.FixedWidth and p1.arguments.LimitTableWidth) then
				Offset = (1 / 0)
			end
			v1.BorderContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			v1.RowContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			p1._columnBorders[0].Position = UDim2.fromOffset(Offset - 3, 0)
		end,
		ChildAdded = function(p12, p2) --[[ Name: ChildAdded | Line: 587 | Upvalues: p1 (copy), t2 (copy), GenerateRow (copy), GenerateRowBorder (copy) ]]
			local _rowIndex = p12._rowIndex
			local _columnIndex = p12._columnIndex
			p12._rowCycles[_rowIndex] = p1._cycleTick
			t2[p12][_columnIndex] = true
			if p12._rowInstances[_rowIndex] == nil then
				local v2 = GenerateRow(p12, _rowIndex)
				if _rowIndex == 0 then
					v2.Visible = p12.arguments.Header
				end
				v2.Parent = p12._rowContainer
				if _rowIndex > 0 then
					local v7 = GenerateRowBorder(p12, _rowIndex - 1, if _rowIndex == 1 then "Strong" else "Light")
					local InnerBorders = p12.arguments.InnerBorders
					if InnerBorders then
						InnerBorders = if _rowIndex == 1 then p12.arguments.Header and p12.arguments.InnerBorders and p12._rowInstances[0] ~= nil else true
					end
					v7.Visible = InnerBorders
					p12._rowBorders[_rowIndex - 1] = v7
					v7.Parent = p12._rowContainer
				end
			end
			return p12._cellInstances[_rowIndex][_columnIndex]
		end,
		ChildDiscarded = function(p1, p2) --[[ Name: ChildDiscarded | Line: 614 | Upvalues: t2 (copy) ]]
			local v1 = p2.Instance.Parent
			if v1 ~= nil then
				local v3 = tonumber(v1.Name:sub(6))
				if v3 then
					t2[p1][v3] = true
				end
			end
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 625 | Upvalues: t (copy), t2 (copy), p2 (copy) ]]
			t[p1.ID] = nil
			t2[p1] = nil
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end