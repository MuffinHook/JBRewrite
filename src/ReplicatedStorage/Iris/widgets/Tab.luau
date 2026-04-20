return function(arg1, arg2) -- Line 3
    local function _(arg1_2, arg2_2) -- Line 4, Named "openTab"
        if 0 < arg1_2.state.index.value then
        else
            arg1_2.state.index:set(arg2_2)
        end
    end
    local function closeTab_upvr(arg1_3, arg2_3) -- Line 12, Named "closeTab"
        if arg1_3.state.index.value ~= arg2_3 then
        else
            for i_2 = arg2_3 - 1, 1, -1 do
                if arg1_3.Tabs[i_2].state.isOpened.value == true then
                    arg1_3.state.index:set(i_2)
                    return
                end
            end
            for i_3 = arg2_3, #arg1_3.Tabs do
                if arg1_3.Tabs[i_3].state.isOpened.value == true then
                    arg1_3.state.index:set(i_3)
                    return
                end
            end
            arg1_3.state.index:set(0)
        end
    end
    local tbl = {
        hasState = true;
        hasChildren = true;
        Args = {};
        Events = {};
    }
    local function Generate(arg1_4) -- Line 43
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Iris_TabBar"
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.Size = UDim2.fromScale(1, 0)
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        arg2.UIListLayout(Frame_2, Enum.FillDirection.Vertical, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Bottom
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Bar"
        Frame_3.AutomaticSize = Enum.AutomaticSize.Y
        Frame_3.Size = UDim2.fromScale(1, 0)
        Frame_3.BackgroundTransparency = 1
        Frame_3.BorderSizePixel = 0
        arg2.UIListLayout(Frame_3, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X))
        Frame_3.Parent = Frame_2
        local Frame_5 = Instance.new("Frame")
        Frame_5.Name = "Underline"
        Frame_5.Size = UDim2.new(1, 0, 0, 1)
        Frame_5.BackgroundColor3 = arg1._config.TabActiveColor
        Frame_5.BackgroundTransparency = arg1._config.TabActiveTransparency
        Frame_5.BorderSizePixel = 0
        Frame_5.LayoutOrder = 1
        Frame_5.Parent = Frame_2
        local Frame_4 = Instance.new("Frame")
        Frame_4.Name = "TabContainer"
        Frame_4.AutomaticSize = Enum.AutomaticSize.Y
        Frame_4.Size = UDim2.fromScale(1, 0)
        Frame_4.BackgroundTransparency = 1
        Frame_4.BorderSizePixel = 0
        Frame_4.LayoutOrder = 2
        Frame_4.ClipsDescendants = true
        Frame_4.Parent = Frame_2
        arg1_4.ChildContainer = Frame_4
        arg1_4.Tabs = {}
        return Frame_2
    end
    tbl.Generate = Generate
    local function Update(arg1_5) -- Line 90
    end
    tbl.Update = Update
    local function ChildAdded(arg1_6, arg2_4) -- Line 91
        local var9
        if arg2_4.type ~= "Tab" then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "Only Iris.Tab can be parented to Iris.TabBar.")
        var9 = arg2_4.ChildContainer
        var9.Parent = arg1_6.ChildContainer
        var9 = #arg1_6.Tabs + 1
        arg2_4.Index = var9
        var9 = arg1_6.state
        var9 = var9.index
        var9 = var9.ConnectedWidgets
        var9[arg2_4.ID] = arg2_4
        var9 = table.insert
        var9(arg1_6.Tabs, arg2_4)
        var9 = arg1_6.Instance.Bar
        return var9
    end
    tbl.ChildAdded = ChildAdded
    function tbl.ChildDiscarded(arg1_7, arg2_5) -- Line 101
        local Index = arg2_5.Index
        table.remove(arg1_7.Tabs, Index)
        for i = Index, #arg1_7.Tabs do
            arg1_7.Tabs[i].Index = i
        end
        closeTab_upvr(arg1_7, Index)
    end
    local function GenerateState(arg1_8) -- Line 111
        if arg1_8.state.index == nil then
            arg1_8.state.index = arg1._widgetState(arg1_8, "index", 1)
        end
    end
    tbl.GenerateState = GenerateState
    local function UpdateState(arg1_9) -- Line 116
    end
    tbl.UpdateState = UpdateState
    local function Discard(arg1_10) -- Line 118
        arg1_10.Instance:Destroy()
    end
    tbl.Discard = Discard
    arg1.WidgetConstructor("TabBar", tbl)
    local tbl_2 = {
        hasState = true;
        hasChildren = true;
        Args = {
            Text = 1;
            Hideable = 2;
        };
        Events = {
            clicked = arg2.EVENTS.click(function(arg1_11) -- Line 132
                return arg1_11.Instance
            end);
            hovered = arg2.EVENTS.hover(function(arg1_12) -- Line 135
                return arg1_12.Instance
            end);
            selected = {
                Init = function(arg1_13) -- Line 139
                end;
                Get = function(arg1_14) -- Line 140
                    local var20
                    if arg1_14.lastSelectedTick ~= arg1._cycleTick then
                        var20 = false
                    else
                        var20 = true
                    end
                    return var20
                end;
            };
            unselected = {
                Init = function(arg1_15) -- Line 145
                end;
                Get = function(arg1_16) -- Line 146
                    local var24
                    if arg1_16.lastUnselectedTick ~= arg1._cycleTick then
                        var24 = false
                    else
                        var24 = true
                    end
                    return var24
                end;
            };
            active = {
                Init = function(arg1_17) -- Line 151
                end;
                Get = function(arg1_18) -- Line 152
                    local var28
                    if arg1_18.state.index.value ~= arg1_18.Index then
                        var28 = false
                    else
                        var28 = true
                    end
                    return var28
                end;
            };
            opened = {
                Init = function(arg1_19) -- Line 157
                end;
                Get = function(arg1_20) -- Line 158
                    local var32
                    if arg1_20.lastOpenedTick ~= arg1._cycleTick then
                        var32 = false
                    else
                        var32 = true
                    end
                    return var32
                end;
            };
            closed = {
                Init = function(arg1_21) -- Line 163
                end;
                Get = function(arg1_22) -- Line 164
                    local var36
                    if arg1_22.lastClosedTick ~= arg1._cycleTick then
                        var36 = false
                    else
                        var36 = true
                    end
                    return var36
                end;
            };
        };
    }
    function tbl_2.Generate(arg1_23) -- Line 169
        local TextButton_2 = Instance.new("TextButton")
        TextButton_2.Name = "Iris_Tab"
        TextButton_2.AutomaticSize = Enum.AutomaticSize.XY
        TextButton_2.BackgroundColor3 = arg1._config.TabColor
        TextButton_2.BackgroundTransparency = arg1._config.TabTransparency
        TextButton_2.BorderSizePixel = 0
        TextButton_2.Text = ""
        TextButton_2.AutoButtonColor = false
        arg1_23.ButtonColors = {
            Color = arg1._config.TabColor;
            Transparency = arg1._config.TabTransparency;
            HoveredColor = arg1._config.TabHoveredColor;
            HoveredTransparency = arg1._config.TabHoveredTransparency;
            ActiveColor = arg1._config.TabActiveColor;
            ActiveTransparency = arg1._config.TabActiveTransparency;
        }
        arg2.UIPadding(TextButton_2, Vector2.new(arg1._config.FramePadding.X, 0))
        arg2.applyFrameStyle(TextButton_2, true, true)
        arg2.UIListLayout(TextButton_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        arg2.applyInteractionHighlights("Background", TextButton_2, TextButton_2, arg1_23.ButtonColors)
        arg2.applyButtonClick(TextButton_2, function() -- Line 192
            arg1_23.state.index:set(arg1_23.Index)
        end)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        arg2.applyTextStyle(TextLabel)
        arg2.UIPadding(TextLabel, Vector2.new(0, arg1._config.FramePadding.Y))
        TextLabel.Parent = TextButton_2
        local var41 = arg1._config.TextSize + (arg1._config.FramePadding.Y - 1) * 2
        local TextButton = Instance.new("TextButton")
        TextButton.Name = "CloseButton"
        TextButton.Size = UDim2.fromOffset(var41, var41)
        TextButton.BackgroundTransparency = 1
        TextButton.BorderSizePixel = 0
        TextButton.Text = ""
        TextButton.AutoButtonColor = false
        TextButton.LayoutOrder = 1
        arg2.UICorner(TextButton)
        arg2.applyButtonClick(TextButton, function() -- Line 219
            arg1_23.state.isOpened:set(false)
            closeTab_upvr(arg1_23.parentWidget, arg1_23.Index)
        end)
        arg2.applyInteractionHighlights("Background", TextButton, TextButton, {
            Color = arg1._config.TabColor;
            Transparency = 1;
            HoveredColor = arg1._config.ButtonHoveredColor;
            HoveredTransparency = arg1._config.ButtonHoveredTransparency;
            ActiveColor = arg1._config.ButtonActiveColor;
            ActiveTransparency = arg1._config.ButtonActiveTransparency;
        })
        TextButton.Parent = TextButton_2
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Icon"
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
        ImageLabel.Size = UDim2.fromOffset(math.floor(0.7 * var41), math.floor(0.7 * var41))
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.BorderSizePixel = 0
        ImageLabel.Image = arg2.ICONS.MULTIPLICATION_SIGN
        ImageLabel.ImageTransparency = 1
        arg2.applyInteractionHighlights("Image", TextButton_2, ImageLabel, {
            Color = arg1._config.TextColor;
            Transparency = 1;
            HoveredColor = arg1._config.TextColor;
            HoveredTransparency = arg1._config.TextTransparency;
            ActiveColor = arg1._config.TextColor;
            ActiveTransparency = arg1._config.TextTransparency;
        })
        ImageLabel.Parent = TextButton
        local Frame = Instance.new("Frame")
        Frame.Name = "TabContainer"
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.Size = UDim2.fromScale(1, 0)
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.ClipsDescendants = true
        arg2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
        arg2.UIPadding(Frame, Vector2.new(0, arg1._config.ItemSpacing.Y)).PaddingBottom = UDim.new()
        arg1_23.ChildContainer = Frame
        return TextButton_2
    end
    function tbl_2.Update(arg1_24) -- Line 270
        local Instance_2 = arg1_24.Instance
        local Text = arg1_24.arguments.Text
        Instance_2.TextLabel.Text = Text
        if arg1_24.arguments.Hideable == true then
            Text = true
        else
            Text = false
        end
        Instance_2.CloseButton.Visible = Text
    end
    function tbl_2.ChildAdded(arg1_25, arg2_6) -- Line 278
        return arg1_25.ChildContainer
    end
    function tbl_2.GenerateState(arg1_26) -- Line 281
        arg1_26.state.index = arg1_26.parentWidget.state.index
        arg1_26.state.index.ConnectedWidgets[arg1_26.ID] = arg1_26
        if arg1_26.state.isOpened == nil then
            arg1_26.state.isOpened = arg1._widgetState(arg1_26, "isOpened", true)
        end
    end
    function tbl_2.UpdateState(arg1_27) -- Line 289
        local Instance = arg1_27.Instance
        local ChildContainer = arg1_27.ChildContainer
        if arg1_27.state.isOpened.lastChangeTick == arg1._cycleTick then
            if arg1_27.state.isOpened.value == true then
                arg1_27.lastOpenedTick = arg1._cycleTick + 1
                local parentWidget = arg1_27.parentWidget
                if 0 < parentWidget.state.index.value then
                else
                    parentWidget.state.index:set(arg1_27.Index)
                end
                Instance.Visible = true
            else
                arg1_27.lastClosedTick = arg1._cycleTick + 1
                closeTab_upvr(arg1_27.parentWidget, arg1_27.Index)
                Instance.Visible = false
            end
        end
        if arg1_27.state.index.lastChangeTick == arg1._cycleTick then
            if arg1_27.state.index.value == arg1_27.Index then
                arg1_27.ButtonColors.Color = arg1._config.TabActiveColor
                arg1_27.ButtonColors.Transparency = arg1._config.TabActiveTransparency
                Instance.BackgroundColor3 = arg1._config.TabActiveColor
                Instance.BackgroundTransparency = arg1._config.TabActiveTransparency
                ChildContainer.Visible = true
                arg1_27.lastSelectedTick = arg1._cycleTick + 1
                return
            end
            arg1_27.ButtonColors.Color = arg1._config.TabColor
            arg1_27.ButtonColors.Transparency = arg1._config.TabTransparency
            Instance.BackgroundColor3 = arg1._config.TabColor
            Instance.BackgroundTransparency = arg1._config.TabTransparency
            ChildContainer.Visible = false
            arg1_27.lastUnselectedTick = arg1._cycleTick + 1
        end
    end
    function tbl_2.Discard(arg1_28) -- Line 323
        if arg1_28.state.isOpened.value == true then
            closeTab_upvr(arg1_28.parentWidget, arg1_28.Index)
        end
        arg1_28.Instance:Destroy()
        arg1_28.ChildContainer:Destroy()
        arg2.discardState(arg1_28)
    end
    arg1.WidgetConstructor("Tab", tbl_2)
end