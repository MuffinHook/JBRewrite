return function(arg1, arg2) -- Line 3
    local tbl = {
        hasState = true;
        hasChildren = false;
        Args = {
            Text = 1;
            Format = 2;
        };
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_2) -- Line 13
                return arg1_2.Instance
            end);
            changed = {
                Init = function(arg1_3) -- Line 17
                end;
                Get = function(arg1_4) -- Line 18
                    local var9
                    if arg1_4.lastChangedTick ~= arg1._cycleTick then
                        var9 = false
                    else
                        var9 = true
                    end
                    return var9
                end;
            };
        };
    }
    local function Generate(arg1_5) -- Line 23
        local Frame = Instance.new("Frame")
        Frame.Name = "Iris_ProgressBar"
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame.BackgroundTransparency = 1
        arg2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        local Frame_10 = Instance.new("Frame")
        Frame_10.Name = "Bar"
        Frame_10.AutomaticSize = Enum.AutomaticSize.Y
        Frame_10.Size = UDim2.new(arg1._config.ContentWidth, arg1._config.ContentHeight)
        Frame_10.BackgroundColor3 = arg1._config.FrameBgColor
        Frame_10.BackgroundTransparency = arg1._config.FrameBgTransparency
        Frame_10.BorderSizePixel = 0
        Frame_10.ClipsDescendants = true
        arg2.applyFrameStyle(Frame_10, true)
        Frame_10.Parent = Frame
        local TextLabel_8 = Instance.new("TextLabel")
        TextLabel_8.Name = "Progress"
        TextLabel_8.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel_8.Size = UDim2.new(UDim.new(0, 0), arg1._config.ContentHeight)
        TextLabel_8.BackgroundColor3 = arg1._config.PlotHistogramColor
        TextLabel_8.BackgroundTransparency = arg1._config.PlotHistogramTransparency
        TextLabel_8.BorderSizePixel = 0
        arg2.applyTextStyle(TextLabel_8)
        arg2.UIPadding(TextLabel_8, arg1._config.FramePadding)
        arg2.UICorner(TextLabel_8, arg1._config.FrameRounding)
        TextLabel_8.Text = ""
        TextLabel_8.Parent = Frame_10
        local TextLabel_5 = Instance.new("TextLabel")
        TextLabel_5.Name = "Value"
        TextLabel_5.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_5.Size = UDim2.new(UDim.new(0, 0), arg1._config.ContentHeight)
        TextLabel_5.BackgroundTransparency = 1
        TextLabel_5.BorderSizePixel = 0
        TextLabel_5.ZIndex = 1
        arg2.applyTextStyle(TextLabel_5)
        arg2.UIPadding(TextLabel_5, arg1._config.FramePadding)
        TextLabel_5.Parent = Frame_10
        local TextLabel_7 = Instance.new("TextLabel")
        TextLabel_7.Name = "TextLabel"
        TextLabel_7.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_7.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel_7.BackgroundTransparency = 1
        TextLabel_7.BorderSizePixel = 0
        TextLabel_7.LayoutOrder = 1
        arg2.applyTextStyle(TextLabel_7)
        arg2.UIPadding(TextLabel_5, arg1._config.FramePadding)
        TextLabel_7.Parent = Frame
        return Frame
    end
    tbl.Generate = Generate
    local function GenerateState(arg1_6) -- Line 88
        if arg1_6.state.progress == nil then
            arg1_6.state.progress = arg1._widgetState(arg1_6, "Progress", 0)
        end
    end
    tbl.GenerateState = GenerateState
    local function Update(arg1_7) -- Line 93
        local Instance_3 = arg1_7.Instance
        if arg1_7.arguments.Format ~= nil and typeof(arg1_7.arguments.Format) == "string" then
            Instance_3.Bar.Value.Text = arg1_7.arguments.Format
        end
        Instance_3.TextLabel.Text = arg1_7.arguments.Text or "Progress Bar"
    end
    tbl.Update = Update
    local function UpdateState(arg1_8) -- Line 105
        local Bar = arg1_8.Instance.Bar
        local Progress = Bar.Progress
        local Value = Bar.Value
        local clamped = math.clamp(arg1_8.state.progress.value, 0, 1)
        if Bar.AbsoluteSize.X * (1 - clamped) < Value.AbsoluteSize.X then
            Value.AnchorPoint = Vector2.xAxis
            Value.Position = UDim2.fromScale(1, 0)
        else
            Value.AnchorPoint = Vector2.zero
            Value.Position = UDim2.fromScale(clamped, 0)
        end
        Progress.Size = UDim2.new(UDim.new(clamped, 0), Progress.Size.Height)
        if arg1_8.arguments.Format ~= nil and typeof(arg1_8.arguments.Format) == "string" then
            Value.Text = arg1_8.arguments.Format
        else
            Value.Text = string.format("%d%%", clamped * 100)
        end
        arg1_8.lastChangedTick = arg1._cycleTick + 1
    end
    tbl.UpdateState = UpdateState
    local function Discard(arg1_9) -- Line 130
        arg1_9.Instance:Destroy()
        arg2.discardState(arg1_9)
    end
    tbl.Discard = Discard
    arg1.WidgetConstructor("ProgressBar", tbl)
    local function _(arg1_10, arg2_2) -- Line 136, Named "createLine"
        local Frame_11 = Instance.new("Frame")
        Frame_11.Name = tostring(arg2_2)
        Frame_11.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame_11.BackgroundColor3 = arg1._config.PlotLinesColor
        Frame_11.BackgroundTransparency = arg1._config.PlotLinesTransparency
        Frame_11.BorderSizePixel = 0
        Frame_11.Parent = arg1_10
        return Frame_11
    end
    local function _(arg1_11) -- Line 149, Named "clearLine"
        if arg1_11.HoveredLine then
            arg1_11.HoveredLine.BackgroundColor3 = arg1._config.PlotLinesColor
            arg1_11.HoveredLine.BackgroundTransparency = arg1._config.PlotLinesTransparency
            arg1_11.HoveredLine = false
            arg1_11.state.hovered:set(nil)
        end
    end
    local function updateLine_upvr(arg1_12, arg2_3) -- Line 158, Named "updateLine"
        local Plot = arg1_12.Instance.Background.Plot
        local ceiled = math.ceil((arg2.getMouseLocation().X - (Plot.AbsolutePosition - arg2.GuiOffset).X) / Plot.AbsoluteSize.X * #arg1_12.Lines)
        local var23 = arg1_12.Lines[ceiled]
        if var23 then
            if var23 ~= arg1_12.HoveredLine and not arg2_3 and arg1_12.HoveredLine then
                arg1_12.HoveredLine.BackgroundColor3 = arg1._config.PlotLinesColor
                arg1_12.HoveredLine.BackgroundTransparency = arg1._config.PlotLinesTransparency
                arg1_12.HoveredLine = false
                arg1_12.state.hovered:set(nil)
            end
            local var24 = arg1_12.state.values.value[ceiled]
            local var25 = arg1_12.state.values.value[ceiled + 1]
            if var24 and var25 then
                if math.floor(var24) == var24 and math.floor(var25) == var25 then
                    arg1_12.Tooltip.Text = string.format("%d: %d\n%d: %d", ceiled, var24, ceiled + 1, var25)
                else
                    arg1_12.Tooltip.Text = string.format("%d: %.3f\n%d: %.3f", ceiled, var24, ceiled + 1, var25)
                end
            end
            arg1_12.HoveredLine = var23
            var23.BackgroundColor3 = arg1._config.PlotLinesHoveredColor
            var23.BackgroundTransparency = arg1._config.PlotLinesHoveredTransparency
            if arg2_3 then
                arg1_12.state.hovered.value = {var24, var25}
                return
            end
            arg1_12.state.hovered:set({var24, var25})
        end
    end
    local tbl_3 = {
        hasState = true;
        hasChildren = false;
        Args = {
            Text = 1;
            Height = 2;
            Min = 3;
            Max = 4;
            TextOverlay = 5;
        };
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_13) -- Line 206
                return arg1_13.Instance
            end);
        };
    }
    local function Generate(arg1_14) -- Line 210
        local Frame_12 = Instance.new("Frame")
        Frame_12.Name = "Iris_PlotLines"
        Frame_12.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame_12.BackgroundTransparency = 1
        Frame_12.BorderSizePixel = 0
        arg2.UIListLayout(Frame_12, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Background"
        Frame_3.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(1, 0))
        Frame_3.BackgroundColor3 = arg1._config.FrameBgColor
        Frame_3.BackgroundTransparency = arg1._config.FrameBgTransparency
        arg2.applyFrameStyle(Frame_3)
        Frame_3.Parent = Frame_12
        local Frame_6 = Instance.new("Frame")
        Frame_6.Name = "Plot"
        Frame_6.Size = UDim2.fromScale(1, 1)
        Frame_6.BackgroundTransparency = 1
        Frame_6.BorderSizePixel = 0
        Frame_6.ClipsDescendants = true
        Frame_6:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line 235
            arg1_14.state.values.lastChangeTick = arg1._cycleTick
            arg1._widgets.PlotLines.UpdateState(arg1_14)
        end)
        local TextLabel_4 = Instance.new("TextLabel")
        TextLabel_4.Name = "OverlayText"
        TextLabel_4.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_4.AnchorPoint = Vector2.new(0.5, 0)
        TextLabel_4.Size = UDim2.fromOffset(0, 0)
        TextLabel_4.Position = UDim2.fromScale(0.5, 0)
        TextLabel_4.BackgroundTransparency = 1
        TextLabel_4.BorderSizePixel = 0
        TextLabel_4.ZIndex = 2
        arg2.applyTextStyle(TextLabel_4)
        TextLabel_4.Parent = Frame_6
        local TextLabel_3 = Instance.new("TextLabel")
        TextLabel_3.Name = "Iris_Tooltip"
        TextLabel_3.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_3.Size = UDim2.fromOffset(0, 0)
        TextLabel_3.BackgroundColor3 = arg1._config.PopupBgColor
        TextLabel_3.BackgroundTransparency = arg1._config.PopupBgTransparency
        TextLabel_3.BorderSizePixel = 0
        TextLabel_3.Visible = false
        arg2.applyTextStyle(TextLabel_3)
        arg2.UIStroke(TextLabel_3, arg1._config.PopupBorderSize, arg1._config.BorderActiveColor, arg1._config.BorderActiveTransparency)
        arg2.UIPadding(TextLabel_3, arg1._config.WindowPadding)
        local var38
        if 0 < var38 then
            var38 = arg2
            var38 = var38.UICorner
            var38(TextLabel_3, arg1._config.PopupRounding)
        end
        var38 = arg1
        var38 = var38._rootInstance
        if var38 then
            var38 = arg1
            var38 = var38._rootInstance:FindFirstChild("PopupScreenGui")
        end
        local var39 = var38
        if var39 then
            var39 = var38:FindFirstChild("TooltipContainer")
        end
        TextLabel_3.Parent = var39
        arg1_14.Tooltip = TextLabel_3
        arg2.applyMouseMoved(Frame_6, function() -- Line 275
            updateLine_upvr(arg1_14)
        end)
        arg2.applyMouseLeave(Frame_6, function() -- Line 279
            local var42 = arg1_14
            if var42.HoveredLine then
                var42.HoveredLine.BackgroundColor3 = arg1._config.PlotLinesColor
                var42.HoveredLine.BackgroundTransparency = arg1._config.PlotLinesTransparency
                var42.HoveredLine = false
                var42.state.hovered:set(nil)
            end
        end)
        Frame_6.Parent = Frame_3
        arg1_14.Lines = {}
        arg1_14.HoveredLine = false
        local TextLabel_9 = Instance.new("TextLabel")
        TextLabel_9.Name = "TextLabel"
        TextLabel_9.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_9.Size = UDim2.fromOffset(0, 0)
        TextLabel_9.BackgroundTransparency = 1
        TextLabel_9.BorderSizePixel = 0
        TextLabel_9.ZIndex = 3
        TextLabel_9.LayoutOrder = 3
        arg2.applyTextStyle(TextLabel_9)
        TextLabel_9.Parent = Frame_12
        return Frame_12
    end
    tbl_3.Generate = Generate
    local function GenerateState(arg1_15) -- Line 303
        if arg1_15.state.values == nil then
            arg1_15.state.values = arg1._widgetState(arg1_15, "values", {0, 1})
        end
        if arg1_15.state.hovered == nil then
            arg1_15.state.hovered = arg1._widgetState(arg1_15, "hovered", nil)
        end
    end
    tbl_3.GenerateState = GenerateState
    local function Update(arg1_16) -- Line 311
        local Instance = arg1_16.Instance
        Instance.TextLabel.Text = arg1_16.arguments.Text or "Plot Lines"
        Instance.Background.Plot.OverlayText.Text = arg1_16.arguments.TextOverlay or ""
        Instance.Size = UDim2.new(1, 0, 0, arg1_16.arguments.Height or 0)
    end
    tbl_3.Update = Update
    local function UpdateState(arg1_17) -- Line 322
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if arg1_17.state.hovered.lastChangeTick == arg1._cycleTick then
            if arg1_17.state.hovered.value then
                arg1_17.Tooltip.Visible = true
            else
                arg1_17.Tooltip.Visible = false
            end
        end
        if arg1_17.state.values.lastChangeTick == arg1._cycleTick then
            local value_2 = arg1_17.state.values.value
            local var67 = #value_2 - 1
            local len_3 = #arg1_17.Lines
            local var69 = arg1_17.arguments.Min or math.huge
            local var70 = arg1_17.arguments.Max or (-math.huge)
            if var69 == nil or var70 == nil then
                for i, v in value_2 do
                    var69 = math.min(var69, v)
                    local maximum = math.max(var70, v)
                end
            end
            if len_3 < var67 then
                for i_2 = len_3 + 1, var67 do
                    v = arg1_17.Lines
                    local Frame_8 = Instance.new("Frame")
                    Frame_8.Name = tostring(i_2)
                    Frame_8.AnchorPoint = Vector2.new(0.5, 0.5)
                    Frame_8.BackgroundColor3 = arg1._config.PlotLinesColor
                    Frame_8.BackgroundTransparency = arg1._config.PlotLinesTransparency
                    Frame_8.BorderSizePixel = 0
                    Frame_8.Parent = arg1_17.Instance.Background.Plot
                    i = table.insert
                    i(v, Frame_8)
                    local var73
                end
            elseif var67 < len_3 then
                i_2 = var67 + 1
                for _ = i_2, len_3 do
                    i = table.remove
                    v = arg1_17.Lines
                    i = i(v)
                    if i then
                        v = i:Destroy
                        v()
                    end
                end
            end
            local var74 = maximum - var69
            local AbsoluteSize = var73.AbsoluteSize
            for i_3 = 1, var67 do
                local var76 = AbsoluteSize * Vector2.new((i_3 - 1) / var67, (maximum - value_2[i_3]) / var74)
                local var77 = AbsoluteSize * Vector2.new(i_3 / var67, (maximum - value_2[i_3 + 1]) / var74)
                local var78 = (var76 + var77) / 2
                arg1_17.Lines[i_3].Size = UDim2.fromOffset((var77 - var76).Magnitude + 1, 1)
                arg1_17.Lines[i_3].Position = UDim2.fromOffset(var78.X, var78.Y)
                arg1_17.Lines[i_3].Rotation = math.atan2(var77.Y - var76.Y, var77.X - var76.X) * 57.29577951308232
                local _
            end
            if arg1_17.HoveredLine then
                i_3 = true
                updateLine_upvr(arg1_17, i_3)
            end
        end
    end
    tbl_3.UpdateState = UpdateState
    local function Discard(arg1_18) -- Line 385
        arg1_18.Instance:Destroy()
        arg1_18.Tooltip:Destroy()
        arg2.discardState(arg1_18)
    end
    tbl_3.Discard = Discard
    arg1.WidgetConstructor("PlotLines", tbl_3)
    local function _(arg1_19, arg2_4) -- Line 392, Named "createBlock"
        local Frame_9 = Instance.new("Frame")
        Frame_9.Name = tostring(arg2_4)
        Frame_9.BackgroundColor3 = arg1._config.PlotHistogramColor
        Frame_9.BackgroundTransparency = arg1._config.PlotHistogramTransparency
        Frame_9.BorderSizePixel = 0
        Frame_9.Parent = arg1_19
        return Frame_9
    end
    local function _(arg1_20) -- Line 404, Named "clearBlock"
        if arg1_20.HoveredBlock then
            arg1_20.HoveredBlock.BackgroundColor3 = arg1._config.PlotHistogramColor
            arg1_20.HoveredBlock.BackgroundTransparency = arg1._config.PlotHistogramTransparency
            arg1_20.HoveredBlock = false
            arg1_20.state.hovered:set(nil)
        end
    end
    local function updateBlock_upvr(arg1_21, arg2_5) -- Line 413, Named "updateBlock"
        local Plot_2 = arg1_21.Instance.Background.Plot
        local ceiled_2 = math.ceil((arg2.getMouseLocation().X - (Plot_2.AbsolutePosition - arg2.GuiOffset).X) / Plot_2.AbsoluteSize.X * #arg1_21.Blocks)
        local var83 = arg1_21.Blocks[ceiled_2]
        if var83 then
            if var83 ~= arg1_21.HoveredBlock and not arg2_5 and arg1_21.HoveredBlock then
                arg1_21.HoveredBlock.BackgroundColor3 = arg1._config.PlotHistogramColor
                arg1_21.HoveredBlock.BackgroundTransparency = arg1._config.PlotHistogramTransparency
                arg1_21.HoveredBlock = false
                arg1_21.state.hovered:set(nil)
            end
            local var84 = arg1_21.state.values.value[ceiled_2]
            local var85
            if var84 then
                if math.floor(var84) == var84 then
                    var85 = string.format("%d: %d", ceiled_2, var84)
                else
                    var85 = string.format("%d: %.3f", ceiled_2, var84)
                end
                arg1_21.Tooltip.Text = var85
            end
            arg1_21.HoveredBlock = var83
            var83.BackgroundColor3 = arg1._config.PlotHistogramHoveredColor
            var83.BackgroundTransparency = arg1._config.PlotHistogramHoveredTransparency
            if arg2_5 then
                arg1_21.state.hovered.value = var84
                return
            end
            arg1_21.state.hovered:set(var84)
        end
    end
    local tbl_2 = {
        hasState = true;
        hasChildren = false;
        Args = {
            Text = 1;
            Height = 2;
            Min = 3;
            Max = 4;
            TextOverlay = 5;
            BaseLine = 6;
        };
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_22) -- Line 457
                return arg1_22.Instance
            end);
        };
    }
    function tbl_2.Generate(arg1_23) -- Line 461
        local Frame_5 = Instance.new("Frame")
        Frame_5.Name = "Iris_PlotHistogram"
        Frame_5.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame_5.BackgroundTransparency = 1
        Frame_5.BorderSizePixel = 0
        arg2.UIListLayout(Frame_5, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        local Frame_7 = Instance.new("Frame")
        Frame_7.Name = "Background"
        Frame_7.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(1, 0))
        Frame_7.BackgroundColor3 = arg1._config.FrameBgColor
        Frame_7.BackgroundTransparency = arg1._config.FrameBgTransparency
        arg2.applyFrameStyle(Frame_7)
        Frame_7.UIPadding.PaddingRight = UDim.new(0, arg1._config.FramePadding.X - 1)
        Frame_7.Parent = Frame_5
        local Frame_4 = Instance.new("Frame")
        Frame_4.Name = "Plot"
        Frame_4.Size = UDim2.fromScale(1, 1)
        Frame_4.BackgroundTransparency = 1
        Frame_4.BorderSizePixel = 0
        Frame_4.ClipsDescendants = true
        local TextLabel_6 = Instance.new("TextLabel")
        TextLabel_6.Name = "OverlayText"
        TextLabel_6.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_6.AnchorPoint = Vector2.new(0.5, 0)
        TextLabel_6.Size = UDim2.fromOffset(0, 0)
        TextLabel_6.Position = UDim2.fromScale(0.5, 0)
        TextLabel_6.BackgroundTransparency = 1
        TextLabel_6.BorderSizePixel = 0
        TextLabel_6.ZIndex = 2
        arg2.applyTextStyle(TextLabel_6)
        TextLabel_6.Parent = Frame_4
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "Iris_Tooltip"
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_2.Size = UDim2.fromOffset(0, 0)
        TextLabel_2.BackgroundColor3 = arg1._config.PopupBgColor
        TextLabel_2.BackgroundTransparency = arg1._config.PopupBgTransparency
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Visible = false
        arg2.applyTextStyle(TextLabel_2)
        arg2.UIStroke(TextLabel_2, arg1._config.PopupBorderSize, arg1._config.BorderActiveColor, arg1._config.BorderActiveTransparency)
        arg2.UIPadding(TextLabel_2, arg1._config.WindowPadding)
        local var95
        if 0 < var95 then
            var95 = arg2
            var95 = var95.UICorner
            var95(TextLabel_2, arg1._config.PopupRounding)
        end
        var95 = arg1
        var95 = var95._rootInstance
        if var95 then
            var95 = arg1
            var95 = var95._rootInstance:FindFirstChild("PopupScreenGui")
        end
        local var96 = var95
        if var96 then
            var96 = var95:FindFirstChild("TooltipContainer")
        end
        TextLabel_2.Parent = var96
        arg1_23.Tooltip = TextLabel_2
        arg2.applyMouseMoved(Frame_4, function() -- Line 524
            updateBlock_upvr(arg1_23)
        end)
        arg2.applyMouseLeave(Frame_4, function() -- Line 528
            local var99 = arg1_23
            if var99.HoveredBlock then
                var99.HoveredBlock.BackgroundColor3 = arg1._config.PlotHistogramColor
                var99.HoveredBlock.BackgroundTransparency = arg1._config.PlotHistogramTransparency
                var99.HoveredBlock = false
                var99.state.hovered:set(nil)
            end
        end)
        Frame_4.Parent = Frame_7
        arg1_23.Blocks = {}
        arg1_23.HoveredBlock = false
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.Size = UDim2.fromOffset(0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.ZIndex = 3
        TextLabel.LayoutOrder = 3
        arg2.applyTextStyle(TextLabel)
        TextLabel.Parent = Frame_5
        return Frame_5
    end
    function tbl_2.GenerateState(arg1_24) -- Line 552
        if arg1_24.state.values == nil then
            arg1_24.state.values = arg1._widgetState(arg1_24, "values", {1})
        end
        if arg1_24.state.hovered == nil then
            arg1_24.state.hovered = arg1._widgetState(arg1_24, "hovered", nil)
        end
    end
    function tbl_2.Update(arg1_25) -- Line 560
        local Instance_2 = arg1_25.Instance
        Instance_2.TextLabel.Text = arg1_25.arguments.Text or "Plot Histogram"
        Instance_2.Background.Plot.OverlayText.Text = arg1_25.arguments.TextOverlay or ""
        Instance_2.Size = UDim2.new(1, 0, 0, arg1_25.arguments.Height or 0)
    end
    function tbl_2.UpdateState(arg1_26) -- Line 571
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if arg1_26.state.hovered.lastChangeTick == arg1._cycleTick then
            if arg1_26.state.hovered.value then
                arg1_26.Tooltip.Visible = true
            else
                arg1_26.Tooltip.Visible = false
            end
        end
        local var123
        if arg1_26.state.values.lastChangeTick == arg1._cycleTick then
            local value = arg1_26.state.values.value
            local len = #value
            local len_2 = #arg1_26.Blocks
            var123 = arg1_26.arguments
            var123 = var123.Min
            local var127 = var123 or math.huge
            var123 = arg1_26.arguments.Max or (-math.huge)
            local var128 = arg1_26.arguments.BaseLine or 0
            if var127 == nil or var123 == nil then
                for i_4, v_2 in value do
                    var127 = math.min(var127 or v_2, v_2)
                end
            end
            if len_2 < len then
                for i_5 = len_2 + 1, len do
                    v_2 = arg1_26.Blocks
                    local Frame_2 = Instance.new("Frame")
                    Frame_2.Name = tostring(i_5)
                    Frame_2.BackgroundColor3 = arg1._config.PlotHistogramColor
                    Frame_2.BackgroundTransparency = arg1._config.PlotHistogramTransparency
                    Frame_2.BorderSizePixel = 0
                    Frame_2.Parent = arg1_26.Instance.Background.Plot
                    i_4 = table.insert
                    i_4(v_2, Frame_2)
                    local _
                end
            elseif len < len_2 then
                i_5 = len + 1
                for _ = i_5, len_2 do
                    i_4 = table.remove
                    v_2 = arg1_26.Blocks
                    i_4 = i_4(v_2)
                    if i_4 then
                        v_2 = i_4:Destroy
                        v_2()
                    end
                end
            end
            local var131 = math.max(var123 or v_2, v_2) - var127
            for i_6 = 1, len do
                local var132 = value[i_6]
                if 0 <= var132 then
                    arg1_26.Blocks[i_6].Size = UDim2.new(UDim.new(1 / len, -1), UDim.new((var132 - var128) / var131))
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    arg1_26.Blocks[i_6].Position = UDim2.fromScale((i_6 - 1) / len, (math.max(var123 or v_2, v_2) - var132) / var131)
                else
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    arg1_26.Blocks[i_6].Size = UDim2.new(UDim.new(1 / len, -1), UDim.new((var128 - var132) / var131))
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    arg1_26.Blocks[i_6].Position = UDim2.fromScale((i_6 - 1) / len, (math.max(var123 or v_2, v_2) - var128) / var131)
                end
            end
            if arg1_26.HoveredBlock then
                i_6 = true
                updateBlock_upvr(arg1_26, i_6)
            end
        end
    end
    function tbl_2.Discard(arg1_27) -- Line 633
        arg1_27.Instance:Destroy()
        arg1_27.Tooltip:Destroy()
        arg2.discardState(arg1_27)
    end
    arg1.WidgetConstructor("PlotHistogram", tbl_2)
end