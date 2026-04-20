return function(arg1, arg2) -- Line 3
    local tbl = {
        hasState = false;
        hasChildren = false;
        Args = {
            Text = 1;
            Wrapped = 2;
            Color = 3;
            RichText = 4;
        };
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_2) -- Line 15
                return arg1_2.Instance
            end);
        };
    }
    local function Generate(arg1_3) -- Line 19
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "Iris_Text"
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_2.Size = UDim2.fromOffset(0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.BorderSizePixel = 0
        arg2.applyTextStyle(TextLabel_2)
        arg2.UIPadding(TextLabel_2, Vector2.new(0, 2))
        return TextLabel_2
    end
    tbl.Generate = Generate
    local function Update(arg1_4) -- Line 32
        local Instance = arg1_4.Instance
        if arg1_4.arguments.Text == nil then
            error("Text argument is required for Iris.Text().", 5)
        end
        if arg1_4.arguments.Wrapped ~= nil then
            Instance.TextWrapped = arg1_4.arguments.Wrapped
        else
            Instance.TextWrapped = arg1._config.TextWrapped
        end
        if arg1_4.arguments.Color then
            Instance.TextColor3 = arg1_4.arguments.Color
        else
            Instance.TextColor3 = arg1._config.TextColor
        end
        if arg1_4.arguments.RichText ~= nil then
            Instance.RichText = arg1_4.arguments.RichText
        else
            Instance.RichText = arg1._config.RichText
        end
        Instance.Text = arg1_4.arguments.Text
    end
    tbl.Update = Update
    local function Discard(arg1_5) -- Line 55
        arg1_5.Instance:Destroy()
    end
    tbl.Discard = Discard
    arg1.WidgetConstructor("Text", tbl)
    local tbl_2 = {
        hasState = false;
        hasChildren = false;
        Args = {
            Text = 1;
        };
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 68
                return arg1_6.Instance
            end);
        };
    }
    function tbl_2.Generate(arg1_7) -- Line 72
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Iris_SeparatorText"
        Frame_3.AutomaticSize = Enum.AutomaticSize.Y
        Frame_3.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame_3.BackgroundTransparency = 1
        Frame_3.BorderSizePixel = 0
        Frame_3.ClipsDescendants = true
        arg2.UIPadding(Frame_3, Vector2.new(0, arg1._config.SeparatorTextPadding.Y))
        arg2.UIListLayout(Frame_3, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemSpacing.X))
        Frame_3.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.LayoutOrder = 1
        arg2.applyTextStyle(TextLabel)
        TextLabel.Parent = Frame_3
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Left"
        Frame_2.AnchorPoint = Vector2.new(1, 0.5)
        Frame_2.Size = UDim2.fromOffset(arg1._config.SeparatorTextPadding.X - arg1._config.ItemSpacing.X, arg1._config.SeparatorTextBorderSize)
        Frame_2.BackgroundColor3 = arg1._config.SeparatorColor
        Frame_2.BackgroundTransparency = arg1._config.SeparatorTransparency
        Frame_2.BorderSizePixel = 0
        Frame_2.Parent = Frame_3
        local Frame = Instance.new("Frame")
        Frame.Name = "Right"
        Frame.AnchorPoint = Vector2.new(1, 0.5)
        Frame.Size = UDim2.new(1, 0, 0, arg1._config.SeparatorTextBorderSize)
        Frame.BackgroundColor3 = arg1._config.SeparatorColor
        Frame.BackgroundTransparency = arg1._config.SeparatorTransparency
        Frame.BorderSizePixel = 0
        Frame.LayoutOrder = 2
        Frame.Parent = Frame_3
        return Frame_3
    end
    function tbl_2.Update(arg1_8) -- Line 120
        if arg1_8.arguments.Text == nil then
            error("Text argument is required for Iris.SeparatorText().", 5)
        end
        arg1_8.Instance.TextLabel.Text = arg1_8.arguments.Text
    end
    function tbl_2.Discard(arg1_9) -- Line 128
        arg1_9.Instance:Destroy()
    end
    arg1.WidgetConstructor("SeparatorText", tbl_2)
end