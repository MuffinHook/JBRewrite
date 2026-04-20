local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
return function(arg1) -- Line 4
    local module_upvr = {
        Items = {};
        ItemOptions = {};
        SelectedItem = 0;
    }
    local Util_upvr = arg1.Util
    local Autocomplete_upvr = LocalPlayer_upvr:WaitForChild("CmdrAutocompleteGuiValue").Value:WaitForChild("Autocomplete")
    local TextButton_upvr = Autocomplete_upvr:WaitForChild("TextButton")
    local Title_upvr = Autocomplete_upvr:WaitForChild("Title")
    local Description_upvr = Autocomplete_upvr:WaitForChild("Description")
    TextButton_upvr.Parent = nil
    local function SetText_upvr(arg1_2, arg2, arg3, arg4) -- Line 22, Named "SetText"
        if arg3 == nil then
        else
        end
        arg1_2.Visible = true
        arg2.Text = arg3 or ""
        if arg4 then
            arg2.Size = UDim2.new(0, Util_upvr.GetTextSize(arg3 or "", arg2, Vector2.new(1000, 1000), 1, 0).X, arg1_2.Size.Y.Scale, arg1_2.Size.Y.Offset)
        end
    end
    local function UpdateContainerSize_upvr() -- Line 36, Named "UpdateContainerSize"
        Autocomplete_upvr.Size = UDim2.new(0, math.max(Title_upvr.Field.TextBounds.X + Title_upvr.Field.Type.TextBounds.X, Autocomplete_upvr.Size.X.Offset), 0, math.min(Autocomplete_upvr.UIListLayout.AbsoluteContentSize.Y, Autocomplete_upvr.Parent.AbsoluteSize.Y - Autocomplete_upvr.AbsolutePosition.Y - 10))
    end
    local function UpdateInfoDisplay_upvr(arg1_3) -- Line 46, Named "UpdateInfoDisplay"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        SetText_upvr(Title_upvr, Title_upvr.Field, arg1_3.name, true)
        local type = arg1_3.type
        if type then
            type = ": "..arg1_3.type:sub(1, 1):upper()..arg1_3.type:sub(2)
        end
        if type == nil then
        else
        end
        Title_upvr.Field.Type.Visible = true
        Title_upvr.Field.Type.Text = type or ""
        local description = arg1_3.description
        if description == nil then
        else
        end
        Description_upvr.Visible = true
        Description_upvr.Label.Text = description or ""
        if not arg1_3.invalid or not Color3.fromRGB(255, 73, 73) then
        end
        Description_upvr.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Description_upvr.Size = UDim2.new(1, 0, 0, 40)
        repeat
            if Description_upvr.Label.TextFits then break end
            Description_upvr.Size += UDim2.new(0, 0, 0, 2)
        until 500 < Description_upvr.Size.Y.Offset
        task.wait()
        Autocomplete_upvr.UIListLayout:ApplyLayout()
        UpdateContainerSize_upvr()
    end
    local Entry_upvr = LocalPlayer_upvr:WaitForChild("CmdrFrameValue").Value:WaitForChild("Entry")
    function module_upvr.Show(arg1_4, arg2, arg3) -- Line 85
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if not arg3 then
        end
        local tbl = {}
        for _, v in pairs(arg1_4.Items) do
            if v.gui then
                v.gui:Destroy()
            end
        end
        arg1_4.SelectedItem = 1
        arg1_4.Items = arg2
        arg1_4.Prefix = tbl.prefix or ""
        arg1_4.LastItem = tbl.isLast or false
        arg1_4.Command = tbl.command
        arg1_4.Arg = tbl.arg
        arg1_4.NumArgs = tbl.numArgs
        arg1_4.IsPartial = tbl.isPartial
        for i_2, v_2 in pairs(arg1_4.Items) do
            local _1_2 = v_2[1]
            local _2 = v_2[2]
            local clone_2 = TextButton_upvr:Clone()
            local var69 = _1_2.._2
            clone_2.Name = var69
            if i_2 == arg1_4.SelectedItem then
                var69 = 0.5
            else
                var69 = 1
            end
            clone_2.BackgroundTransparency = var69
            local string_find_result1, string_find_result2 = string.find(_2:lower(), _1_2:lower(), 1, true)
            if string_find_result1 == nil then
                if string_find_result2 == nil then
                    string_find_result1 = 1
                end
            end
            clone_2.Typed.Text = string.rep(' ', string_find_result1 - 1).._1_2
            clone_2.Suggest.Text = string.sub(_2, 0, string_find_result1 - 1)..string.rep(' ', #_1_2)..string.sub(_2, string.len(_2) + 1)
            clone_2.Parent = Autocomplete_upvr
            clone_2.LayoutOrder = i_2
            local var72 = math.max(clone_2.Typed.TextBounds.X, clone_2.Suggest.TextBounds.X) + 20
            if 200 < var72 then
            end
            v_2.gui = clone_2
        end
        Autocomplete_upvr.UIListLayout:ApplyLayout()
        local Text = Entry_upvr.TextBox.Text
        local any_SplitString_result1_2 = Util_upvr.SplitString(Text)
        v_2 = #Text
        if Text:sub(v_2, #Text) == ' ' and not tbl.at then
            i_2 = #any_SplitString_result1_2
            i_2 = 'e'
            any_SplitString_result1_2[i_2 + 1] = i_2
        end
        i_2 = any_SplitString_result1_2
        v_2 = #any_SplitString_result1_2
        table.remove(i_2, v_2)
        v_2 = tbl.at
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            i_2 = tbl.at
            return i_2
        end
        if not v_2 or not decompInlinedCondition_3() then
            v_2 = #table.concat(any_SplitString_result1_2, ' ')
            i_2 = v_2 + 1
        end
        i_2 = Autocomplete_upvr
        v_2 = UDim2.new(0, Entry_upvr.TextBox.AbsolutePosition.X - 10 + i_2 * 7, 0, Entry_upvr.TextBox.AbsolutePosition.Y + 30) - UDim2.new(0, Autocomplete_upvr.Parent.AbsolutePosition.X, 0, Autocomplete_upvr.Parent.AbsolutePosition.Y)
        i_2.Position = v_2
        i_2 = Autocomplete_upvr
        v_2 = UDim2.new(0, var72, 0, Autocomplete_upvr.UIListLayout.AbsoluteContentSize.Y)
        i_2.Size = v_2
        i_2 = Autocomplete_upvr
        v_2 = true
        i_2.Visible = v_2
        i_2 = UpdateInfoDisplay_upvr
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            v_2 = v_2.options
            v_2 = arg1_4.Items[1]
            return v_2
        end
        if not arg1_4.Items[1] or not decompInlinedCondition_4() then
            v_2 = tbl
        end
        i_2(v_2)
    end
    function module_upvr.GetSelectedItem(arg1_5) -- Line 164
        if Autocomplete_upvr.Visible == false then
            return nil
        end
        return module_upvr.Items[module_upvr.SelectedItem]
    end
    function module_upvr.Hide(arg1_6) -- Line 173
        Autocomplete_upvr.Visible = false
    end
    function module_upvr.IsVisible(arg1_7) -- Line 178
        return Autocomplete_upvr.Visible
    end
    function module_upvr.Select(arg1_8, arg2) -- Line 183
        if not Autocomplete_upvr.Visible then
        else
            arg1_8.SelectedItem += arg2
            if #arg1_8.Items < arg1_8.SelectedItem then
                arg1_8.SelectedItem = 1
            elseif arg1_8.SelectedItem < 1 then
                arg1_8.SelectedItem = #arg1_8.Items
            end
            for i_3, v_3 in pairs(arg1_8.Items) do
                local var82
                if i_3 == arg1_8.SelectedItem then
                    var82 = 0.5
                else
                    var82 = 1
                end
                v_3.gui.BackgroundTransparency = var82
            end
            v_3 = 0
            var82 = Title_upvr.Size.Y.Offset + Description_upvr.Size.Y.Offset + arg1_8.SelectedItem * TextButton_upvr.Size.Y.Offset
            i_3 = math.max(v_3, var82 - Autocomplete_upvr.Size.Y.Offset)
            Autocomplete_upvr.CanvasPosition = Vector2.new(0, i_3)
            if arg1_8.Items[arg1_8.SelectedItem] and arg1_8.Items[arg1_8.SelectedItem].options then
                i_3 = arg1_8.SelectedItem
                local options = arg1_8.Items[i_3].options
                if not options then
                    options = {}
                end
                UpdateInfoDisplay_upvr(options)
            end
        end
    end
    Autocomplete_upvr.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize_upvr)
    return module_upvr
end