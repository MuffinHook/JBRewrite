return function(arg1, arg2) -- Line 3
    local tbl_upvr = {
        hasState = false;
        hasChildren = false;
        Args = {
            Text = 1;
            Size = 2;
        };
        Events = {
            clicked = arg2.EVENTS.click(function(arg1_2) -- Line 12
                return arg1_2.Instance
            end);
            rightClicked = arg2.EVENTS.rightClick(function(arg1_3) -- Line 15
                return arg1_3.Instance
            end);
            doubleClicked = arg2.EVENTS.doubleClick(function(arg1_4) -- Line 18
                return arg1_4.Instance
            end);
            ctrlClicked = arg2.EVENTS.ctrlClick(function(arg1_5) -- Line 21
                return arg1_5.Instance
            end);
            hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 24
                return arg1_6.Instance
            end);
        };
    }
    local function Generate(arg1_7) -- Line 28
        local TextButton = Instance.new("TextButton")
        TextButton.AutomaticSize = Enum.AutomaticSize.XY
        TextButton.Size = UDim2.fromOffset(0, 0)
        TextButton.BackgroundColor3 = arg1._config.ButtonColor
        TextButton.BackgroundTransparency = arg1._config.ButtonTransparency
        TextButton.AutoButtonColor = false
        arg2.applyTextStyle(TextButton)
        TextButton.TextXAlignment = Enum.TextXAlignment.Center
        arg2.applyFrameStyle(TextButton)
        arg2.applyInteractionHighlights("Background", TextButton, TextButton, {
            Color = arg1._config.ButtonColor;
            Transparency = arg1._config.ButtonTransparency;
            HoveredColor = arg1._config.ButtonHoveredColor;
            HoveredTransparency = arg1._config.ButtonHoveredTransparency;
            ActiveColor = arg1._config.ButtonActiveColor;
            ActiveTransparency = arg1._config.ButtonActiveTransparency;
        })
        return TextButton
    end
    tbl_upvr.Generate = Generate
    function tbl_upvr.Update(arg1_8) -- Line 52
        local Instance = arg1_8.Instance
        Instance.Text = arg1_8.arguments.Text or "Button"
        local Size = arg1_8.arguments.Size
        if not Size then
            Size = UDim2.fromOffset(0, 0)
        end
        Instance.Size = Size
    end
    function tbl_upvr.Discard(arg1_9) -- Line 57
        arg1_9.Instance:Destroy()
    end
    arg2.abstractButton = tbl_upvr
    local tbl = {}
    local function Generate(arg1_10) -- Line 65
        local any_Generate_result1 = tbl_upvr.Generate(arg1_10)
        any_Generate_result1.Name = "Iris_Button"
        return any_Generate_result1
    end
    tbl.Generate = Generate
    arg1.WidgetConstructor("Button", arg2.extend(tbl_upvr, tbl))
    arg1.WidgetConstructor("SmallButton", arg2.extend(tbl_upvr, {
        Generate = function(arg1_11) -- Line 76, Named "Generate"
            local any_Generate_result1_2 = tbl_upvr.Generate(arg1_11)
            any_Generate_result1_2.Name = "Iris_SmallButton"
            local UIPadding = any_Generate_result1_2.UIPadding
            UIPadding.PaddingLeft = UDim.new(0, 2)
            UIPadding.PaddingRight = UDim.new(0, 2)
            UIPadding.PaddingTop = UDim.new(0, 0)
            UIPadding.PaddingBottom = UDim.new(0, 0)
            return any_Generate_result1_2
        end;
    }))
end