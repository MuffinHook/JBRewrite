return function(arg1, arg2) -- Line 3
    local var2_upvw = 0
    arg1.WidgetConstructor("Root", {
        hasState = false;
        hasChildren = true;
        Args = {};
        Events = {};
        Generate = function(arg1_2) -- Line 12, Named "Generate"
            local Folder = Instance.new("Folder")
            Folder.Name = "Iris_Root"
            if arg1._config.UseScreenGUIs then
                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.ResetOnSpawn = false
                ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                ScreenGui.ScreenInsets = arg1._config.ScreenInsets
                ScreenGui.IgnoreGuiInset = arg1._config.IgnoreGuiInset
                ScreenGui.DisplayOrder = arg1._config.DisplayOrderOffset
            else
                local Frame_2 = Instance.new("Frame")
                Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Frame_2.Position = UDim2.fromScale(0.5, 0.5)
                Frame_2.Size = UDim2.fromScale(1, 1)
                Frame_2.BackgroundTransparency = 1
                Frame_2.ZIndex = arg1._config.DisplayOrderOffset
            end
            Frame_2.Name = "PseudoWindowScreenGui"
            Frame_2.Parent = Folder
            if arg1._config.UseScreenGUIs then
                local ScreenGui_2 = Instance.new("ScreenGui")
                ScreenGui_2.ResetOnSpawn = false
                ScreenGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                ScreenGui_2.DisplayOrder = arg1._config.DisplayOrderOffset + 1024
                ScreenGui_2.ScreenInsets = arg1._config.ScreenInsets
                ScreenGui_2.IgnoreGuiInset = arg1._config.IgnoreGuiInset
            else
                local Frame = Instance.new("Frame")
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                Frame.Position = UDim2.fromScale(0.5, 0.5)
                Frame.Size = UDim2.fromScale(1, 1)
                Frame.BackgroundTransparency = 1
                Frame.ZIndex = arg1._config.DisplayOrderOffset + 1024
            end
            Frame.Name = "PopupScreenGui"
            Frame.Parent = Folder
            local Frame_3 = Instance.new("Frame")
            Frame_3.Name = "TooltipContainer"
            Frame_3.AutomaticSize = Enum.AutomaticSize.XY
            Frame_3.Size = UDim2.fromOffset(0, 0)
            Frame_3.BackgroundTransparency = 1
            Frame_3.BorderSizePixel = 0
            arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.PopupBorderSize))
            Frame_3.Parent = Frame
            local Frame_4 = Instance.new("Frame")
            Frame_4.Name = "MenuBarContainer"
            Frame_4.AutomaticSize = Enum.AutomaticSize.Y
            Frame_4.Size = UDim2.fromScale(1, 0)
            Frame_4.BackgroundTransparency = 1
            Frame_4.BorderSizePixel = 0
            Frame_4.Parent = Frame
            local Frame_5 = Instance.new("Frame")
            Frame_5.Name = "PseudoWindow"
            Frame_5.AutomaticSize = Enum.AutomaticSize.XY
            Frame_5.Size = UDim2.new(0, 0, 0, 0)
            Frame_5.Position = UDim2.fromOffset(0, 22)
            Frame_5.BackgroundTransparency = arg1._config.WindowBgTransparency
            Frame_5.BackgroundColor3 = arg1._config.WindowBgColor
            Frame_5.BorderSizePixel = arg1._config.WindowBorderSize
            Frame_5.BorderColor3 = arg1._config.BorderColor
            Frame_5.Selectable = false
            Frame_5.SelectionGroup = true
            Frame_5.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
            Frame_5.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            Frame_5.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
            Frame_5.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
            Frame_5.Visible = false
            arg2.UIPadding(Frame_5, arg1._config.WindowPadding)
            arg2.UIListLayout(Frame_5, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
            Frame_5.Parent = Frame_2
            return Folder
        end;
        Update = function(arg1_3) -- Line 100, Named "Update"
            if 0 < var2_upvw then
                arg1_3.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
            end
        end;
        Discard = function(arg1_4) -- Line 108, Named "Discard"
            var2_upvw = 0
            arg1_4.Instance:Destroy()
        end;
        ChildAdded = function(arg1_5, arg2_2) -- Line 112, Named "ChildAdded"
            local Instance = arg1_5.Instance
            if arg2_2.type == "Window" then
                return arg1_5.Instance
            end
            if arg2_2.type == "Tooltip" then
                return Instance.PopupScreenGui.TooltipContainer
            end
            if arg2_2.type == "MenuBar" then
                return Instance.PopupScreenGui.MenuBarContainer
            end
            local PseudoWindow = Instance.PseudoWindowScreenGui.PseudoWindow
            var2_upvw += 1
            PseudoWindow.Visible = true
            return PseudoWindow
        end;
        ChildDiscarded = function(arg1_6, arg2_3) -- Line 131, Named "ChildDiscarded"
            if arg2_3.type ~= "Window" and arg2_3.type ~= "Tooltip" and arg2_3.type ~= "MenuBar" then
                var2_upvw -= 1
                if var2_upvw == 0 then
                    arg1_6.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
                end
            end
        end;
    })
end