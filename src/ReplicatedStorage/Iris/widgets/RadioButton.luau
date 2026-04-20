return function(arg1, arg2) -- Line 3
    local tbl = {
        hasState = true;
        hasChildren = false;
        Args = {
            Text = 1;
            Index = 2;
        };
        Events = {
            selected = {
                Init = function(arg1_2) -- Line 14
                end;
                Get = function(arg1_3) -- Line 15
                    local var8
                    if arg1_3.lastSelectedTick ~= arg1._cycleTick then
                        var8 = false
                    else
                        var8 = true
                    end
                    return var8
                end;
            };
            unselected = {
                Init = function(arg1_4) -- Line 20
                end;
                Get = function(arg1_5) -- Line 21
                    local var12
                    if arg1_5.lastUnselectedTick ~= arg1._cycleTick then
                        var12 = false
                    else
                        var12 = true
                    end
                    return var12
                end;
            };
            active = {
                Init = function(arg1_6) -- Line 26
                end;
                Get = function(arg1_7) -- Line 27
                    local var16
                    if arg1_7.state.index.value ~= arg1_7.arguments.Index then
                        var16 = false
                    else
                        var16 = true
                    end
                    return var16
                end;
            };
            hovered = arg2.EVENTS.hover(function(arg1_8) -- Line 31
                return arg1_8.Instance
            end);
        };
    }
    function tbl.Generate(arg1_9) -- Line 35
        local TextButton = Instance.new("TextButton")
        TextButton.Name = "Iris_RadioButton"
        TextButton.AutomaticSize = Enum.AutomaticSize.XY
        TextButton.Size = UDim2.fromOffset(0, 0)
        TextButton.BackgroundTransparency = 1
        TextButton.BorderSizePixel = 0
        TextButton.Text = ""
        TextButton.AutoButtonColor = false
        arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        local var19 = arg1._config.TextSize + 2 * (arg1._config.FramePadding.Y - 1)
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Button"
        Frame_2.Size = UDim2.fromOffset(var19, var19)
        Frame_2.BackgroundColor3 = arg1._config.FrameBgColor
        Frame_2.BackgroundTransparency = arg1._config.FrameBgTransparency
        Frame_2.Parent = TextButton
        arg2.UICorner(Frame_2)
        arg2.UIPadding(Frame_2, Vector2.new(math.max(1, math.floor(var19 / 5)), math.max(1, math.floor(var19 / 5))))
        local Frame = Instance.new("Frame")
        Frame.Name = "Circle"
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundColor3 = arg1._config.CheckMarkColor
        Frame.BackgroundTransparency = arg1._config.CheckMarkTransparency
        arg2.UICorner(Frame)
        Frame.Parent = Frame_2
        arg2.applyInteractionHighlights("Background", TextButton, Frame_2, {
            Color = arg1._config.FrameBgColor;
            Transparency = arg1._config.FrameBgTransparency;
            HoveredColor = arg1._config.FrameBgHoveredColor;
            HoveredTransparency = arg1._config.FrameBgHoveredTransparency;
            ActiveColor = arg1._config.FrameBgActiveColor;
            ActiveTransparency = arg1._config.FrameBgActiveTransparency;
        })
        arg2.applyButtonClick(TextButton, function() -- Line 76
            arg1_9.state.index:set(arg1_9.arguments.Index)
        end)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.LayoutOrder = 1
        arg2.applyTextStyle(TextLabel)
        TextLabel.Parent = TextButton
        return TextButton
    end
    function tbl.Update(arg1_10) -- Line 92
        arg1_10.Instance.TextLabel.Text = arg1_10.arguments.Text or "Radio Button"
        if arg1_10.state then
            arg1_10.state.index.lastChangeTick = arg1._cycleTick
            arg1._widgets[arg1_10.type].UpdateState(arg1_10)
        end
    end
    function tbl.Discard(arg1_11) -- Line 102
        arg1_11.Instance:Destroy()
        arg2.discardState(arg1_11)
    end
    function tbl.GenerateState(arg1_12) -- Line 106
        if arg1_12.state.index == nil then
            arg1_12.state.index = arg1._widgetState(arg1_12, "index", arg1_12.arguments.Index)
        end
    end
    function tbl.UpdateState(arg1_13) -- Line 111
        local Circle = arg1_13.Instance.Button.Circle
        if arg1_13.state.index.value == arg1_13.arguments.Index then
            Circle.BackgroundTransparency = arg1._config.CheckMarkTransparency
            arg1_13.lastSelectedTick = arg1._cycleTick + 1
        else
            Circle.BackgroundTransparency = 1
            arg1_13.lastUnselectedTick = arg1._cycleTick + 1
        end
    end
    arg1.WidgetConstructor("RadioButton", tbl)
end