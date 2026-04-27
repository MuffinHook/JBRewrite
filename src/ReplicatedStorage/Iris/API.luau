require(script.Parent.Types)
return function(irisModule)
	local function wrapper(widgetType)
		return function(widgetArgs, widgetState)
			return irisModule.Internal._Insert(widgetType, widgetArgs, widgetState)
		end
	end
	local windowWidgetType = "Window"
	function irisModule.Window(widgetArgs, widgetState)
		return irisModule.Internal._Insert(windowWidgetType, widgetArgs, widgetState)
	end
	irisModule.SetFocusedWindow = irisModule.Internal.SetFocusedWindow
	local tooltipWidgetType = "Tooltip"
	function irisModule.Tooltip(widgetArgs, widgetState)
		return irisModule.Internal._Insert(tooltipWidgetType, widgetArgs, widgetState)
	end
	local menuBarWidgetType = "MenuBar"
	function irisModule.MenuBar(widgetArgs, widgetState)
		return irisModule.Internal._Insert(menuBarWidgetType, widgetArgs, widgetState)
	end
	local menuWidgetType = "Menu"
	function irisModule.Menu(widgetArgs, widgetState)
		return irisModule.Internal._Insert(menuWidgetType, widgetArgs, widgetState)
	end
	local menuItemWidgetType = "MenuItem"
	function irisModule.MenuItem(widgetArgs, widgetState)
		return irisModule.Internal._Insert(menuItemWidgetType, widgetArgs, widgetState)
	end
	local menuToggleWidgetType = "MenuToggle"
	function irisModule.MenuToggle(widgetArgs, widgetState)
		return irisModule.Internal._Insert(menuToggleWidgetType, widgetArgs, widgetState)
	end
	local separatorWidgetType = "Separator"
	function irisModule.Separator(widgetArgs, widgetState)
		return irisModule.Internal._Insert(separatorWidgetType, widgetArgs, widgetState)
	end
	local indentWidgetType = "Indent"
	function irisModule.Indent(widgetArgs, widgetState)
		return irisModule.Internal._Insert(indentWidgetType, widgetArgs, widgetState)
	end
	local sameLineWidgetType = "SameLine"
	function irisModule.SameLine(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sameLineWidgetType, widgetArgs, widgetState)
	end
	local groupWidgetType = "Group"
	function irisModule.Group(widgetArgs, widgetState)
		return irisModule.Internal._Insert(groupWidgetType, widgetArgs, widgetState)
	end
	local textWidgetType = "Text"
	function irisModule.Text(widgetArgs, widgetState)
		return irisModule.Internal._Insert(textWidgetType, widgetArgs, widgetState)
	end
	function irisModule.TextWrapped(widgetArgs)
		widgetArgs[2] = true
		return irisModule.Internal._Insert("Text", widgetArgs)
	end
	function irisModule.TextColored(widgetArgs)
		widgetArgs[3] = widgetArgs[2]
		widgetArgs[2] = nil
		return irisModule.Internal._Insert("Text", widgetArgs)
	end
	local separatorTextWidgetType = "SeparatorText"
	function irisModule.SeparatorText(widgetArgs, widgetState)
		return irisModule.Internal._Insert(separatorTextWidgetType, widgetArgs, widgetState)
	end
	local inputTextWidgetType = "InputText"
	function irisModule.InputText(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputTextWidgetType, widgetArgs, widgetState)
	end
	local buttonWidgetType = "Button"
	function irisModule.Button(widgetArgs, widgetState)
		return irisModule.Internal._Insert(buttonWidgetType, widgetArgs, widgetState)
	end
	local smallButtonWidgetType = "SmallButton"
	function irisModule.SmallButton(widgetArgs, widgetState)
		return irisModule.Internal._Insert(smallButtonWidgetType, widgetArgs, widgetState)
	end
	local checkboxWidgetType = "Checkbox"
	function irisModule.Checkbox(widgetArgs, widgetState)
		return irisModule.Internal._Insert(checkboxWidgetType, widgetArgs, widgetState)
	end
	local radioButtonWidgetType = "RadioButton"
	function irisModule.RadioButton(widgetArgs, widgetState)
		return irisModule.Internal._Insert(radioButtonWidgetType, widgetArgs, widgetState)
	end
	local imageWidgetType = "Image"
	function irisModule.Image(widgetArgs, widgetState)
		return irisModule.Internal._Insert(imageWidgetType, widgetArgs, widgetState)
	end
	local imageButtonWidgetType = "ImageButton"
	function irisModule.ImageButton(widgetArgs, widgetState)
		return irisModule.Internal._Insert(imageButtonWidgetType, widgetArgs, widgetState)
	end
	local treeWidgetType = "Tree"
	function irisModule.Tree(widgetArgs, widgetState)
		return irisModule.Internal._Insert(treeWidgetType, widgetArgs, widgetState)
	end
	local collapsingHeaderWidgetType = "CollapsingHeader"
	function irisModule.CollapsingHeader(widgetArgs, widgetState)
		return irisModule.Internal._Insert(collapsingHeaderWidgetType, widgetArgs, widgetState)
	end
	local tabBarWidgetType = "TabBar"
	function irisModule.TabBar(widgetArgs, widgetState)
		return irisModule.Internal._Insert(tabBarWidgetType, widgetArgs, widgetState)
	end
	local tabWidgetType = "Tab"
	function irisModule.Tab(widgetArgs, widgetState)
		return irisModule.Internal._Insert(tabWidgetType, widgetArgs, widgetState)
	end
	local inputNumWidgetType = "InputNum"
	function irisModule.InputNum(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputNumWidgetType, widgetArgs, widgetState)
	end
	local inputVector2WidgetType = "InputVector2"
	function irisModule.InputVector2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputVector2WidgetType, widgetArgs, widgetState)
	end
	local inputVector3WidgetType = "InputVector3"
	function irisModule.InputVector3(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputVector3WidgetType, widgetArgs, widgetState)
	end
	local inputUDimWidgetType = "InputUDim"
	function irisModule.InputUDim(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputUDimWidgetType, widgetArgs, widgetState)
	end
	local inputUDim2WidgetType = "InputUDim2"
	function irisModule.InputUDim2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputUDim2WidgetType, widgetArgs, widgetState)
	end
	local inputRectWidgetType = "InputRect"
	function irisModule.InputRect(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputRectWidgetType, widgetArgs, widgetState)
	end
	local dragNumWidgetType = "DragNum"
	function irisModule.DragNum(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragNumWidgetType, widgetArgs, widgetState)
	end
	local dragVector2WidgetType = "DragVector2"
	function irisModule.DragVector2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragVector2WidgetType, widgetArgs, widgetState)
	end
	local dragVector3WidgetType = "DragVector3"
	function irisModule.DragVector3(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragVector3WidgetType, widgetArgs, widgetState)
	end
	local dragUDimWidgetType = "DragUDim"
	function irisModule.DragUDim(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragUDimWidgetType, widgetArgs, widgetState)
	end
	local dragUDim2WidgetType = "DragUDim2"
	function irisModule.DragUDim2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragUDim2WidgetType, widgetArgs, widgetState)
	end
	local dragRectWidgetType = "DragRect"
	function irisModule.DragRect(widgetArgs, widgetState)
		return irisModule.Internal._Insert(dragRectWidgetType, widgetArgs, widgetState)
	end
	local inputColor3WidgetType = "InputColor3"
	function irisModule.InputColor3(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputColor3WidgetType, widgetArgs, widgetState)
	end
	local inputColor4WidgetType = "InputColor4"
	function irisModule.InputColor4(widgetArgs, widgetState)
		return irisModule.Internal._Insert(inputColor4WidgetType, widgetArgs, widgetState)
	end
	local sliderNumWidgetType = "SliderNum"
	function irisModule.SliderNum(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderNumWidgetType, widgetArgs, widgetState)
	end
	local sliderVector2WidgetType = "SliderVector2"
	function irisModule.SliderVector2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderVector2WidgetType, widgetArgs, widgetState)
	end
	local sliderVector3WidgetType = "SliderVector3"
	function irisModule.SliderVector3(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderVector3WidgetType, widgetArgs, widgetState)
	end
	local sliderUDimWidgetType = "SliderUDim"
	function irisModule.SliderUDim(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderUDimWidgetType, widgetArgs, widgetState)
	end
	local sliderUDim2WidgetType = "SliderUDim2"
	function irisModule.SliderUDim2(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderUDim2WidgetType, widgetArgs, widgetState)
	end
	local sliderRectWidgetType = "SliderRect"
	function irisModule.SliderRect(widgetArgs, widgetState)
		return irisModule.Internal._Insert(sliderRectWidgetType, widgetArgs, widgetState)
	end
	local selectableWidgetType = "Selectable"
	function irisModule.Selectable(widgetArgs, widgetState)
		return irisModule.Internal._Insert(selectableWidgetType, widgetArgs, widgetState)
	end
	local comboWidgetType = "Combo"
	function irisModule.Combo(widgetArgs, widgetState)
		return irisModule.Internal._Insert(comboWidgetType, widgetArgs, widgetState)
	end
	function irisModule.ComboArray(widgetArgs, widgetState, optionsArray)
		local comboResult = irisModule.Internal._Insert("Combo", widgetArgs, if widgetState == nil then irisModule.State(optionsArray[1]) else widgetState)
		local index = comboResult.state.index
		for optionIndex, optionValue in optionsArray do
			irisModule.Internal._Insert("Selectable", { optionValue, optionValue }, {
				index = index
			})
		end
		irisModule.End()
		return comboResult
	end
	function irisModule.ComboEnum(widgetArgs, widgetState, enumType)
		local comboResult = irisModule.Internal._Insert("Combo", widgetArgs, if widgetState == nil then irisModule.State(enumType:GetEnumItems()[1]) else widgetState)
		local index = comboResult.state.index
		for enumIndex, enumValue in enumType:GetEnumItems() do
			irisModule.Internal._Insert("Selectable", { enumValue.Name, enumValue }, {
				index = index
			})
		end
		irisModule.End()
		return comboResult
	end
	irisModule.InputEnum = irisModule.ComboEnum
	local progressBarWidgetType = "ProgressBar"
	function irisModule.ProgressBar(widgetArgs, widgetState)
		return irisModule.Internal._Insert(progressBarWidgetType, widgetArgs, widgetState)
	end
	local plotLinesWidgetType = "PlotLines"
	function irisModule.PlotLines(widgetArgs, widgetState)
		return irisModule.Internal._Insert(plotLinesWidgetType, widgetArgs, widgetState)
	end
	local plotHistogramWidgetType = "PlotHistogram"
	function irisModule.PlotHistogram(widgetArgs, widgetState)
		return irisModule.Internal._Insert(plotHistogramWidgetType, widgetArgs, widgetState)
	end
	local tableWidgetType = "Table"
	function irisModule.Table(widgetArgs, widgetState)
		return irisModule.Internal._Insert(tableWidgetType, widgetArgs, widgetState)
	end
	function irisModule.NextColumn()
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.NextColumn() can only called when directly within a table.")
		if parentWidget._columnIndex == parentWidget.arguments.NumColumns then
			parentWidget._columnIndex = 1
			parentWidget._rowIndex = parentWidget._rowIndex + 1
		else
			parentWidget._columnIndex = parentWidget._columnIndex + 1
		end
		return parentWidget._columnIndex
	end
	function irisModule.NextRow()
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.NextRow() can only called when directly within a table.")
		parentWidget._columnIndex = 1
		parentWidget._rowIndex = parentWidget._rowIndex + 1
		return parentWidget._rowIndex
	end
	function irisModule.SetColumnIndex(columnIndex)
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.SetColumnIndex() can only called when directly within a table.")
		assert(if columnIndex >= 1 then columnIndex <= parentWidget.arguments.NumColumns else false, (("The index must be between 1 and %*, inclusive."):format(parentWidget.arguments.NumColumns)))
		parentWidget._columnIndex = columnIndex
	end
	function irisModule.SetRowIndex(rowIndex)
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.SetRowIndex() can only called when directly within a table.")
		assert(rowIndex >= 1, "The index must be greater or equal to 1.")
		parentWidget._rowIndex = rowIndex
	end
	function irisModule.NextHeaderColumn()
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.NextHeaderColumn() can only called when directly within a table.")
		parentWidget._rowIndex = 0
		parentWidget._columnIndex = parentWidget._columnIndex % parentWidget.arguments.NumColumns + 1
		return parentWidget._columnIndex
	end
	function irisModule.SetHeaderColumnIndex(columnIndex)
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.SetHeaderColumnIndex() can only called when directly within a table.")
		assert(if columnIndex >= 1 then columnIndex <= parentWidget.arguments.NumColumns else false, (("The index must be between 1 and %*, inclusive."):format(parentWidget.arguments.NumColumns)))
		parentWidget._rowIndex = 0
		parentWidget._columnIndex = columnIndex
	end
	function irisModule.SetColumnWidth(columnIndex, newWidth)
		local parentWidget = irisModule.Internal._GetParentWidget()
		assert(parentWidget ~= nil, "Iris.SetColumnWidth() can only called when directly within a table.")
		assert(if columnIndex >= 1 then columnIndex <= parentWidget.arguments.NumColumns else false, (("The index must be between 1 and %*, inclusive."):format(parentWidget.arguments.NumColumns)))
		local previousWidth = parentWidget.state.widths.value[columnIndex]
		parentWidget.state.widths.value[columnIndex] = newWidth
		parentWidget.state.widths:set(parentWidget.state.widths.value, newWidth ~= previousWidth)
	end
end
