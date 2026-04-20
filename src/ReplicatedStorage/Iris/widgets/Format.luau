return function(arg1, arg2) -- Line 3
    local tbl_2 = {
        hasState = false;
        hasChildren = false;
        Args = {};
        Events = {};
    }
    local function Generate(arg1_2) -- Line 10
        local Frame = Instance.new("Frame")
        Frame.Name = "Iris_Separator"
        if arg1_2.parentWidget.type == "SameLine" then
            Frame.Size = UDim2.new(0, 1, arg1._config.ItemWidth.Scale, arg1._config.ItemWidth.Offset)
        else
            Frame.Size = UDim2.new(arg1._config.ItemWidth.Scale, arg1._config.ItemWidth.Offset, 0, 1)
        end
        Frame.BackgroundColor3 = arg1._config.SeparatorColor
        Frame.BackgroundTransparency = arg1._config.SeparatorTransparency
        Frame.BorderSizePixel = 0
        arg2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
        return Frame
    end
    tbl_2.Generate = Generate
    local function Update(arg1_3) -- Line 27
    end
    tbl_2.Update = Update
    local function Discard(arg1_4) -- Line 28
        arg1_4.Instance:Destroy()
    end
    tbl_2.Discard = Discard
    arg1.WidgetConstructor("Separator", tbl_2)
    local tbl = {
        hasState = false;
        hasChildren = true;
        Args = {
            Width = 1;
        };
        Events = {};
    }
    local function Generate(arg1_5) -- Line 41
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Iris_Indent"
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        arg2.UIListLayout(Frame_2, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
        arg2.UIPadding(Frame_2, Vector2.zero)
        return Frame_2
    end
    tbl.Generate = Generate
    local function Update(arg1_6) -- Line 54
        local var7
        if arg1_6.arguments.Width then
            var7 = arg1_6.arguments
            var7 = var7.Width
        else
            var7 = arg1
            var7 = var7._config
            var7 = var7.IndentSpacing
        end
        arg1_6.Instance.UIPadding.PaddingLeft = UDim.new(0, var7)
    end
    tbl.Update = Update
    local function ChildAdded(arg1_7, arg2_2) -- Line 59
        return arg1_7.Instance
    end
    tbl.ChildAdded = ChildAdded
    local function Discard(arg1_8) -- Line 62
        arg1_8.Instance:Destroy()
    end
    tbl.Discard = Discard
    arg1.WidgetConstructor("Indent", tbl)
    local tbl_3 = {
        hasState = false;
        hasChildren = true;
        Args = {
            Width = 1;
            VerticalAlignment = 2;
            HorizontalAlignment = 3;
        };
        Events = {};
    }
    local function Generate(arg1_9) -- Line 77
        local Frame_4 = Instance.new("Frame")
        Frame_4.Name = "Iris_SameLine"
        Frame_4.AutomaticSize = Enum.AutomaticSize.Y
        Frame_4.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
        Frame_4.BackgroundTransparency = 1
        Frame_4.BorderSizePixel = 0
        arg2.UIListLayout(Frame_4, Enum.FillDirection.Horizontal, UDim.new(0, 0))
        return Frame_4
    end
    tbl_3.Generate = Generate
    local function Update(arg1_10) -- Line 89
        local UIListLayout = arg1_10.Instance.UIListLayout
        local var12
        if arg1_10.arguments.Width then
            var12 = arg1_10.arguments
            var12 = var12.Width
        else
            var12 = arg1
            var12 = var12._config
            var12 = var12.ItemSpacing
            var12 = var12.X
        end
        UIListLayout.Padding = UDim.new(0, var12)
        if arg1_10.arguments.VerticalAlignment then
            UIListLayout.VerticalAlignment = arg1_10.arguments.VerticalAlignment
        else
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        end
        if arg1_10.arguments.HorizontalAlignment then
            UIListLayout.HorizontalAlignment = arg1_10.arguments.HorizontalAlignment
        else
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        end
    end
    tbl_3.Update = Update
    local function ChildAdded(arg1_11, arg2_3) -- Line 105
        return arg1_11.Instance
    end
    tbl_3.ChildAdded = ChildAdded
    local function Discard(arg1_12) -- Line 108
        arg1_12.Instance:Destroy()
    end
    tbl_3.Discard = Discard
    arg1.WidgetConstructor("SameLine", tbl_3)
    arg1.WidgetConstructor("Group", {
        hasState = false;
        hasChildren = true;
        Args = {};
        Events = {};
        Generate = function(arg1_13) -- Line 119, Named "Generate"
            local Frame_3 = Instance.new("Frame")
            Frame_3.Name = "Iris_Group"
            Frame_3.AutomaticSize = Enum.AutomaticSize.XY
            Frame_3.Size = UDim2.fromOffset(0, 0)
            Frame_3.BackgroundTransparency = 1
            Frame_3.BorderSizePixel = 0
            Frame_3.ClipsDescendants = false
            arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
            return Frame_3
        end;
        Update = function(arg1_14) -- Line 132, Named "Update"
        end;
        ChildAdded = function(arg1_15, arg2_4) -- Line 133, Named "ChildAdded"
            return arg1_15.Instance
        end;
        Discard = function(arg1_16) -- Line 136, Named "Discard"
            arg1_16.Instance:Destroy()
        end;
    })
end