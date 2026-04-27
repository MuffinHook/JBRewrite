require(script.Parent.Parent.Types)
return function(widgetInstance, contextUtils)
	local tableInstances = {}
	local dirtyColumns = {}
	local isResizing = false
	local activeTable = nil
	local resizeRowIndex = 0
	local resizeColumnIndex = -1
	local resizeNextColumnWidth = -1
	local resizeMouseOffset = 0
	local function CalculateMinColumnWidth(tableData, columnIndex)
		local maxWidth = 0
		for rowIndex, rowCells in tableData._cellInstances do
			for cellIndex, cellInstance in rowCells[columnIndex]:GetChildren() do
				if cellInstance:IsA("GuiObject") then
					maxWidth = math.max(maxWidth, cellInstance.AbsoluteSize.X)
				end
			end
		end
		tableData._minWidths[columnIndex] = maxWidth + 2 * widgetInstance._config.CellPadding.X
	end
	table.insert(widgetInstance._postCycleCallbacks, function()
		for tableId, tableData in tableInstances do
			for rowIndex, rowCycleTick in tableData._rowCycles do
				if rowCycleTick < widgetInstance._cycleTick - 1 then
					local rowElement = tableData._rowInstances[rowIndex]
					local borderElement = tableData._rowBorders[rowIndex - 1]
					if rowElement ~= nil then
						rowElement:Destroy()
					end
					if borderElement ~= nil then
						borderElement:Destroy()
					end
					tableData._rowInstances[rowIndex] = nil
					tableData._rowBorders[rowIndex - 1] = nil
					tableData._cellInstances[rowIndex] = nil
					tableData._rowCycles[rowIndex] = nil
				end
			end
			tableData._rowIndex = 1
			tableData._columnIndex = 1
			tableData.Instance.BorderContainer.Size = UDim2.new(1, 0, 0, tableData._rowContainer.AbsoluteSize.Y)
			tableData._columnBorders[0].Size = UDim2.fromOffset(5, tableData._rowContainer.AbsoluteSize.Y)
		end
		for tableData, columnIndexMap in dirtyColumns do
			local hasDirtyColumns = false
			for columnIndex, isDirty in columnIndexMap do
				CalculateMinColumnWidth(tableData, columnIndex)
				hasDirtyColumns = true
			end
			if hasDirtyColumns then
				table.clear(columnIndexMap)
				widgetInstance._widgets.Table.UpdateState(tableData)
			end
		end
	end)
	local function UpdateActiveColumn()
		if isResizing ~= false and activeTable ~= nil then
			local widths = activeTable.state.widths
			local NumColumns = activeTable.arguments.NumColumns
			local tableInstance = activeTable.Instance
			local BorderContainer = tableInstance.BorderContainer
			local cellPaddingOffset = 2 * widgetInstance._config.CellPadding.X
			if resizeColumnIndex == -1 then
				resizeColumnIndex = widths.value[resizeRowIndex]
				if resizeColumnIndex == 0 then
					resizeColumnIndex = cellPaddingOffset / tableInstance.AbsoluteSize.X
				end
				resizeNextColumnWidth = widths.value[resizeRowIndex + 1] or -1
				if resizeNextColumnWidth == 0 then
					resizeNextColumnWidth = cellPaddingOffset / tableInstance.AbsoluteSize.X
				end
			end
			local X = tableInstance.AbsolutePosition.X
			local leftBoundary = if resizeRowIndex == 1 then 0 else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(resizeRowIndex - 1))).AbsolutePosition.X + 3 - X)
			local rightBoundary = if NumColumns - 1 <= resizeRowIndex then tableInstance.AbsoluteSize.X else math.floor(BorderContainer:FindFirstChild((("Border_%*"):format(resizeRowIndex + 1))).AbsolutePosition.X + 3 - X)
			local guiOffsetX = X - contextUtils.GuiOffset.X
			local currentMouseX = contextUtils.getMouseLocation().X
			local clampedMouseDelta = math.clamp(currentMouseX, leftBoundary + guiOffsetX + cellPaddingOffset, rightBoundary + guiOffsetX - cellPaddingOffset) - resizeMouseOffset
			local widthScaleFactor = resizeColumnIndex / (resizeMouseOffset - guiOffsetX - leftBoundary)
			if activeTable.arguments.FixedWidth then
				widths.value[resizeRowIndex] = math.clamp(math.round(resizeColumnIndex + clampedMouseDelta), cellPaddingOffset, tableInstance.AbsoluteSize.X - leftBoundary)
			else
				local nextColumnDelta = widthScaleFactor * clampedMouseDelta
				widths.value[resizeRowIndex] = math.clamp(resizeColumnIndex + nextColumnDelta, 0, (rightBoundary - leftBoundary - cellPaddingOffset) / tableInstance.AbsoluteSize.X)
				if resizeRowIndex < NumColumns then
					widths.value[resizeRowIndex + 1] = math.clamp(resizeNextColumnWidth - nextColumnDelta, 0, 1)
				end
			end
			widths:set(widths.value, true)
		end
	end
	local function ColumnMouseDown(clickedTable, columnNum)
		isResizing = true
		activeTable = clickedTable
		resizeRowIndex = columnNum
		resizeColumnIndex = -1
		resizeNextColumnWidth = -1
		resizeMouseOffset = contextUtils.getMouseLocation().X
	end
	contextUtils.registerEvent("InputChanged", function()
		if widgetInstance._started then
			UpdateActiveColumn()
		end
	end)
	contextUtils.registerEvent("InputEnded", function(inputEvent)
		if widgetInstance._started and (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 and isResizing) then
			isResizing = false
			activeTable = nil
			resizeRowIndex = 0
			resizeColumnIndex = -1
			resizeNextColumnWidth = -1
			resizeMouseOffset = 0
		end
	end)
	local function GenerateCell(tableData, cellIndex, cellWidth, isHeader)
		local cellElement
		if isHeader then
			local TextButton = Instance.new("TextButton")
			TextButton.Text = ""
			TextButton.AutoButtonColor = false
			cellElement = TextButton
		else
			cellElement = Instance.new("Frame")
		end
		cellElement.Name = ("Cell_%*"):format(cellIndex)
		cellElement.AutomaticSize = Enum.AutomaticSize.Y
		cellElement.Size = UDim2.new(cellWidth, UDim.new())
		cellElement.BackgroundTransparency = 1
		cellElement.ZIndex = cellIndex
		cellElement.LayoutOrder = cellIndex
		cellElement.ClipsDescendants = true
		if isHeader then
			contextUtils.applyInteractionHighlights("Background", cellElement, cellElement, {
				Color = widgetInstance._config.HeaderColor,
				Transparency = 1,
				HoveredColor = widgetInstance._config.HeaderHoveredColor,
				HoveredTransparency = widgetInstance._config.HeaderHoveredTransparency,
				ActiveColor = widgetInstance._config.HeaderActiveColor,
				ActiveTransparency = widgetInstance._config.HeaderActiveTransparency
			})
		end
		contextUtils.UIPadding(cellElement, widgetInstance._config.CellPadding)
		contextUtils.UIListLayout(cellElement, Enum.FillDirection.Vertical, UDim.new())
		contextUtils.UISizeConstraint(cellElement, Vector2.new(2 * widgetInstance._config.CellPadding.X, 0))
		return cellElement
	end
	local function GenerateColumnBorder(tableData, columnNum, borderType)
		local ImageButton = Instance.new("ImageButton")
		ImageButton.Name = ("Border_%*"):format(columnNum)
		ImageButton.Size = UDim2.new(0, 5, 1, 0)
		ImageButton.BackgroundTransparency = 1
		ImageButton.Image = ""
		ImageButton.ImageTransparency = 1
		ImageButton.AutoButtonColor = false
		ImageButton.ZIndex = columnNum
		ImageButton.LayoutOrder = columnNum * 2
		local lineOffsetX = if columnNum == tableData.arguments.NumColumns then 3 else 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.Size = UDim2.new(0, 1, 1, 0)
		Line.Position = UDim2.fromOffset(lineOffsetX, 0)
		Line.BackgroundColor3 = widgetInstance._config[("TableBorder%*Color"):format(borderType)]
		Line.BackgroundTransparency = widgetInstance._config[("TableBorder%*Transparency"):format(borderType)]
		Line.BorderSizePixel = 0
		Line.Parent = ImageButton
		local Hover = Instance.new("Frame")
		Hover.Name = "Hover"
		Hover.Position = UDim2.fromOffset(lineOffsetX, 0)
		Hover.Size = UDim2.new(0, 1, 1, 0)
		Hover.BackgroundColor3 = widgetInstance._config[("TableBorder%*Color"):format(borderType)]
		Hover.BackgroundTransparency = widgetInstance._config[("TableBorder%*Transparency"):format(borderType)]
		Hover.BorderSizePixel = 0
		Hover.Visible = tableData.arguments.Resizable
		Hover.Parent = ImageButton
		contextUtils.applyInteractionHighlights("Background", ImageButton, Hover, {
			Color = widgetInstance._config.ResizeGripColor,
			Transparency = 1,
			HoveredColor = widgetInstance._config.ResizeGripHoveredColor,
			HoveredTransparency = widgetInstance._config.ResizeGripHoveredTransparency,
			ActiveColor = widgetInstance._config.ResizeGripActiveColor,
			ActiveTransparency = widgetInstance._config.ResizeGripActiveTransparency
		})
		contextUtils.applyButtonDown(ImageButton, function()
			if tableData.arguments.Resizable then
				isResizing = true
				activeTable = tableData
				resizeRowIndex = columnNum
				resizeColumnIndex = -1
				resizeNextColumnWidth = -1
				resizeMouseOffset = contextUtils.getMouseLocation().X
			end
		end)
		return ImageButton
	end
	local function GenerateRow(tableData, rowNum)
		local Frame = Instance.new("Frame")
		Frame.Name = ("Row_%*"):format(rowNum)
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.Size = UDim2.fromScale(1, 0)
		if rowNum == 0 then
			Frame.BackgroundColor3 = widgetInstance._config.TableHeaderColor
			Frame.BackgroundTransparency = widgetInstance._config.TableHeaderTransparency
		elseif tableData.arguments.RowBackground == true then
			if rowNum % 2 == 0 then
				Frame.BackgroundColor3 = widgetInstance._config.TableRowBgAltColor
				Frame.BackgroundTransparency = widgetInstance._config.TableRowBgAltTransparency
			else
				Frame.BackgroundColor3 = widgetInstance._config.TableRowBgColor
				Frame.BackgroundTransparency = widgetInstance._config.TableRowBgTransparency
			end
		else
			Frame.BackgroundTransparency = 1
		end
		Frame.BorderSizePixel = 0
		Frame.ZIndex = rowNum * 2 - 1
		Frame.LayoutOrder = rowNum * 2 - 1
		Frame.ClipsDescendants = true
		contextUtils.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new())
		tableData._cellInstances[rowNum] = table.create(tableData.arguments.NumColumns)
		for i = 1, tableData.arguments.NumColumns do
			local isHeaderCell
			isHeaderCell = rowNum == 0
			local cellElement = GenerateCell(tableData, i, tableData._widths[i], isHeaderCell)
			cellElement.Parent = Frame
			tableData._cellInstances[rowNum][i] = cellElement
		end
		tableData._rowInstances[rowNum] = Frame
		return Frame
	end
	local function GenerateRowBorder(tableData, rowNum, borderType)
		local Frame = Instance.new("Frame")
		Frame.Name = ("Border_%*"):format(rowNum)
		Frame.Size = UDim2.fromScale(1, 0)
		Frame.BackgroundTransparency = 1
		Frame.ZIndex = rowNum * 2
		Frame.LayoutOrder = rowNum * 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.Size = UDim2.new(1, 0, 0, 1)
		Line.BackgroundColor3 = widgetInstance._config[("TableBorder%*Color"):format(borderType)]
		Line.BackgroundTransparency = widgetInstance._config[("TableBorder%*Transparency"):format(borderType)]
		Line.BorderSizePixel = 0
		Line.Parent = Frame
		return Frame
	end
	widgetInstance.WidgetConstructor("Table", {
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
		Generate = function(tableData)
			tableInstances[tableData.ID] = tableData
			dirtyColumns[tableData] = {}
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
			contextUtils.UISizeConstraint(RowContainer)
			contextUtils.UIListLayout(RowContainer, Enum.FillDirection.Vertical, UDim.new())
			RowContainer.Parent = Iris_Table
			tableData._rowContainer = RowContainer
			local BorderContainer = Instance.new("Frame")
			BorderContainer.Name = "BorderContainer"
			BorderContainer.Size = UDim2.fromScale(1, 1)
			BorderContainer.BackgroundTransparency = 1
			BorderContainer.ZIndex = 2
			BorderContainer.ClipsDescendants = true
			contextUtils.UISizeConstraint(BorderContainer)
			contextUtils.UIListLayout(BorderContainer, Enum.FillDirection.Horizontal, UDim.new())
			contextUtils.UIStroke(BorderContainer, 1, widgetInstance._config.TableBorderStrongColor, widgetInstance._config.TableBorderStrongTransparency)
			BorderContainer.Parent = Iris_Table
			tableData._columnIndex = 1
			tableData._rowIndex = 1
			tableData._rowInstances = {}
			tableData._cellInstances = {}
			tableData._rowBorders = {}
			tableData._columnBorders = {}
			tableData._rowCycles = {}
			local callbackIndex = #widgetInstance._postCycleCallbacks + 1
			local targetCycleTick = widgetInstance._cycleTick + 1
			widgetInstance._postCycleCallbacks[callbackIndex] = function()
				if targetCycleTick <= widgetInstance._cycleTick then
					if tableData.lastCycleTick ~= -1 then
						tableData.state.widths.lastChangeTick = widgetInstance._cycleTick
						widgetInstance._widgets.Table.UpdateState(tableData)
					end
					widgetInstance._postCycleCallbacks[callbackIndex] = nil
				end
			end
			return Iris_Table
		end,
		GenerateState = function(tableData)
			local NumColumns = tableData.arguments.NumColumns
			if tableData.state.widths == nil then
				tableData.state.widths = widgetInstance._widgetState(tableData, "widths", (table.create(NumColumns, 1 / NumColumns)))
			end
			tableData._widths = table.create(NumColumns, UDim.new())
			tableData._minWidths = table.create(NumColumns, 0)
			local tableInstance = tableData.Instance
			local BorderContainer = tableInstance.BorderContainer
			tableData._cellInstances[-1] = table.create(NumColumns)
			for i = 1, NumColumns do
				local offsetX, offsetXEnd
				local borderElement = GenerateColumnBorder(tableData, i, "Light")
				borderElement.Visible = tableData.arguments.InnerBorders
				tableData._columnBorders[i] = borderElement
				borderElement.Parent = BorderContainer
				local headerCell = GenerateCell(tableData, i, tableData._widths[i], false)
				local UISizeConstraint = headerCell:FindFirstChild("UISizeConstraint")
				offsetX = if i > 1 then -2 else 0
				offsetXEnd = if i < NumColumns then -3 else 0
				UISizeConstraint.MinSize = Vector2.new(2 * widgetInstance._config.CellPadding.X + offsetX + offsetXEnd, 0)
				headerCell.LayoutOrder = i * 2 - 1
				tableData._cellInstances[-1][i] = headerCell
				headerCell.Parent = BorderContainer
			end
			local rightBorder = GenerateColumnBorder(tableData, NumColumns, "Strong")
			tableData._columnBorders[0] = rightBorder
			rightBorder.Parent = tableInstance
		end,
		Update = function(tableData)
			local NumColumns = tableData.arguments.NumColumns
			assert(NumColumns >= 1, "Iris.Table must have at least one column.")
			if tableData._widths ~= nil and #tableData._widths ~= NumColumns then
				tableData.arguments.NumColumns = #tableData._widths
				warn("NumColumns cannot change once set. See documentation.")
			end
			for rowIndex, rowElement in tableData._rowInstances do
				if rowIndex == 0 then
					rowElement.BackgroundColor3 = widgetInstance._config.TableHeaderColor
					rowElement.BackgroundTransparency = widgetInstance._config.TableHeaderTransparency
				elseif tableData.arguments.RowBackground == true then
					if rowIndex % 2 == 0 then
						rowElement.BackgroundColor3 = widgetInstance._config.TableRowBgAltColor
						rowElement.BackgroundTransparency = widgetInstance._config.TableRowBgAltTransparency
					else
						rowElement.BackgroundColor3 = widgetInstance._config.TableRowBgColor
						rowElement.BackgroundTransparency = widgetInstance._config.TableRowBgTransparency
					end
				else
					rowElement.BackgroundTransparency = 1
				end
			end
			for borderIndex, borderElement in tableData._rowBorders do
				borderElement.Visible = tableData.arguments.InnerBorders
			end
			for columnIndex, columnBorder in tableData._columnBorders do
				columnBorder.Visible = tableData.arguments.InnerBorders or tableData.arguments.Resizable
			end
			for borderIndex, borderElement in tableData._columnBorders do
				local Hover = borderElement:FindFirstChild("Hover")
				if Hover then
					Hover.Visible = tableData.arguments.Resizable
				end
			end
			if tableData._columnBorders[NumColumns] ~= nil then
				tableData._columnBorders[NumColumns].Visible = not tableData.arguments.LimitTableWidth and (tableData.arguments.Resizable or tableData.arguments.InnerBorders)
				tableData._columnBorders[0].Visible = tableData.arguments.LimitTableWidth and (tableData.arguments.Resizable or tableData.arguments.OuterBorders)
			end
			local headerRow = tableData._rowInstances[0]
			local headerBorder = tableData._rowBorders[0]
			if headerRow ~= nil then
				headerRow.Visible = tableData.arguments.Header
			end
			if headerBorder ~= nil then
				headerBorder.Visible = tableData.arguments.Header and tableData.arguments.InnerBorders
			end
			tableData.Instance.BorderContainer.UIStroke.Enabled = tableData.arguments.OuterBorders
			for i = 1, tableData.arguments.NumColumns do
				dirtyColumns[tableData][i] = true
			end
			if tableData._widths ~= nil then
				widgetInstance._widgets.Table.UpdateState(tableData)
			end
		end,
		UpdateState = function(tableData)
			local tableInstance = tableData.Instance
			local NumColumns = tableData.arguments.NumColumns
			local value = tableData.state.widths.value
			local _minWidths = tableData._minWidths
			local FixedWidth = tableData.arguments.FixedWidth
			local ProportionalWidth = tableData.arguments.ProportionalWidth
			if not tableData.arguments.Resizable then
				if FixedWidth then
					if ProportionalWidth then
						for i = 1, NumColumns do
							value[i] = _minWidths[i]
						end
					else
						local maxWidth = 0
						for columnIndex, columnWidth in _minWidths do
							maxWidth = math.max(maxWidth, columnWidth)
						end
						for j = 1, NumColumns do
							value[j] = maxWidth
						end
					end
				elseif ProportionalWidth then
					local totalWidth = 0
					for columnIndex, columnWidth in _minWidths do
						totalWidth = totalWidth + columnWidth
					end
					local widthScaleRatio = 1 / totalWidth
					for k = 1, NumColumns do
						value[k] = widthScaleRatio * _minWidths[k]
					end
				else
					local uniformWidth = 1 / NumColumns
					for n = 1, NumColumns do
						value[n] = uniformWidth
					end
				end
			end
			local sum = UDim.new()
			for m = 1, NumColumns do
				local currentScaleWidth, currentPixelWidth, computedUDim
				local currentValue = value[m]
				local UDimConstructor = UDim.new
				currentScaleWidth = if FixedWidth then 0 else math.clamp(currentValue, 0, 1)
				currentPixelWidth = if FixedWidth then math.max(currentValue, 0) else 0
				local calculatedDim = UDimConstructor(currentScaleWidth, currentPixelWidth)
				tableData._widths[m] = calculatedDim
				sum = sum + calculatedDim
				for rowIndex, cellRow in tableData._cellInstances do
					cellRow[m].Size = UDim2.new(calculatedDim, UDim.new())
				end
				computedUDim = if m > 1 then -2 else 0
				tableData._cellInstances[-1][m].Size = UDim2.new(calculatedDim + UDim.new(0, computedUDim - 3), UDim.new())
			end
			local Offset = sum.Offset
			if not (tableData.arguments.FixedWidth and tableData.arguments.LimitTableWidth) then
				Offset = (1 / 0)
			end
			tableInstance.BorderContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			tableInstance.RowContainer.UISizeConstraint.MaxSize = Vector2.new(Offset, (1 / 0))
			tableData._columnBorders[0].Position = UDim2.fromOffset(Offset - 3, 0)
		end,
		ChildAdded = function(tableData, childElement)
			local _rowIndex = tableData._rowIndex
			local _columnIndex = tableData._columnIndex
			tableData._rowCycles[_rowIndex] = widgetInstance._cycleTick
			dirtyColumns[tableData][_columnIndex] = true
			if tableData._rowInstances[_rowIndex] == nil then
				local rowElement = GenerateRow(tableData, _rowIndex)
				if _rowIndex == 0 then
					rowElement.Visible = tableData.arguments.Header
				end
				rowElement.Parent = tableData._rowContainer
				if _rowIndex > 0 then
					local borderElement = GenerateRowBorder(tableData, _rowIndex - 1, if _rowIndex == 1 then "Strong" else "Light")
					local showBorder = tableData.arguments.InnerBorders
					if showBorder then
						showBorder = if _rowIndex == 1 then tableData.arguments.Header and tableData.arguments.InnerBorders and tableData._rowInstances[0] ~= nil else true
					end
					borderElement.Visible = showBorder
					tableData._rowBorders[_rowIndex - 1] = borderElement
					borderElement.Parent = tableData._rowContainer
				end
			end
			return tableData._cellInstances[_rowIndex][_columnIndex]
		end,
		ChildDiscarded = function(tableData, childElement)
			local parentFrame = childElement.Instance.Parent
			if parentFrame ~= nil then
				local parsedRowIndex = tonumber(parentFrame.Name:sub(6))
				if parsedRowIndex then
					dirtyColumns[tableData][parsedRowIndex] = true
				end
			end
		end,
		Discard = function(tableData)
			tableInstances[tableData.ID] = nil
			dirtyColumns[tableData] = nil
			tableData.Instance:Destroy()
			contextUtils.discardState(tableData)
		end
	})
end
