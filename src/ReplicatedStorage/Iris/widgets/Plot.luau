require(script.Parent.Parent.Types)
return function(iris, irisUtils)
	iris.WidgetConstructor("ProgressBar", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Format = 2
		},
		Events = {
			hovered = irisUtils.EVENTS.hover(function(widget)
				return widget.Instance
			end),
			changed = {
				Init = function(widget) end,
				Get = function(widget)
					return widget.lastChangedTick == iris._cycleTick
				end
			}
		},
		Generate = function(widget)
			local Iris_ProgressBar = Instance.new("Frame")
			Iris_ProgressBar.Name = "Iris_ProgressBar"
			Iris_ProgressBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_ProgressBar.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_ProgressBar.BackgroundTransparency = 1
			irisUtils.UIListLayout(Iris_ProgressBar, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Bar = Instance.new("Frame")
			Bar.Name = "Bar"
			Bar.AutomaticSize = Enum.AutomaticSize.Y
			Bar.Size = UDim2.new(iris._config.ContentWidth, iris._config.ContentHeight)
			Bar.BackgroundColor3 = iris._config.FrameBgColor
			Bar.BackgroundTransparency = iris._config.FrameBgTransparency
			Bar.BorderSizePixel = 0
			Bar.ClipsDescendants = true
			irisUtils.applyFrameStyle(Bar, true)
			Bar.Parent = Iris_ProgressBar
			local Progress = Instance.new("TextLabel")
			Progress.Name = "Progress"
			Progress.AutomaticSize = Enum.AutomaticSize.Y
			Progress.Size = UDim2.new(UDim.new(0, 0), iris._config.ContentHeight)
			Progress.BackgroundColor3 = iris._config.PlotHistogramColor
			Progress.BackgroundTransparency = iris._config.PlotHistogramTransparency
			Progress.BorderSizePixel = 0
			irisUtils.applyTextStyle(Progress)
			irisUtils.UIPadding(Progress, iris._config.FramePadding)
			irisUtils.UICorner(Progress, iris._config.FrameRounding)
			Progress.Text = ""
			Progress.Parent = Bar
			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.AutomaticSize = Enum.AutomaticSize.XY
			Value.Size = UDim2.new(UDim.new(0, 0), iris._config.ContentHeight)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.ZIndex = 1
			irisUtils.applyTextStyle(Value)
			irisUtils.UIPadding(Value, iris._config.FramePadding)
			Value.Parent = Bar
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			irisUtils.applyTextStyle(TextLabel)
			irisUtils.UIPadding(Value, iris._config.FramePadding)
			TextLabel.Parent = Iris_ProgressBar
			return Iris_ProgressBar
		end,
		GenerateState = function(widget)
			if widget.state.progress == nil then
				widget.state.progress = iris._widgetState(widget, "Progress", 0)
			end
		end,
		Update = function(widget)
			local instance = widget.Instance
			local Bar = instance.Bar.Value
			if widget.arguments.Format ~= nil and typeof(widget.arguments.Format) == "string" then
				Bar.Text = widget.arguments.Format
			end
			instance.TextLabel.Text = widget.arguments.Text or "Progress Bar"
		end,
		UpdateState = function(widget)
			local Bar = widget.Instance.Bar
			local Progress = Bar.Progress
			local instance = Bar.Value
			local progressValue = math.clamp(widget.state.progress.value, 0, 1)
			if Bar.AbsoluteSize.X * (1 - progressValue) < instance.AbsoluteSize.X then
				instance.AnchorPoint = Vector2.xAxis
				instance.Position = UDim2.fromScale(1, 0)
			else
				instance.AnchorPoint = Vector2.zero
				instance.Position = UDim2.fromScale(progressValue, 0)
			end
			Progress.Size = UDim2.new(UDim.new(progressValue, 0), Progress.Size.Height)
			if widget.arguments.Format == nil then
				instance.Text = string.format("%d%%", progressValue * 100)
			else
				if typeof(widget.arguments.Format) == "string" then
					instance.Text = widget.arguments.Format
				else
					instance.Text = string.format("%d%%", progressValue * 100)
				end
			end
			widget.lastChangedTick = iris._cycleTick + 1
		end,
		Discard = function(widget)
			widget.Instance:Destroy()
			irisUtils.discardState(widget)
		end
	})
	local function createLine(parent, lineIndex)
		local Frame = Instance.new("Frame")
		Frame.Name = tostring(lineIndex)
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = iris._config.PlotLinesColor
		Frame.BackgroundTransparency = iris._config.PlotLinesTransparency
		Frame.BorderSizePixel = 0
		Frame.Parent = parent
		return Frame
	end
	local function clearLine(widget)
		if widget.HoveredLine then
			widget.HoveredLine.BackgroundColor3 = iris._config.PlotLinesColor
			widget.HoveredLine.BackgroundTransparency = iris._config.PlotLinesTransparency
			widget.HoveredLine = false
			widget.state.hovered:set(nil)
		end
	end
	local function updateLine(widget, skipStateSet)
		local Plot = widget.Instance.Background.Plot
		local lineIndex = math.ceil((irisUtils.getMouseLocation().X - (Plot.AbsolutePosition - irisUtils.GuiOffset).X) / Plot.AbsoluteSize.X * #widget.Lines)
		local line = widget.Lines[lineIndex]
		if line then
			if line ~= widget.HoveredLine and (not skipStateSet and widget.HoveredLine) then
				widget.HoveredLine.BackgroundColor3 = iris._config.PlotLinesColor
				widget.HoveredLine.BackgroundTransparency = iris._config.PlotLinesTransparency
				widget.HoveredLine = false
				widget.state.hovered:set(nil)
			end
			local x = widget.state.values.value[lineIndex]
			local y = widget.state.values.value[lineIndex + 1]
			if x and y and (math.floor(x) == x and math.floor(y) == y) then
				widget.Tooltip.Text = ("%d: %d\n%d: %d"):format(lineIndex, x, lineIndex + 1, y)
			elseif x and y then
				widget.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(lineIndex, x, lineIndex + 1, y)
			end
			widget.HoveredLine = line
			line.BackgroundColor3 = iris._config.PlotLinesHoveredColor
			line.BackgroundTransparency = iris._config.PlotLinesHoveredTransparency
			if skipStateSet then
				widget.state.hovered.value = { x, y }
				return
			end
			widget.state.hovered:set({ x, y })
		end
	end
	iris.WidgetConstructor("PlotLines", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Height = 2,
			Min = 3,
			Max = 4,
			TextOverlay = 5
		},
		Events = {
			hovered = irisUtils.EVENTS.hover(function(widget)
				return widget.Instance
			end)
		},
		Generate = function(widget)
			local Iris_PlotLines = Instance.new("Frame")
			Iris_PlotLines.Name = "Iris_PlotLines"
			Iris_PlotLines.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_PlotLines.BackgroundTransparency = 1
			Iris_PlotLines.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_PlotLines, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Background = Instance.new("Frame")
			Background.Name = "Background"
			Background.Size = UDim2.new(iris._config.ContentWidth, UDim.new(1, 0))
			Background.BackgroundColor3 = iris._config.FrameBgColor
			Background.BackgroundTransparency = iris._config.FrameBgTransparency
			irisUtils.applyFrameStyle(Background)
			Background.Parent = Iris_PlotLines
			local Plot = Instance.new("Frame")
			Plot.Name = "Plot"
			Plot.Size = UDim2.fromScale(1, 1)
			Plot.BackgroundTransparency = 1
			Plot.BorderSizePixel = 0
			Plot.ClipsDescendants = true
			Plot:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				widget.state.values.lastChangeTick = iris._cycleTick
				iris._widgets.PlotLines.UpdateState(widget)
			end)
			local OverlayText = Instance.new("TextLabel")
			OverlayText.Name = "OverlayText"
			OverlayText.AutomaticSize = Enum.AutomaticSize.XY
			OverlayText.AnchorPoint = Vector2.new(0.5, 0)
			OverlayText.Size = UDim2.fromOffset(0, 0)
			OverlayText.Position = UDim2.fromScale(0.5, 0)
			OverlayText.BackgroundTransparency = 1
			OverlayText.BorderSizePixel = 0
			OverlayText.ZIndex = 2
			irisUtils.applyTextStyle(OverlayText)
			OverlayText.Parent = Plot
			local Iris_Tooltip = Instance.new("TextLabel")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tooltip.Size = UDim2.fromOffset(0, 0)
			Iris_Tooltip.BackgroundColor3 = iris._config.PopupBgColor
			Iris_Tooltip.BackgroundTransparency = iris._config.PopupBgTransparency
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.Visible = false
			irisUtils.applyTextStyle(Iris_Tooltip)
			irisUtils.UIStroke(Iris_Tooltip, iris._config.PopupBorderSize, iris._config.BorderActiveColor, iris._config.BorderActiveTransparency)
			irisUtils.UIPadding(Iris_Tooltip, iris._config.WindowPadding)
			if iris._config.PopupRounding > 0 then
				irisUtils.UICorner(Iris_Tooltip, iris._config.PopupRounding)
			end
			local instance = iris._rootInstance and iris._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = instance and instance:FindFirstChild("TooltipContainer")
			widget.Tooltip = Iris_Tooltip
			irisUtils.applyMouseMoved(Plot, function()
				updateLine(widget)
			end)
			irisUtils.applyMouseLeave(Plot, function()
				local instance = widget
				if instance.HoveredLine then
					instance.HoveredLine.BackgroundColor3 = iris._config.PlotLinesColor
					instance.HoveredLine.BackgroundTransparency = iris._config.PlotLinesTransparency
					instance.HoveredLine = false
					instance.state.hovered:set(nil)
				end
			end)
			Plot.Parent = Background
			widget.Lines = {}
			widget.HoveredLine = false
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = 3
			TextLabel.LayoutOrder = 3
			irisUtils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_PlotLines
			return Iris_PlotLines
		end,
		GenerateState = function(widget)
			if widget.state.values == nil then
				widget.state.values = iris._widgetState(widget, "values", { 0, 1 })
			end
			if widget.state.hovered == nil then
				widget.state.hovered = iris._widgetState(widget, "hovered", nil)
			end
		end,
		Update = function(widget)
			local instance = widget.Instance
			instance.TextLabel.Text = widget.arguments.Text or "Plot Lines"
			instance.Background.Plot.OverlayText.Text = widget.arguments.TextOverlay or ""
			instance.Size = UDim2.new(1, 0, 0, widget.arguments.Height or 0)
		end,
		UpdateState = function(widget)
			if widget.state.hovered.lastChangeTick == iris._cycleTick then
				if widget.state.hovered.value then
					widget.Tooltip.Visible = true
				else
					widget.Tooltip.Visible = false
				end
			end
			if widget.state.values.lastChangeTick == iris._cycleTick then
				local Plot = widget.Instance.Background.Plot
				local value = widget.state.values.value
				local valueCount = #value - 1
				local lineCount = #widget.Lines
				local minValue = widget.arguments.Min or (1 / 0)
				local maxValue = widget.arguments.Max or (-1 / 0)
				if minValue == nil or maxValue == nil then
					for valueIndex, valueData in value do
						local minResult = math.min(minValue, valueData)
						minValue, maxValue = minResult, math.max(maxValue, valueData)
					end
				end
				if lineCount < valueCount then
					for i = lineCount + 1, valueCount do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame.BackgroundColor3 = iris._config.PlotLinesColor
						Frame.BackgroundTransparency = iris._config.PlotLinesTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(widget.Lines, Frame)
					end
				elseif valueCount < lineCount then
					for j = valueCount + 1, lineCount do
						local removedLine = table.remove(widget.Lines)
						if removedLine then
							removedLine:Destroy()
						end
					end
				end
				local PlotSize = Plot.AbsoluteSize
				local heightRange = maxValue - minValue
				for k = 1, valueCount do
					local startPoint = PlotSize * Vector2.new((k - 1) / valueCount, (maxValue - value[k]) / heightRange)
					local endPoint = PlotSize * Vector2.new(k / valueCount, (maxValue - value[k + 1]) / heightRange)
					local centerPoint = (startPoint + endPoint) / 2
					widget.Lines[k].Size = UDim2.fromOffset((endPoint - startPoint).Magnitude + 1, 1)
					widget.Lines[k].Position = UDim2.fromOffset(centerPoint.X, centerPoint.Y)
					widget.Lines[k].Rotation = math.atan2(endPoint.Y - startPoint.Y, endPoint.X - startPoint.X) * 57.29577951308232
				end
				if widget.HoveredLine then
					updateLine(widget, true)
				end
			end
		end,
		Discard = function(widget)
			widget.Instance:Destroy()
			widget.Tooltip:Destroy()
			irisUtils.discardState(widget)
		end
	})
	local function createBlock(parent, blockIndex)
		local Frame = Instance.new("Frame")
		Frame.Name = tostring(blockIndex)
		Frame.BackgroundColor3 = iris._config.PlotHistogramColor
		Frame.BackgroundTransparency = iris._config.PlotHistogramTransparency
		Frame.BorderSizePixel = 0
		Frame.Parent = parent
		return Frame
	end
	local function clearBlock(widget)
		if widget.HoveredBlock then
			widget.HoveredBlock.BackgroundColor3 = iris._config.PlotHistogramColor
			widget.HoveredBlock.BackgroundTransparency = iris._config.PlotHistogramTransparency
			widget.HoveredBlock = false
			widget.state.hovered:set(nil)
		end
	end
	local function updateBlock(widget, skipStateSet)
		local Plot = widget.Instance.Background.Plot
		local blockIndex = math.ceil((irisUtils.getMouseLocation().X - (Plot.AbsolutePosition - irisUtils.GuiOffset).X) / Plot.AbsoluteSize.X * #widget.Blocks)
		local block = widget.Blocks[blockIndex]
		if block then
			if block ~= widget.HoveredBlock and (not skipStateSet and widget.HoveredBlock) then
				widget.HoveredBlock.BackgroundColor3 = iris._config.PlotHistogramColor
				widget.HoveredBlock.BackgroundTransparency = iris._config.PlotHistogramTransparency
				widget.HoveredBlock = false
				widget.state.hovered:set(nil)
			end
			local blockValue = widget.state.values.value[blockIndex]
			if blockValue then
				widget.Tooltip.Text = if math.floor(blockValue) == blockValue then ("%d: %d"):format(blockIndex, blockValue) else ("%d: %.3f"):format(blockIndex, blockValue)
			end
			widget.HoveredBlock = block
			block.BackgroundColor3 = iris._config.PlotHistogramHoveredColor
			block.BackgroundTransparency = iris._config.PlotHistogramHoveredTransparency
			if skipStateSet then
				widget.state.hovered.value = blockValue
				return
			end
			widget.state.hovered:set(blockValue)
		end
	end
	iris.WidgetConstructor("PlotHistogram", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Height = 2,
			Min = 3,
			Max = 4,
			TextOverlay = 5,
			BaseLine = 6
		},
		Events = {
			hovered = irisUtils.EVENTS.hover(function(widget)
				return widget.Instance
			end)
		},
		Generate = function(widget)
			local Iris_PlotHistogram = Instance.new("Frame")
			Iris_PlotHistogram.Name = "Iris_PlotHistogram"
			Iris_PlotHistogram.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_PlotHistogram.BackgroundTransparency = 1
			Iris_PlotHistogram.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_PlotHistogram, Enum.FillDirection.Horizontal, UDim.new(0, iris._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Background = Instance.new("Frame")
			Background.Name = "Background"
			Background.Size = UDim2.new(iris._config.ContentWidth, UDim.new(1, 0))
			Background.BackgroundColor3 = iris._config.FrameBgColor
			Background.BackgroundTransparency = iris._config.FrameBgTransparency
			irisUtils.applyFrameStyle(Background)
			Background.UIPadding.PaddingRight = UDim.new(0, iris._config.FramePadding.X - 1)
			Background.Parent = Iris_PlotHistogram
			local Plot = Instance.new("Frame")
			Plot.Name = "Plot"
			Plot.Size = UDim2.fromScale(1, 1)
			Plot.BackgroundTransparency = 1
			Plot.BorderSizePixel = 0
			Plot.ClipsDescendants = true
			local OverlayText = Instance.new("TextLabel")
			OverlayText.Name = "OverlayText"
			OverlayText.AutomaticSize = Enum.AutomaticSize.XY
			OverlayText.AnchorPoint = Vector2.new(0.5, 0)
			OverlayText.Size = UDim2.fromOffset(0, 0)
			OverlayText.Position = UDim2.fromScale(0.5, 0)
			OverlayText.BackgroundTransparency = 1
			OverlayText.BorderSizePixel = 0
			OverlayText.ZIndex = 2
			irisUtils.applyTextStyle(OverlayText)
			OverlayText.Parent = Plot
			local Iris_Tooltip = Instance.new("TextLabel")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tooltip.Size = UDim2.fromOffset(0, 0)
			Iris_Tooltip.BackgroundColor3 = iris._config.PopupBgColor
			Iris_Tooltip.BackgroundTransparency = iris._config.PopupBgTransparency
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.Visible = false
			irisUtils.applyTextStyle(Iris_Tooltip)
			irisUtils.UIStroke(Iris_Tooltip, iris._config.PopupBorderSize, iris._config.BorderActiveColor, iris._config.BorderActiveTransparency)
			irisUtils.UIPadding(Iris_Tooltip, iris._config.WindowPadding)
			if iris._config.PopupRounding > 0 then
				irisUtils.UICorner(Iris_Tooltip, iris._config.PopupRounding)
			end
			local instance = iris._rootInstance and iris._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = instance and instance:FindFirstChild("TooltipContainer")
			widget.Tooltip = Iris_Tooltip
			irisUtils.applyMouseMoved(Plot, function()
				updateBlock(widget)
			end)
			irisUtils.applyMouseLeave(Plot, function()
				local instance = widget
				if instance.HoveredBlock then
					instance.HoveredBlock.BackgroundColor3 = iris._config.PlotHistogramColor
					instance.HoveredBlock.BackgroundTransparency = iris._config.PlotHistogramTransparency
					instance.HoveredBlock = false
					instance.state.hovered:set(nil)
				end
			end)
			Plot.Parent = Background
			widget.Blocks = {}
			widget.HoveredBlock = false
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = 3
			TextLabel.LayoutOrder = 3
			irisUtils.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_PlotHistogram
			return Iris_PlotHistogram
		end,
		GenerateState = function(widget)
			if widget.state.values == nil then
				widget.state.values = iris._widgetState(widget, "values", { 1 })
			end
			if widget.state.hovered == nil then
				widget.state.hovered = iris._widgetState(widget, "hovered", nil)
			end
		end,
		Update = function(widget)
			local instance = widget.Instance
			instance.TextLabel.Text = widget.arguments.Text or "Plot Histogram"
			instance.Background.Plot.OverlayText.Text = widget.arguments.TextOverlay or ""
			instance.Size = UDim2.new(1, 0, 0, widget.arguments.Height or 0)
		end,
		UpdateState = function(widget)
			if widget.state.hovered.lastChangeTick == iris._cycleTick then
				if widget.state.hovered.value then
					widget.Tooltip.Visible = true
				else
					widget.Tooltip.Visible = false
				end
			end
			if widget.state.values.lastChangeTick == iris._cycleTick then
				local Plot = widget.Instance.Background.Plot
				local value = widget.state.values.value
				local valueCount = #value
				local blockCount = #widget.Blocks
				local minValue = widget.arguments.Min or (1 / 0)
				local maxValue = widget.arguments.Max or (-1 / 0)
				local baselineValue = widget.arguments.BaseLine or 0
				if minValue == nil or maxValue == nil then
					for valueIndex, valueData in value do
						local minResult = math.min(minValue or valueData, valueData)
						minValue, maxValue = minResult, math.max(maxValue or valueData, valueData)
					end
				end
				if blockCount < valueCount then
					for i = blockCount + 1, valueCount do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.BackgroundColor3 = iris._config.PlotHistogramColor
						Frame.BackgroundTransparency = iris._config.PlotHistogramTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(widget.Blocks, Frame)
					end
				elseif valueCount < blockCount then
					for j = valueCount + 1, blockCount do
						local removedBlock = table.remove(widget.Blocks)
						if removedBlock then
							removedBlock:Destroy()
						end
					end
				end
				local blockWidth = UDim.new(1 / valueCount, -1)
				local heightRange = maxValue - minValue
				for k = 1, valueCount do
					local blockValue = value[k]
					if blockValue >= 0 then
						widget.Blocks[k].Size = UDim2.new(blockWidth, UDim.new((blockValue - baselineValue) / heightRange))
						widget.Blocks[k].Position = UDim2.fromScale((k - 1) / valueCount, (maxValue - blockValue) / heightRange)
					else
						widget.Blocks[k].Size = UDim2.new(blockWidth, UDim.new((baselineValue - blockValue) / heightRange))
						widget.Blocks[k].Position = UDim2.fromScale((k - 1) / valueCount, (maxValue - baselineValue) / heightRange)
					end
				end
				if widget.HoveredBlock then
					updateBlock(widget, true)
				end
			end
		end,
		Discard = function(widget)
			widget.Instance:Destroy()
			widget.Tooltip:Destroy()
			irisUtils.discardState(widget)
		end
	})
end
