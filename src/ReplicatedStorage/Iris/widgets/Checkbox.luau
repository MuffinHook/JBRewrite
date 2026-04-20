return function(arg1, arg2) -- Line 3
    local tbl = {
        hasState = true;
        hasChildren = false;
        Args = {
            Text = 1;
        };
        Events = {
            checked = {
                Init = function(arg1_2) -- Line 13
                end;
                Get = function(arg1_3) -- Line 14
                    local var8
                    if arg1_3.lastCheckedTick ~= arg1._cycleTick then
                        var8 = false
                    else
                        var8 = true
                    end
                    return var8
                end;
            };
            unchecked = {
                Init = function(arg1_4) -- Line 19
                end;
                Get = function(arg1_5) -- Line 20
                    local var12
                    if arg1_5.lastUncheckedTick ~= arg1._cycleTick then
                        var12 = false
                    else
                        var12 = true
                    end
                    return var12
                end;
            };
            hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 24
                return arg1_6.Instance
            end);
        };
    }
    function tbl.Generate(arg1_7) -- Line 28
        local TextButton = Instance.new("TextButton")
        TextButton.Name = "Iris_Checkbox"
        TextButton.AutomaticSize = Enum.AutomaticSize.XY
        TextButton.Size = UDim2.fromOffset(0, 0)
        TextButton.BackgroundTransparency = 1
        TextButton.BorderSizePixel = 0
        TextButton.Text = ""
        TextButton.AutoButtonColor = false
        arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        local var15 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
        local Frame = Instance.new("Frame")
        Frame.Name = "Box"
        Frame.Size = UDim2.fromOffset(var15, var15)
        Frame.BackgroundColor3 = arg1._config.FrameBgColor
        Frame.BackgroundTransparency = arg1._config.FrameBgTransparency
        arg2.applyFrameStyle(Frame, true)
        arg2.UIPadding(Frame, Vector2.new(math.floor(var15 / 10), math.floor(var15 / 10)))
        arg2.applyInteractionHighlights("Background", TextButton, Frame, {
            Color = arg1._config.FrameBgColor;
            Transparency = arg1._config.FrameBgTransparency;
            HoveredColor = arg1._config.FrameBgHoveredColor;
            HoveredTransparency = arg1._config.FrameBgHoveredTransparency;
            ActiveColor = arg1._config.FrameBgActiveColor;
            ActiveTransparency = arg1._config.FrameBgActiveTransparency;
        })
        Frame.Parent = TextButton
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Checkmark"
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = arg2.ICONS.CHECK_MARK
        ImageLabel.ImageColor3 = arg1._config.CheckMarkColor
        ImageLabel.ImageTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.Parent = Frame
        arg2.applyButtonClick(TextButton, function() -- Line 73
            arg1_7.state.isChecked:set(not arg1_7.state.isChecked.value)
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
    function tbl.GenerateState(arg1_8) -- Line 89
        if arg1_8.state.isChecked == nil then
            arg1_8.state.isChecked = arg1._widgetState(arg1_8, "checked", false)
        end
    end
    function tbl.Update(arg1_9) -- Line 94
        arg1_9.Instance.TextLabel.Text = arg1_9.arguments.Text or "Checkbox"
    end
    function tbl.UpdateState(arg1_10) -- Line 98
        local Checkmark = arg1_10.Instance.Box.Checkmark
        if arg1_10.state.isChecked.value then
            Checkmark.ImageTransparency = arg1._config.CheckMarkTransparency
            arg1_10.lastCheckedTick = arg1._cycleTick + 1
        else
            Checkmark.ImageTransparency = 1
            arg1_10.lastUncheckedTick = arg1._cycleTick + 1
        end
    end
    function tbl.Discard(arg1_11) -- Line 110
        arg1_11.Instance:Destroy()
        arg2.discardState(arg1_11)
    end
    arg1.WidgetConstructor("Checkbox", tbl)
end