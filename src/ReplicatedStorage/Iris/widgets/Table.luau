-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local t = {}
	local t2 = {}
	local instance = false
	local instance2 = nil
	local var3 = 0
	local var4 = -1
	local var5 = -1
	local var6 = 0
	local function CalculateMinColumnWidth(p12, p2)
		local instance = 0
		for instance2, var3 in p12._cellInstances do
			for var4, var5 in var3[p2]:GetChildren() do
				if var5:IsA("GuiObject") then
					instance = math.max(instance, var5.AbsoluteSize.X)
				end
			end
		end
		p12._minWidths[p2] = instance + 2 * p1._config.CellPadding.X
	end
	table.insert(p1._postCycleCallbacks, function()
		for instance, instance2 in t do
			for var3, var4 in instance2._rowCycles do
				if var4 < p1._cycleTick - 1 then
					local var5 = instance2._rowInstances[var3]
					local var6 = instance2._rowBorders[var3 - 1]
					if var5 ~= nil then
						var5:Destroy()
					end
					if var6 ~= nil then
						var6:Destroy()
					end
					instance2._rowInstances[var3] = nil
					instance2._rowBorders[var3 - 1] = nil
					instance2._cellInstances[var3] = nil
					instance2._rowCycles[var3] = nil
				end
			end
			instance2._rowIndex = 1
			instance2._columnIndex = 1
			instance2.Instance.BorderContainer.Size = UDim2.new(1, 0, 0, instance2._rowContainer.AbsoluteSize.Y)
			instance2._columnBorders[0].Size = UDim2.fromOffset(5, instance2._rowContainer.AbsoluteSize.Y)
		end
		for var7, var8 in t2 do
			local var9 = false
			for var10, var11 in var8 do
				CalculateMinColumnWidth(var7, var10)
				var9 = true
			end
			if var9 then
				table.clear(var8)
				p1._widgets.Table.UpdateState(var7)
			end
		end
	end)
	local function UpdateActiveColumn()
		if instance ~= false and instance2 ~= nil then
			local widths = instance2.state.widths
			local NumColumns = instance2.arguments.NumColumns
			local instance12 = instance2.Instance
			local BorderContainer = instance12.BorderContainer
			local var22 = 2 * p1._config.CellPadding.X
			if var4 == -1 then
				var4 = widths.value[var3]
				if var4 == 0 then
					var4 = var22 / instance12.AbsoluteSize.X
				end
				var5 = widths.value[var3 + 1] or -1
				if var5 == 0 then
					var5 = var22 / instance12.AbsoluteSize.X
				end
			end
			local X = instance12.AbsolutePosition.X
			local var32 = if var3 == 1 then 0 else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(var3 - 1))).AbsolutePosition.X + 3 - X)
			local var62 = if NumColumns - 1 <= var3 then instance12.AbsoluteSize.X else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(var3 + 1))).AbsolutePosition.X + 3 - X)
			local var9 = X - p2.GuiOffset.X
			local X_2 = p2.getMouseLocation().X
			local var10 = math.clamp(X_2, var32 + var9 + var22, var62 + var9 - var22) - var6
			local var11 = var4 / (var6 - var9 - var32)
			if instance2.arguments.FixedWidth then
				widths.value[var3] = math.clamp(math.round(var4 + var10), var22, instance12.AbsoluteSize.X - var32)
			else
				local var16 = var11 * var10
				widths.value[var3] = math.clamp(var4 + var16, 0, (var62 - var32 - var22) / instance12.AbsoluteSize.X)
				if var3 < NumColumns then
					widths.value[var3 + 1] = math.clamp(var5 - var16, 0, 1)
				end
			end
			widths:set(widths.value, true)
		end
	end
	local function ColumnMouseDown(p1, p22)
		instance = true
		instance2 = p1
		var3 = p22
		var4 = -1
		var5 = -1
		var6 = p2.getMouseLocation().X
	end
	p2.registerEvent("InputChanged", function()
		if p1._started then
			UpdateActiveColumn()
		end
	end)
	p2.registerEvent("InputEnded", function(p12)
		if p1._started and (p12.UserInputType == Enum.UserInputType.MouseButton1 and instance) then
			instance = false
			instance2 = nil
			var3 = 0
			var4 = -1
			var5 = -1
			var6 = 0
		end
	end)
	local function GenerateCell(p12, p22, p3, p4)
		local instance
		if p4 then
			local TextButton = Instance.new("TextButton")
			TextButton.Text = ""
			TextButton.AutoButtonColor = false
			instance = TextButton
		else
			instance = Instance.new("Frame")
		end
		instance.Name = ("Cell_%*"):format(p22)
		instance.AutomaticSize = Enum.AutomaticSize.Y
		instance.Size = UDim2.new(p3, UDim.new())
		instance.BackgroundTransparency = 1
		instance.ZIndex = p22
		instance.LayoutOrder = p22
		instance.ClipsDescendants = true
		if p4 then
			p2.applyInteractionHighlights("Background", instance, instance, {
				Color = p1._config.HeaderColor,
				Transparency = 1,
				HoveredColor = p1._config.HeaderHoveredColor,
				HoveredTransparency = p1._config.HeaderHoveredTransparency,
				ActiveColor = p1._config.HeaderActiveColor,
				ActiveTransparency = p1._config.HeaderActiveTransparency
			})
		end
		p2.UIPadding(instance, p1._config.CellPadding)
		p2.UIListLayout(instance, Enum.FillDirection.Vertical, UDim.new())
		p2.UISizeConstraint(instance, Vector2.new(2 * p1._config.CellPadding.X, 0))
		return instance
	end
	local function GenerateColumnBorder(p12, p22, p3)
		local ImageButton = Instance.new("ImageButton")
		ImageButton.Name = ("Border_%*"):format(p22)
		ImageButton.Size = UDim2.new(0, 5, 1, 0)
		ImageButton.BackgroundTransparency = 1
		ImageButton.Image = ""
		ImageButton.ImageTransparency = 1
		ImageButton.AutoButtonColor = false
		ImageButton.ZIndex = p22
		ImageButton.LayoutOrder = p22 * 2
		local instance12 = if p22 == p12.arguments.NumColumns then 3 else 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.Size = UDim2.new(0, 1, 1, 0)
		Line.Position = UDim2.fromOffset(instance12, 0)
		Line.BackgroundColor3 = p1._config[("TableBorder%*Color"):format(p3)]
		Line.BackgroundTransparency = p1._config[("TableBorder%*Transparency"):format(p3)]
		Line.BorderSizePixel = 0
		Line.Parent = ImageButton
		local Hover = Instance.new("Frame")
		Hover.Name = "Hover"
		Hover.Position = UDim2.fromOffset(instance12, 0)
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
		p2.applyButtonDown(ImageButton, function()
			if p12.arguments.Resizable then
				instance = true
				instance2 = p12
				var3 = p22
				var4 = -1
				var5 = -1
				var6 = p2.getMouseLocation().X
			end
		end)
		return ImageButton
	end
	local function GenerateRow(p12, p22)
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
			local instance
			instance = p22 == 0
			local var4 = GenerateCell(p12, i, p12._widths[i], instance)
			var4.Parent = Frame
			p12._cellInstances[p22][i] = var4
		end
		p12._rowInstances[p22] = Frame
		return Frame
	end
	local function GenerateRowBorder(p12, p2, p3)
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
		Generate = function(p12)
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
			local instance = #p1._postCycleCallbacks + 1
			local instance2 = p1._cycleTick + 1
			p1._postCycleCallbacks[instance] = function()
				if instance2 <= p1._cycleTick then
					if p12.lastCycleTick ~= -1 then
						p12.state.widths.lastChangeTick = p1._cycleTick
						p1._widgets.Table.UpdateState(p12)
					end
					p1._postCycleCallbacks[instance] = nil
				end
			end
			return Iris_Table
		end,
		GenerateState = function(p12)
			local NumColumns = p12.arguments.NumColumns
			if p12.state.widths == nil then
				p12.state.widths = p1._widgetState(p12, "widths", (table.create(NumColumns, 1 / NumColumns)))
			end
			p12._widths = table.create(NumColumns, UDim.new())
			p12._minWidths = table.create(NumColumns, 0)
			local instance2 = p12.Instance
			local BorderContainer = instance2.BorderContainer
			p12._cellInstances[-1] = table.create(NumColumns)
			for i = 1, NumColumns do
				local var3, var4
				local var5 = GenerateColumnBorder(p12, i, "Light")
				var5.Visible = p12.arguments.InnerBorders
				p12._columnBorders[i] = var5
				var5.Parent = BorderContainer
				local var6 = GenerateCell(p12, i, p12._widths[i], false)
				local UISizeConstraint = var6:FindFirstChild("UISizeConstraint")
				var3 = if i > 1 then -2 else 0
				var4 = if i < NumColumns then -3 else 0
				UISizeConstraint.MinSize = Vector2.new(2 * p1._config.CellPadding.X + var3 + var4, 0)
				var6.LayoutOrder = i * 2 - 1
				p12._cellInstances[-1][i] = var6
				var6.Parent = BorderContainer
			end
			local var10 = GenerateColumnBorder(p12, NumColumns, "Strong")
			p12._columnBorders[0] = var10
			var10.Parent = instance2
		end,
		Update = function(p12)
			local NumColumns = p12.arguments.NumColumns
			assert(NumColumns >= 1, "Iris.Table must have at least one column.")
			if p12._widths ~= nil and #p12._widths ~= NumColumns then
				p12.arguments.NumColumns = #p12._widths
				warn("NumColumns cannot change once set. See documentation.")
			end
			for instance2, var3 in p12._rowInstances do
				if instance2 == 0 then
					var3.BackgroundColor3 = p1._config.TableHeaderColor
					var3.BackgroundTransparency = p1._config.TableHeaderTransparency
				elseif p12.arguments.RowBackground == true then
					if instance2 % 2 == 0 then
						var3.BackgroundColor3 = p1._config.TableRowBgAltColor
						var3.BackgroundTransparency = p1._config.TableRowBgAltTransparency
					else
						var3.BackgroundColor3 = p1._config.TableRowBgColor
						var3.BackgroundTransparency = p1._config.TableRowBgTransparency
					end
				else
					var3.BackgroundTransparency = 1
				end
			end
			for var4, var5 in p12._rowBorders do
				var5.Visible = p12.arguments.InnerBorders
			end
			for var6, var7 in p12._columnBorders do
				var7.Visible = p12.arguments.InnerBorders or p12.arguments.Resizable
			end
			for var9, var10 in p12._columnBorders do
				local Hover = var10:FindFirstChild("Hover")
				if Hover then
					Hover.Visible = p12.arguments.Resizable
				end
			end
			if p12._columnBorders[NumColumns] ~= nil then
				p12._columnBorders[NumColumns].Visible = not p12.arguments.LimitTableWidth and (p12.arguments.Resizable or p12.arguments.InnerBorders)
				p12._columnBorders[0].Visible = p12.arguments.LimitTableWidth and (p12.arguments.Resizable or p12.arguments.OuterBorders)
			end
			local instance15 = p12._rowInstances[0]
			local var16 = p12._rowBorders[0]
			if instance15 ~= nil then
				instance15.Visible = p12.arguments.Header
			end
			if var16 ~= nil then
				var16.Visible = p12.arguments.Header and p12.arguments.InnerBorders
			end
			p12.Instance.BorderContainer.UIStroke.Enabled = p12.arguments.OuterBorders
			for i = 1, p12.arguments.NumColumns do
				t2[p12][i] = true
			end
			if p12._widths ~= nil then
				p1._widgets.Table.UpdateState(p12)
			end
		end,
		UpdateState = function(p1)
			local instance = p1.Instance
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
						local instance2 = 0
						for var3, var4 in _minWidths do
							instance2 = math.max(instance2, var4)
						end
						for j = 1, NumColumns do
							value[j] = instance2
						end
					end
				elseif ProportionalWidth then
					local sum = 0
					for var6, var7 in _minWidths do
						sum = sum + var7
					end
					local var8 = 1 / sum
					for k = 1, NumColumns do
						value[k] = var8 * _minWidths[k]
					end
				else
					local var9 = 1 / NumColumns
					for n = 1, NumColumns do
						value[n] = var9
					end
				end
			end
			local sum = UDim.new()
			for m = 1, NumColumns do
				local var10, var11, instance12
				local var13 = value[m]
				local obj14 = UDim.new
				var10 = if FixedWidth then 0 else math.clamp(var13, 0, 1)
				var11 = if FixedWidth then math.max(var13, 0) else 0
				local instance15 = obj14(var10, var11)
				p1._widths[m] = instance15
				sum = sum + instance15
				for var16, v17 in p1._cellInstances do
					v17[m].Size = UDim2.new(instance15, UDim.new())
				end
				instance12 = if m > 1 then -2 else 0
				p1._cellInstances[-1][m].Size = UDim2.new(instance15 + UDim.new(0, instance12 - 3), UDim.new())
			end
			local Offset = sum.Offset
			if not (p1.arguments.FixedWidth and p1.arguments.LimitTableWidth) then
				Offset = (1 / 0)
			end
			instance.BorderContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			instance.RowContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			p1._columnBorders[0].Position = UDim2.fromOffset(Offset - 3, 0)
		end,
		ChildAdded = function(p12, p2)
			local _rowIndex = p12._rowIndex
			local _columnIndex = p12._columnIndex
			p12._rowCycles[_rowIndex] = p1._cycleTick
			t2[p12][_columnIndex] = true
			if p12._rowInstances[_rowIndex] == nil then
				local instance2 = GenerateRow(p12, _rowIndex)
				if _rowIndex == 0 then
					instance2.Visible = p12.arguments.Header
				end
				instance2.Parent = p12._rowContainer
				if _rowIndex > 0 then
					local var7 = GenerateRowBorder(p12, _rowIndex - 1, if _rowIndex == 1 then "Strong" else "Light")
					local InnerBorders = p12.arguments.InnerBorders
					if InnerBorders then
						InnerBorders = if _rowIndex == 1 then p12.arguments.Header and p12.arguments.InnerBorders and p12._rowInstances[0] ~= nil else true
					end
					var7.Visible = InnerBorders
					p12._rowBorders[_rowIndex - 1] = var7
					var7.Parent = p12._rowContainer
				end
			end
			return p12._cellInstances[_rowIndex][_columnIndex]
		end,
		ChildDiscarded = function(p1, p2)
			local instance = p2.Instance.Parent
			if instance ~= nil then
				local var3 = tonumber(instance.Name:sub(6))
				if var3 then
					t2[p1][var3] = true
				end
			end
		end,
		Discard = function(p1)
			t[p1.ID] = nil
			t2[p1] = nil
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end
