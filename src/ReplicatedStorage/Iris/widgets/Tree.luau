return function(arg1, arg2) -- Line 3
    local tbl_2 = {
        hasState = true;
        hasChildren = true;
        Events = {
            collapsed = {
                Init = function(arg1_2) -- Line 9
                end;
                Get = function(arg1_3) -- Line 10
                    local var7
                    if arg1_3.lastCollapsedTick ~= arg1._cycleTick then
                        var7 = false
                    else
                        var7 = true
                    end
                    return var7
                end;
            };
            uncollapsed = {
                Init = function(arg1_4) -- Line 15
                end;
                Get = function(arg1_5) -- Line 16
                    local var11
                    if arg1_5.lastUncollapsedTick ~= arg1._cycleTick then
                        var11 = false
                    else
                        var11 = true
                    end
                    return var11
                end;
            };
            hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 20
                return arg1_6.Instance
            end);
        };
    }
    function tbl_2.Discard(arg1_7) -- Line 24
        arg1_7.Instance:Destroy()
        arg2.discardState(arg1_7)
    end
    function tbl_2.ChildAdded(arg1_8, arg2_2) -- Line 28
        local ChildContainer = arg1_8.ChildContainer
        ChildContainer.Visible = arg1_8.state.isUncollapsed.value
        return ChildContainer
    end
    function tbl_2.UpdateState(arg1_9) -- Line 35
        local value = arg1_9.state.isUncollapsed.value
        local var15
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var15 = var15.DOWN_POINTING_TRIANGLE
            var15 = var15.ICONS
            var15 = arg2
            return var15
        end
        if not value or not decompInlinedCondition() then
            var15 = arg2
            var15 = var15.ICONS
            var15 = var15.RIGHT_POINTING_TRIANGLE
        end
        arg1_9.Instance.Header.Button.Arrow.Image = var15
        if value then
            var15 = arg1._cycleTick + 1
            arg1_9.lastUncollapsedTick = var15
        else
            var15 = arg1._cycleTick + 1
            arg1_9.lastCollapsedTick = var15
        end
        arg1_9.ChildContainer.Visible = value
    end
    function tbl_2.GenerateState(arg1_10) -- Line 52
        if arg1_10.state.isUncollapsed == nil then
            arg1_10.state.isUncollapsed = arg1._widgetState(arg1_10, "isUncollapsed", arg1_10.arguments.DefaultOpen or false)
        end
    end
    local tbl = {
        Args = {
            Text = 1;
            SpanAvailWidth = 2;
            NoIndent = 3;
            DefaultOpen = 4;
        };
    }
    local function Generate(arg1_11) -- Line 69
        local Frame_5 = Instance.new("Frame")
        Frame_5.Name = "Iris_Tree"
        Frame_5.AutomaticSize = Enum.AutomaticSize.Y
        Frame_5.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
        Frame_5.BackgroundTransparency = 1
        Frame_5.BorderSizePixel = 0
        arg2.UIListLayout(Frame_5, Enum.FillDirection.Vertical, UDim.new(0, 0))
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "TreeContainer"
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.Size = UDim2.fromScale(1, 0)
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        Frame_2.LayoutOrder = 1
        Frame_2.Visible = false
        arg2.UIListLayout(Frame_2, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
        arg2.UIPadding(Frame_2, Vector2.zero).PaddingTop = UDim.new(0, arg1._config.ItemSpacing.Y)
        Frame_2.Parent = Frame_5
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Header"
        Frame_3.AutomaticSize = Enum.AutomaticSize.Y
        Frame_3.Size = UDim2.fromScale(1, 0)
        Frame_3.BackgroundTransparency = 1
        Frame_3.BorderSizePixel = 0
        Frame_3.Parent = Frame_5
        local TextButton_2 = Instance.new("TextButton")
        TextButton_2.Name = "Button"
        TextButton_2.BackgroundTransparency = 1
        TextButton_2.BorderSizePixel = 0
        TextButton_2.Text = ""
        TextButton_2.AutoButtonColor = false
        arg2.applyInteractionHighlights("Background", TextButton_2, Frame_3, {
            Color = Color3.fromRGB(0, 0, 0);
            Transparency = 1;
            HoveredColor = arg1._config.HeaderHoveredColor;
            HoveredTransparency = arg1._config.HeaderHoveredTransparency;
            ActiveColor = arg1._config.HeaderActiveColor;
            ActiveTransparency = arg1._config.HeaderActiveTransparency;
        })
        arg2.UIPadding(TextButton_2, Vector2.zero).PaddingLeft = UDim.new(0, arg1._config.FramePadding.X)
        arg2.UIListLayout(TextButton_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        TextButton_2.Parent = Frame_3
        local ImageLabel_2 = Instance.new("ImageLabel")
        ImageLabel_2.Name = "Arrow"
        ImageLabel_2.Size = UDim2.fromOffset(arg1._config.TextSize, math.floor(arg1._config.TextSize * 0.7))
        ImageLabel_2.BackgroundTransparency = 1
        ImageLabel_2.BorderSizePixel = 0
        ImageLabel_2.ImageColor3 = arg1._config.TextColor
        ImageLabel_2.ImageTransparency = arg1._config.TextTransparency
        ImageLabel_2.ScaleType = Enum.ScaleType.Fit
        ImageLabel_2.Parent = TextButton_2
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "TextLabel"
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_2.Size = UDim2.fromOffset(0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.BorderSizePixel = 0
        arg2.UIPadding(TextLabel_2, Vector2.zero).PaddingRight = UDim.new(0, 21)
        arg2.applyTextStyle(TextLabel_2)
        TextLabel_2.Parent = TextButton_2
        arg2.applyButtonClick(TextButton_2, function() -- Line 146
            arg1_11.state.isUncollapsed:set(not arg1_11.state.isUncollapsed.value)
        end)
        arg1_11.ChildContainer = Frame_2
        return Frame_5
    end
    tbl.Generate = Generate
    local function Update(arg1_12) -- Line 153
        local Button = arg1_12.Instance.Header.Button
        local UIPadding = arg1_12.ChildContainer.UIPadding
        Button.TextLabel.Text = arg1_12.arguments.Text or "Tree"
        if arg1_12.arguments.SpanAvailWidth then
            Button.AutomaticSize = Enum.AutomaticSize.Y
            Button.Size = UDim2.fromScale(1, 0)
        else
            Button.AutomaticSize = Enum.AutomaticSize.XY
            Button.Size = UDim2.fromScale(0, 0)
        end
        if arg1_12.arguments.NoIndent then
            UIPadding.PaddingLeft = UDim.new(0, 0)
        else
            UIPadding.PaddingLeft = UDim.new(0, arg1._config.IndentSpacing)
        end
    end
    tbl.Update = Update
    arg1.WidgetConstructor("Tree", arg2.extend(tbl_2, tbl))
    arg1.WidgetConstructor("CollapsingHeader", arg2.extend(tbl_2, {
        Args = {
            Text = 1;
            DefaultOpen = 2;
        };
        Generate = function(arg1_13) -- Line 187, Named "Generate"
            local Frame_4 = Instance.new("Frame")
            Frame_4.Name = "Iris_CollapsingHeader"
            Frame_4.AutomaticSize = Enum.AutomaticSize.Y
            Frame_4.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
            Frame_4.BackgroundTransparency = 1
            Frame_4.BorderSizePixel = 0
            arg2.UIListLayout(Frame_4, Enum.FillDirection.Vertical, UDim.new(0, 0))
            local Frame = Instance.new("Frame")
            Frame.Name = "CollapsingHeaderContainer"
            Frame.AutomaticSize = Enum.AutomaticSize.Y
            Frame.Size = UDim2.fromScale(1, 0)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.LayoutOrder = 1
            Frame.Visible = false
            arg2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
            arg2.UIPadding(Frame, Vector2.zero).PaddingTop = UDim.new(0, arg1._config.ItemSpacing.Y)
            Frame.Parent = Frame_4
            local Frame_6 = Instance.new("Frame")
            Frame_6.Name = "Header"
            Frame_6.AutomaticSize = Enum.AutomaticSize.Y
            Frame_6.Size = UDim2.fromScale(1, 0)
            Frame_6.BackgroundTransparency = 1
            Frame_6.BorderSizePixel = 0
            Frame_6.Parent = Frame_4
            local TextButton = Instance.new("TextButton")
            TextButton.Name = "Button"
            TextButton.AutomaticSize = Enum.AutomaticSize.Y
            TextButton.Size = UDim2.fromScale(1, 0)
            TextButton.BackgroundColor3 = arg1._config.HeaderColor
            TextButton.BackgroundTransparency = arg1._config.HeaderTransparency
            TextButton.BorderSizePixel = 0
            TextButton.Text = ""
            TextButton.AutoButtonColor = false
            TextButton.ClipsDescendants = true
            arg2.UIPadding(TextButton, arg1._config.FramePadding)
            arg2.applyFrameStyle(TextButton, true)
            arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, 2 * arg1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
            arg2.applyInteractionHighlights("Background", TextButton, TextButton, {
                Color = arg1._config.HeaderColor;
                Transparency = arg1._config.HeaderTransparency;
                HoveredColor = arg1._config.HeaderHoveredColor;
                HoveredTransparency = arg1._config.HeaderHoveredTransparency;
                ActiveColor = arg1._config.HeaderActiveColor;
                ActiveTransparency = arg1._config.HeaderActiveTransparency;
            })
            TextButton.Parent = Frame_6
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Name = "Arrow"
            ImageLabel.AutomaticSize = Enum.AutomaticSize.Y
            ImageLabel.Size = UDim2.fromOffset(arg1._config.TextSize, math.ceil(arg1._config.TextSize * 0.8))
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.BorderSizePixel = 0
            ImageLabel.ImageColor3 = arg1._config.TextColor
            ImageLabel.ImageTransparency = arg1._config.TextTransparency
            ImageLabel.ScaleType = Enum.ScaleType.Fit
            ImageLabel.Parent = TextButton
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = "TextLabel"
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY
            TextLabel.Size = UDim2.fromOffset(0, 0)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            arg2.UIPadding(TextLabel, Vector2.zero).PaddingRight = UDim.new(0, 21)
            arg2.applyTextStyle(TextLabel)
            TextLabel.Parent = TextButton
            arg2.applyButtonClick(TextButton, function() -- Line 270
                arg1_13.state.isUncollapsed:set(not arg1_13.state.isUncollapsed.value)
            end)
            arg1_13.ChildContainer = Frame
            return Frame_4
        end;
        Update = function(arg1_14) -- Line 277, Named "Update"
            arg1_14.Instance.Header.Button.TextLabel.Text = arg1_14.arguments.Text or "Collapsing Header"
        end;
    }))
end