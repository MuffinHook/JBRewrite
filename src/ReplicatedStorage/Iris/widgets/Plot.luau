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
			local v1 = p1.Instance
			local Bar = v1.Bar.Value
			if p1.arguments.Format ~= nil and typeof(p1.arguments.Format) == "string" then
				Bar.Text = p1.arguments.Format
			end
			v1.TextLabel.Text = p1.arguments.Text or "Progress Bar"
		end,
		UpdateState = function(p12)
			local Bar = p12.Instance.Bar
			local Progress = Bar.Progress
			local v1 = Bar.Value
			local v2 = math.clamp(p12.state.progress.value, 0, 1)
			if Bar.AbsoluteSize.X * (1 - v2) < v1.AbsoluteSize.X then
				v1.AnchorPoint = Vector2.xAxis
				v1.Position = UDim2.fromScale(1, 0)
			else
				v1.AnchorPoint = Vector2.zero
				v1.Position = UDim2.fromScale(v2, 0)
			end
			Progress.Size = UDim2.new(UDim.new(v2, 0), Progress.Size.Height)
			if p12.arguments.Format == nil then
				v1.Text = string.format("%d%%", v2 * 100)
			else
				if typeof(p12.arguments.Format) == "string" then
					v1.Text = p12.arguments.Format
				else
					v1.Text = string.format("%d%%", v2 * 100)
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
		local v4 = math.ceil((p2.getMouseLocation().X - (Plot.AbsolutePosition - p2.GuiOffset).X) / Plot.AbsoluteSize.X * #p12.Lines)
		local v5 = p12.Lines[v4]
		if v5 then
			if v5 ~= p12.HoveredLine and (not p22 and p12.HoveredLine) then
				p12.HoveredLine.BackgroundColor3 = p1._config.PlotLinesColor
				p12.HoveredLine.BackgroundTransparency = p1._config.PlotLinesTransparency
				p12.HoveredLine = false
				p12.state.hovered:set(nil)
			end
			local v6 = p12.state.values.value[v4]
			local v7 = p12.state.values.value[v4 + 1]
			if v6 and v7 and (math.floor(v6) == v6 and math.floor(v7) == v7) then
				p12.Tooltip.Text = ("%d: %d\n%d: %d"):format(v4, v6, v4 + 1, v7)
			elseif v6 and v7 then
				p12.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(v4, v6, v4 + 1, v7)
			end
			p12.HoveredLine = v5
			v5.BackgroundColor3 = p1._config.PlotLinesHoveredColor
			v5.BackgroundTransparency = p1._config.PlotLinesHoveredTransparency
			if p22 then
				p12.state.hovered.value = { v6, v7 }
				return
			end
			p12.state.hovered:set({ v6, v7 })
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
			local v1 = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = v1 and v1:FindFirstChild("TooltipContainer")
			p12.Tooltip = Iris_Tooltip
			p2.applyMouseMoved(Plot, function()
				updateLine(p12)
			end)
			p2.applyMouseLeave(Plot, function()
				local v1 = p12
				if v1.HoveredLine then
					v1.HoveredLine.BackgroundColor3 = p1._config.PlotLinesColor
					v1.HoveredLine.BackgroundTransparency = p1._config.PlotLinesTransparency
					v1.HoveredLine = false
					v1.state.hovered:set(nil)
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
			local v1 = p1.Instance
			v1.TextLabel.Text = p1.arguments.Text or "Plot Lines"
			v1.Background.Plot.OverlayText.Text = p1.arguments.TextOverlay or ""
			v1.Size = UDim2.new(1, 0, 0, p1.arguments.Height or 0)
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
				local v1 = #value - 1
				local v2 = #p12.Lines
				local v3 = p12.arguments.Min or (1 / 0)
				local v4 = p12.arguments.Max or (-1 / 0)
				if v3 == nil or v4 == nil then
					for v5, v6 in value do
						local v7 = math.min(v3, v6)
						v3, v4 = v7, math.max(v4, v6)
					end
				end
				if v2 < v1 then
					for i = v2 + 1, v1 do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame.BackgroundColor3 = p1._config.PlotLinesColor
						Frame.BackgroundTransparency = p1._config.PlotLinesTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(p12.Lines, Frame)
					end
				elseif v1 < v2 then
					for j = v1 + 1, v2 do
						local v9 = table.remove(p12.Lines)
						if v9 then
							v9:Destroy()
						end
					end
				end
				local AbsoluteSize = Plot.AbsoluteSize
				local v10 = v4 - v3
				for k = 1, v1 do
					local v13 = AbsoluteSize * Vector2.new((k - 1) / v1, (v4 - value[k]) / v10)
					local v14 = AbsoluteSize * Vector2.new(k / v1, (v4 - value[k + 1]) / v10)
					local v15 = (v13 + v14) / 2
					p12.Lines[k].Size = UDim2.fromOffset((v14 - v13).Magnitude + 1, 1)
					p12.Lines[k].Position = UDim2.fromOffset(v15.X, v15.Y)
					p12.Lines[k].Rotation = math.atan2(v14.Y - v13.Y, v14.X - v13.X) * 57.29577951308232
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
		local v4 = math.ceil((p2.getMouseLocation().X - (Plot.AbsolutePosition - p2.GuiOffset).X) / Plot.AbsoluteSize.X * #p12.Blocks)
		local v5 = p12.Blocks[v4]
		if v5 then
			if v5 ~= p12.HoveredBlock and (not p22 and p12.HoveredBlock) then
				p12.HoveredBlock.BackgroundColor3 = p1._config.PlotHistogramColor
				p12.HoveredBlock.BackgroundTransparency = p1._config.PlotHistogramTransparency
				p12.HoveredBlock = false
				p12.state.hovered:set(nil)
			end
			local v6 = p12.state.values.value[v4]
			if v6 then
				p12.Tooltip.Text = if math.floor(v6) == v6 then ("%d: %d"):format(v4, v6) else ("%d: %.3f"):format(v4, v6)
			end
			p12.HoveredBlock = v5
			v5.BackgroundColor3 = p1._config.PlotHistogramHoveredColor
			v5.BackgroundTransparency = p1._config.PlotHistogramHoveredTransparency
			if p22 then
				p12.state.hovered.value = v6
				return
			end
			p12.state.hovered:set(v6)
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
			local v1 = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			Iris_Tooltip.Parent = v1 and v1:FindFirstChild("TooltipContainer")
			p12.Tooltip = Iris_Tooltip
			p2.applyMouseMoved(Plot, function()
				updateBlock(p12)
			end)
			p2.applyMouseLeave(Plot, function()
				local v1 = p12
				if v1.HoveredBlock then
					v1.HoveredBlock.BackgroundColor3 = p1._config.PlotHistogramColor
					v1.HoveredBlock.BackgroundTransparency = p1._config.PlotHistogramTransparency
					v1.HoveredBlock = false
					v1.state.hovered:set(nil)
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
			local v1 = p1.Instance
			v1.TextLabel.Text = p1.arguments.Text or "Plot Histogram"
			v1.Background.Plot.OverlayText.Text = p1.arguments.TextOverlay or ""
			v1.Size = UDim2.new(1, 0, 0, p1.arguments.Height or 0)
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
				local v1 = #value
				local v2 = #p12.Blocks
				local v3 = p12.arguments.Min or (1 / 0)
				local v4 = p12.arguments.Max or (-1 / 0)
				local v5 = p12.arguments.BaseLine or 0
				if v3 == nil or v4 == nil then
					for v6, v7 in value do
						local v8 = math.min(v3 or v7, v7)
						v3, v4 = v8, math.max(v4 or v7, v7)
					end
				end
				if v2 < v1 then
					for i = v2 + 1, v1 do
						local Frame = Instance.new("Frame")
						Frame.Name = tostring(i)
						Frame.BackgroundColor3 = p1._config.PlotHistogramColor
						Frame.BackgroundTransparency = p1._config.PlotHistogramTransparency
						Frame.BorderSizePixel = 0
						Frame.Parent = Plot
						table.insert(p12.Blocks, Frame)
					end
				elseif v1 < v2 then
					for j = v1 + 1, v2 do
						local v10 = table.remove(p12.Blocks)
						if v10 then
							v10:Destroy()
						end
					end
				end
				local v11 = UDim.new(1 / v1, -1)
				local v12 = v4 - v3
				for k = 1, v1 do
					local v13 = value[k]
					if v13 >= 0 then
						p12.Blocks[k].Size = UDim2.new(v11, UDim.new((v13 - v5) / v12))
						p12.Blocks[k].Position = UDim2.fromScale((k - 1) / v1, (v4 - v13) / v12)
					else
						p12.Blocks[k].Size = UDim2.new(v11, UDim.new((v5 - v13) / v12))
						p12.Blocks[k].Position = UDim2.fromScale((k - 1) / v1, (v4 - v5) / v12)
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
