-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	p1.WidgetConstructor("ProgressBar", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Format = 2
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end),
			changed = {
				Init = function(p1) end,
				Get = function(p12)
					return p12.lastChangedTick == p1._cycleTick
				end
			}
		},
		Generate = function(p12)
			local Iris_ProgressBar = Instance.new("Frame")
			Iris_ProgressBar.Name = "Iris_ProgressBar"
			Iris_ProgressBar.AutomaticSize = Enum.AutomaticSize.Y
			Iris_ProgressBar.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_ProgressBar.BackgroundTransparency = 1
			p2.UIListLayout(Iris_ProgressBar, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Bar = Instance.new("Frame")
			Bar.Name = "Bar"
			Bar.AutomaticSize = Enum.AutomaticSize.Y
			Bar.Size = UDim2.new(p1._config.ContentWidth, p1._config.ContentHeight)
			Bar.BackgroundColor3 = p1._config.FrameBgColor
			Bar.BackgroundTransparency = p1._config.FrameBgTransparency
			Bar.BorderSizePixel = 0
			Bar.ClipsDescendants = true
			p2.applyFrameStyle(Bar, true)
			Bar.Parent = Iris_ProgressBar
			local Progress = Instance.new("TextLabel")
			Progress.Name = "Progress"
			Progress.AutomaticSize = Enum.AutomaticSize.Y
			Progress.Size = UDim2.new(UDim.new(0, 0), p1._config.ContentHeight)
			Progress.BackgroundColor3 = p1._config.PlotHistogramColor
			Progress.BackgroundTransparency = p1._config.PlotHistogramTransparency
			Progress.BorderSizePixel = 0
			p2.applyTextStyle(Progress)
			p2.UIPadding(Progress, p1._config.FramePadding)
			p2.UICorner(Progress, p1._config.FrameRounding)
			Progress.Text = ""
			Progress.Parent = Bar
			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.AutomaticSize = Enum.AutomaticSize.XY
			Value.Size = UDim2.new(UDim.new(0, 0), p1._config.ContentHeight)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.ZIndex = 1
			p2.applyTextStyle(Value)
			p2.UIPadding(Value, p1._config.FramePadding)
			Value.Parent = Bar
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 1
			p2.applyTextStyle(TextLabel)
			p2.UIPadding(Value, p1._config.FramePadding)
			TextLabel.Parent = Iris_ProgressBar
			return Iris_ProgressBar
		end,
		GenerateState = function(p12)
			if p12.state.progress == nil then
				p12.state.progress = p1._widgetState(p12, "Progress", 0)
			end
		end,
		Update = function(p1)
			local instance = p1.Instance
			local Bar = instance.Bar.Value
			if p1.arguments.Format ~= nil and typeof(p1.arguments.Format) == "string" then
				Bar.Text = p1.arguments.Format
			end
			instance.TextLabel.Text = p1.arguments.Text or "Progress Bar"
		end,
		UpdateState = function(p12)
			local Bar = p12.Instance.Bar
			local Progress = Bar.Progress
			local instance = Bar.Value
			local v2 = math.clamp(p12.state.progress.value, 0, 1)
			if Bar.AbsoluteSize.X * (1 - v2) < instance.AbsoluteSize.X then
				instance.AnchorPoint = Vector2.xAxis
				instance.Position = UDim2.fromScale(1, 0)
			else
				instance.AnchorPoint = Vector2.zero
				instance.Position = UDim2.fromScale(v2, 0)
			end
			Progress.Size = UDim2.new(UDim.new(v2, 0), Progress.Size.Height)
			if p12.arguments.Format == nil then
				instance.Text = string.format("%d%%", v2 * 100)
			else
				if typeof(p12.arguments.Format) == "string" then
					instance.Text = p12.arguments.Format
				else
					instance.Text = string.format("%d%%", v2 * 100)
				end
			end
			p12.lastChangedTick = p1._cycleTick + 1
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
	local function createLine(p12, p2)
		local Frame = Instance.new("Frame")
		Frame.Name = tostring(p2)
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = p1._config.PlotLinesColor
		Frame.BackgroundTransparency = p1._config.PlotLinesTransparency
		Frame.BorderSizePixel = 0
		Frame.Parent = p12
		return Frame
	end
	local function clearLine(p12)
		if p12.HoveredLine then
			p12.HoveredLine.BackgroundColor3 = p1._config.PlotLinesColor
			p12.HoveredLine.BackgroundTransparency = p1._config.PlotLinesTransparency
			p12.HoveredLine = false
			p12.state.hovered:set(nil)
		end
	end
	local function updateLine(p12, p22)
		local Plot = p12.Instance.Background.Plot
		local var4 = math.ceil((p2.getMouseLocation().X - (Plot.AbsolutePosition - p2.GuiOffset).X) / Plot.AbsoluteSize.X * #p12.Lines)
		local var5 = p12.Lines[var4]
		if var5 then
			if var5 ~= p12.HoveredLine and (not p22 and p12.HoveredLine) then
				p12.HoveredLine.BackgroundColor3 = p1._config.PlotLinesColor
				p12.HoveredLine.BackgroundTransparency = p1._config.PlotLinesTransparency
				p12.HoveredLine = false
				p12.state.hovered:set(nil)
			end
			local var6 = p12.state.values.value[var4]
			local var7 = p12.state.values.value[var4 + 1]
			if var6 and var7 and (math.floor(var6) == var6 and math.floor(var7) == var7) then
				p12.Tooltip.Text = ("%d: %d\n%d: %d"):format(var4, var6, var4 + 1, var7)
			elseif var6 and var7 then
				p12.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(var4, var6, var4 + 1, var7)
			end
			p12.HoveredLine = var5
			var5.BackgroundColor3 = p1._config.PlotLinesHoveredColor
			var5.BackgroundTransparency = p1._config.PlotLinesHoveredTransparency
			if p22 then
				p12.state.hovered.value = { var6, var7 }
				return
			end
			p12.state.hovered:set({ var6, var7 })
		end
	end
	p1.WidgetConstructor("PlotLines", {
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
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_PlotLines = Instance.new("Frame")
			Iris_PlotLines.Name = "Iris_PlotLines"
			Iris_PlotLines.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_PlotLines.BackgroundTransparency = 1
			Iris_PlotLines.BorderSizePixel = 0
			p2.UIListLayout(Iris_PlotLines, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Background = Instance.new("Frame")
			Background.Name = "Background"
			Background.Size = UDim2.new(p1._config.ContentWidth, UDim.new(1, 0))
			Background.BackgroundColor3 = p1._config.FrameBgColor
			Background.BackgroundTransparency = p1._config.FrameBgTransparency
			p2.applyFrameStyle(Background)
			Background.Parent = Iris_PlotLines
			local Plot = Instance.new("Frame")
			Plot.Name = "Plot"
			Plot.Size = UDim2.fromScale(1, 1)
			Plot.BackgroundTransparency = 1
			Plot.BorderSizePixel = 0
			Plot.ClipsDescendants = true
			Plot:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				p12.state.values.lastChangeTick = p1._cycleTick
				p1._widgets.PlotLines.UpdateState(p12)
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
			p2.applyTextStyle(OverlayText)
			OverlayText.Parent = Plot
			local Iris_Tooltip = Instance.new("TextLabel")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tooltip.Size = UDim2.fromOffset(0, 0)
			Iris_Tooltip.BackgroundColor3 = p1._config.PopupBgColor
			Iris_Tooltip.BackgroundTransparency = p1._config.PopupBgTransparency
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.Visible = false
			p2.applyTextStyle(Iris_Tooltip)
			p2.UIStroke(Iris_Tooltip, p1._config.PopupBorderSize, p1._config.BorderActiveColor, p1._config.BorderActiveTransparency)
			p2.UIPadding(Iris_Tooltip, p1._config.WindowPadding)
			if p1._config.PopupRounding > 0 then
				p2.UICorner(Iris_Tooltip, p1._config.PopupRounding)
			end
			local instance = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = instance and instance:FindFirstChild("TooltipContainer")
			p12.Tooltip = Iris_Tooltip
			p2.applyMouseMoved(Plot, function()
				updateLine(p12)
			end)
			p2.applyMouseLeave(Plot, function()
				local instance = p12
				if instance.HoveredLine then
					instance.HoveredLine.BackgroundColor3 = p1._config.PlotLinesColor
					instance.HoveredLine.BackgroundTransparency = p1._config.PlotLinesTransparency
					instance.HoveredLine = false
					instance.state.hovered:set(nil)
				end
			end)
			Plot.Parent = Background
			p12.Lines = {}
			p12.HoveredLine = false
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = 3
			TextLabel.LayoutOrder = 3
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_PlotLines
			return Iris_PlotLines
		end,
		GenerateState = function(p12)
			if p12.state.values == nil then
				p12.state.values = p1._widgetState(p12, "values", { 0, 1 })
			end
			if p12.state.hovered == nil then
				p12.state.hovered = p1._widgetState(p12, "hovered", nil)
			end
		end,
		Update = function(p1)
			local instance = p1.Instance
			instance.TextLabel.Text = p1.arguments.Text or "Plot Lines"
			instance.Background.Plot.OverlayText.Text = p1.arguments.TextOverlay or ""
			instance.Size = UDim2.new(1, 0, 0, p1.arguments.Height or 0)
		end,
		UpdateState = function(p12)
			if p12.state.hovered.lastChangeTick == p1._cycleTick then
				if p12.state.hovered.value then
					p12.Tooltip.Visible = true
				else
					p12.Tooltip.Visible = false
				end
			end
			if p12.state.values.lastChangeTick == p1._cycleTick then
				local Plot = p12.Instance.Background.Plot
				local value = p12.state.values.value
				local instance = #value - 1
				local v2 = #p12.Lines
				local var3 = p12.arguments.Min or (1 / 0)
				local var4 = p12.arguments.Max or (-1 / 0)
				if var3 == nil or var4 == nil then
					for var5, var6 in value do
						local var7 = math.min(var3, var6)
						var3, var4 = var7, math.max(var4, var6)
					end
				end
				if v2 < instance then
					for i = v2 + 1, instance do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame.BackgroundColor3 = p1._config.PlotLinesColor
						Frame.BackgroundTransparency = p1._config.PlotLinesTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(p12.Lines, Frame)
					end
				elseif instance < v2 then
					for j = instance + 1, v2 do
						local table9 = table.remove(p12.Lines)
						if table9 then
							table9:Destroy()
						end
					end
				end
				local AbsoluteSize = Plot.AbsoluteSize
				local var10 = var4 - var3
				for k = 1, instance do
					local instance13 = AbsoluteSize * Vector2.new((k - 1) / instance, (var4 - value[k]) / var10)
					local instance14 = AbsoluteSize * Vector2.new(k / instance, (var4 - value[k + 1]) / var10)
					local var15 = (instance13 + instance14) / 2
					p12.Lines[k].Size = UDim2.fromOffset((instance14 - instance13).Magnitude + 1, 1)
					p12.Lines[k].Position = UDim2.fromOffset(var15.X, var15.Y)
					p12.Lines[k].Rotation = math.atan2(instance14.Y - instance13.Y, instance14.X - instance13.X) * 57.29577951308232
				end
				if p12.HoveredLine then
					updateLine(p12, true)
				end
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p1.Tooltip:Destroy()
			p2.discardState(p1)
		end
	})
	local function createBlock(p12, p2)
		local Frame = Instance.new("Frame")
		Frame.Name = tostring(p2)
		Frame.BackgroundColor3 = p1._config.PlotHistogramColor
		Frame.BackgroundTransparency = p1._config.PlotHistogramTransparency
		Frame.BorderSizePixel = 0
		Frame.Parent = p12
		return Frame
	end
	local function clearBlock(p12)
		if p12.HoveredBlock then
			p12.HoveredBlock.BackgroundColor3 = p1._config.PlotHistogramColor
			p12.HoveredBlock.BackgroundTransparency = p1._config.PlotHistogramTransparency
			p12.HoveredBlock = false
			p12.state.hovered:set(nil)
		end
	end
	local function updateBlock(p12, p22)
		local Plot = p12.Instance.Background.Plot
		local var4 = math.ceil((p2.getMouseLocation().X - (Plot.AbsolutePosition - p2.GuiOffset).X) / Plot.AbsoluteSize.X * #p12.Blocks)
		local var5 = p12.Blocks[var4]
		if var5 then
			if var5 ~= p12.HoveredBlock and (not p22 and p12.HoveredBlock) then
				p12.HoveredBlock.BackgroundColor3 = p1._config.PlotHistogramColor
				p12.HoveredBlock.BackgroundTransparency = p1._config.PlotHistogramTransparency
				p12.HoveredBlock = false
				p12.state.hovered:set(nil)
			end
			local var6 = p12.state.values.value[var4]
			if var6 then
				p12.Tooltip.Text = if math.floor(var6) == var6 then ("%d: %d"):format(var4, var6) else ("%d: %.3f"):format(var4, var6)
			end
			p12.HoveredBlock = var5
			var5.BackgroundColor3 = p1._config.PlotHistogramHoveredColor
			var5.BackgroundTransparency = p1._config.PlotHistogramHoveredTransparency
			if p22 then
				p12.state.hovered.value = var6
				return
			end
			p12.state.hovered:set(var6)
		end
	end
	p1.WidgetConstructor("PlotHistogram", {
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
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_PlotHistogram = Instance.new("Frame")
			Iris_PlotHistogram.Name = "Iris_PlotHistogram"
			Iris_PlotHistogram.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_PlotHistogram.BackgroundTransparency = 1
			Iris_PlotHistogram.BorderSizePixel = 0
			p2.UIListLayout(Iris_PlotHistogram, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local Background = Instance.new("Frame")
			Background.Name = "Background"
			Background.Size = UDim2.new(p1._config.ContentWidth, UDim.new(1, 0))
			Background.BackgroundColor3 = p1._config.FrameBgColor
			Background.BackgroundTransparency = p1._config.FrameBgTransparency
			p2.applyFrameStyle(Background)
			Background.UIPadding.PaddingRight = UDim.new(0, p1._config.FramePadding.X - 1)
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
			p2.applyTextStyle(OverlayText)
			OverlayText.Parent = Plot
			local Iris_Tooltip = Instance.new("TextLabel")
			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Tooltip.Size = UDim2.fromOffset(0, 0)
			Iris_Tooltip.BackgroundColor3 = p1._config.PopupBgColor
			Iris_Tooltip.BackgroundTransparency = p1._config.PopupBgTransparency
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.Visible = false
			p2.applyTextStyle(Iris_Tooltip)
			p2.UIStroke(Iris_Tooltip, p1._config.PopupBorderSize, p1._config.BorderActiveColor, p1._config.BorderActiveTransparency)
			p2.UIPadding(Iris_Tooltip, p1._config.WindowPadding)
			if p1._config.PopupRounding > 0 then
				p2.UICorner(Iris_Tooltip, p1._config.PopupRounding)
			end
			local instance = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = instance and instance:FindFirstChild("TooltipContainer")
			p12.Tooltip = Iris_Tooltip
			p2.applyMouseMoved(Plot, function()
				updateBlock(p12)
			end)
			p2.applyMouseLeave(Plot, function()
				local instance = p12
				if instance.HoveredBlock then
					instance.HoveredBlock.BackgroundColor3 = p1._config.PlotHistogramColor
					instance.HoveredBlock.BackgroundTransparency = p1._config.PlotHistogramTransparency
					instance.HoveredBlock = false
					instance.state.hovered:set(nil)
				end
			end)
			Plot.Parent = Background
			p12.Blocks = {}
			p12.HoveredBlock = false
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = 3
			TextLabel.LayoutOrder = 3
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_PlotHistogram
			return Iris_PlotHistogram
		end,
		GenerateState = function(p12)
			if p12.state.values == nil then
				p12.state.values = p1._widgetState(p12, "values", { 1 })
			end
			if p12.state.hovered == nil then
				p12.state.hovered = p1._widgetState(p12, "hovered", nil)
			end
		end,
		Update = function(p1)
			local instance = p1.Instance
			instance.TextLabel.Text = p1.arguments.Text or "Plot Histogram"
			instance.Background.Plot.OverlayText.Text = p1.arguments.TextOverlay or ""
			instance.Size = UDim2.new(1, 0, 0, p1.arguments.Height or 0)
		end,
		UpdateState = function(p12)
			if p12.state.hovered.lastChangeTick == p1._cycleTick then
				if p12.state.hovered.value then
					p12.Tooltip.Visible = true
				else
					p12.Tooltip.Visible = false
				end
			end
			if p12.state.values.lastChangeTick == p1._cycleTick then
				local Plot = p12.Instance.Background.Plot
				local value = p12.state.values.value
				local instance = #value
				local v2 = #p12.Blocks
				local var3 = p12.arguments.Min or (1 / 0)
				local var4 = p12.arguments.Max or (-1 / 0)
				local var5 = p12.arguments.BaseLine or 0
				if var3 == nil or var4 == nil then
					for var6, var7 in value do
						local var8 = math.min(var3 or var7, var7)
						var3, var4 = var8, math.max(var4 or var7, var7)
					end
				end
				if v2 < instance then
					for i = v2 + 1, instance do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.BackgroundColor3 = p1._config.PlotHistogramColor
						Frame.BackgroundTransparency = p1._config.PlotHistogramTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(p12.Blocks, Frame)
					end
				elseif instance < v2 then
					for j = instance + 1, v2 do
						local var10 = table.remove(p12.Blocks)
						if var10 then
							var10:Destroy()
						end
					end
				end
				local instance11 = UDim.new(1 / instance, -1)
				local var12 = var4 - var3
				for k = 1, instance do
					local instance13 = value[k]
					if instance13 >= 0 then
						p12.Blocks[k].Size = UDim2.new(instance11, UDim.new((instance13 - var5) / var12))
						p12.Blocks[k].Position = UDim2.fromScale((k - 1) / instance, (var4 - instance13) / var12)
					else
						p12.Blocks[k].Size = UDim2.new(instance11, UDim.new((var5 - instance13) / var12))
						p12.Blocks[k].Position = UDim2.fromScale((k - 1) / instance, (var4 - var5) / var12)
					end
				end
				if p12.HoveredBlock then
					updateBlock(p12, true)
				end
			end
		end,
		Discard = function(p1)
			p1.Instance:Destroy()
			p1.Tooltip:Destroy()
			p2.discardState(p1)
		end
	})
end
