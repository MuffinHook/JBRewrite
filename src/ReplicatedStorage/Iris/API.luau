return function(arg1) -- Line 3
    local function _(arg1_2) -- Line 5, Named "wrapper"
        return function(arg1_3, arg2) -- Line 6
            return arg1.Internal._Insert(arg1_2, arg1_3, arg2)
        end
    end
    local var4_upvr = "Window"
    function arg1.Window(arg1_4, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_4, arg2)
    end
    arg1.SetFocusedWindow = arg1.Internal.SetFocusedWindow
    var4_upvr = "Tooltip"
    function arg1.Tooltip(arg1_5, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_5, arg2)
    end
    var4_upvr = "MenuBar"
    function arg1.MenuBar(arg1_6, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_6, arg2)
    end
    var4_upvr = "Menu"
    function arg1.Menu(arg1_7, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_7, arg2)
    end
    var4_upvr = "MenuItem"
    function arg1.MenuItem(arg1_8, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_8, arg2)
    end
    var4_upvr = "MenuToggle"
    function arg1.MenuToggle(arg1_9, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_9, arg2)
    end
    var4_upvr = "Separator"
    function arg1.Separator(arg1_10, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_10, arg2)
    end
    var4_upvr = "Indent"
    function arg1.Indent(arg1_11, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_11, arg2)
    end
    var4_upvr = "SameLine"
    function arg1.SameLine(arg1_12, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_12, arg2)
    end
    var4_upvr = "Group"
    function arg1.Group(arg1_13, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_13, arg2)
    end
    var4_upvr = "Text"
    function arg1.Text(arg1_14, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_14, arg2)
    end
    function arg1.TextWrapped(arg1_15) -- Line 440
        arg1_15[2] = true
        return arg1.Internal._Insert("Text", arg1_15)
    end
    function arg1.TextColored(arg1_16) -- Line 465
        arg1_16[3] = arg1_16[2]
        arg1_16[2] = nil
        return arg1.Internal._Insert("Text", arg1_16)
    end
    var4_upvr = "SeparatorText"
    function arg1.SeparatorText(arg1_17, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_17, arg2)
    end
    var4_upvr = "InputText"
    function arg1.InputText(arg1_18, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_18, arg2)
    end
    var4_upvr = "Button"
    function arg1.Button(arg1_19, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_19, arg2)
    end
    var4_upvr = "SmallButton"
    function arg1.SmallButton(arg1_20, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_20, arg2)
    end
    var4_upvr = "Checkbox"
    function arg1.Checkbox(arg1_21, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_21, arg2)
    end
    var4_upvr = "RadioButton"
    function arg1.RadioButton(arg1_22, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_22, arg2)
    end
    var4_upvr = "Image"
    function arg1.Image(arg1_23, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_23, arg2)
    end
    var4_upvr = "ImageButton"
    function arg1.ImageButton(arg1_24, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_24, arg2)
    end
    var4_upvr = "Tree"
    function arg1.Tree(arg1_25, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_25, arg2)
    end
    var4_upvr = "CollapsingHeader"
    function arg1.CollapsingHeader(arg1_26, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_26, arg2)
    end
    var4_upvr = "TabBar"
    function arg1.TabBar(arg1_27, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_27, arg2)
    end
    var4_upvr = "Tab"
    function arg1.Tab(arg1_28, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_28, arg2)
    end
    var4_upvr = "InputNum"
    function arg1.InputNum(arg1_29, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_29, arg2)
    end
    var4_upvr = "InputVector2"
    function arg1.InputVector2(arg1_30, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_30, arg2)
    end
    var4_upvr = "InputVector3"
    function arg1.InputVector3(arg1_31, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_31, arg2)
    end
    var4_upvr = "InputUDim"
    function arg1.InputUDim(arg1_32, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_32, arg2)
    end
    var4_upvr = "InputUDim2"
    function arg1.InputUDim2(arg1_33, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_33, arg2)
    end
    var4_upvr = "InputRect"
    function arg1.InputRect(arg1_34, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_34, arg2)
    end
    var4_upvr = "DragNum"
    function arg1.DragNum(arg1_35, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_35, arg2)
    end
    var4_upvr = "DragVector2"
    function arg1.DragVector2(arg1_36, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_36, arg2)
    end
    var4_upvr = "DragVector3"
    function arg1.DragVector3(arg1_37, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_37, arg2)
    end
    var4_upvr = "DragUDim"
    function arg1.DragUDim(arg1_38, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_38, arg2)
    end
    var4_upvr = "DragUDim2"
    function arg1.DragUDim2(arg1_39, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_39, arg2)
    end
    var4_upvr = "DragRect"
    function arg1.DragRect(arg1_40, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_40, arg2)
    end
    var4_upvr = "InputColor3"
    function arg1.InputColor3(arg1_41, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_41, arg2)
    end
    var4_upvr = "InputColor4"
    function arg1.InputColor4(arg1_42, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_42, arg2)
    end
    var4_upvr = "SliderNum"
    function arg1.SliderNum(arg1_43, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_43, arg2)
    end
    var4_upvr = "SliderVector2"
    function arg1.SliderVector2(arg1_44, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_44, arg2)
    end
    var4_upvr = "SliderVector3"
    function arg1.SliderVector3(arg1_45, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_45, arg2)
    end
    var4_upvr = "SliderUDim"
    function arg1.SliderUDim(arg1_46, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_46, arg2)
    end
    var4_upvr = "SliderUDim2"
    function arg1.SliderUDim2(arg1_47, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_47, arg2)
    end
    var4_upvr = "SliderRect"
    function arg1.SliderRect(arg1_48, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_48, arg2)
    end
    var4_upvr = "Selectable"
    function arg1.Selectable(arg1_49, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_49, arg2)
    end
    var4_upvr = "Combo"
    function arg1.Combo(arg1_50, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_50, arg2)
    end
    function arg1.ComboArray(arg1_51, arg2, arg3) -- Line 1667
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var60
        if arg2 == nil then
            var60 = arg1.State(arg3[1])
        else
            var60 = arg2
        end
        local any__Insert_result1 = arg1.Internal._Insert("Combo", arg1_51, var60)
        for _, v in arg3 do
            arg1.Internal._Insert("Selectable", {v, v}, {
                index = any__Insert_result1.state.index;
            })
            local _
        end
        arg1.End()
        return any__Insert_result1
    end
    function arg1.ComboEnum(arg1_52, arg2, arg3) -- Line 1716
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var74
        if arg2 == nil then
            var74 = arg1.State(arg3:GetEnumItems()[1])
        else
            var74 = arg2
        end
        local any__Insert_result1_2 = arg1.Internal._Insert("Combo", arg1_52, var74)
        for _, v_2 in arg3:GetEnumItems() do
            arg1.Internal._Insert("Selectable", {v_2.Name, v_2}, {
                index = any__Insert_result1_2.state.index;
            })
            local _
        end
        arg1.End()
        return any__Insert_result1_2
    end
    arg1.InputEnum = arg1.ComboEnum
    var4_upvr = "ProgressBar"
    function arg1.ProgressBar(arg1_53, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_53, arg2)
    end
    var4_upvr = "PlotLines"
    function arg1.PlotLines(arg1_54, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_54, arg2)
    end
    var4_upvr = "PlotHistogram"
    function arg1.PlotHistogram(arg1_55, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_55, arg2)
    end
    var4_upvr = "Table"
    function arg1.Table(arg1_56, arg2) -- Line 6
        return arg1.Internal._Insert(var4_upvr, arg1_56, arg2)
    end
    function arg1.NextColumn() -- Line 1973
        local any__GetParentWidget_result1_5 = arg1.Internal._GetParentWidget()
        local var88
        if any__GetParentWidget_result1_5 == nil then
            var88 = false
        else
            var88 = true
        end
        assert(var88, "Iris.NextColumn() can only called when directly within a table.")
        var88 = any__GetParentWidget_result1_5.arguments
        var88 = var88.NumColumns
        if any__GetParentWidget_result1_5._columnIndex == var88 then
            var88 = 1
            any__GetParentWidget_result1_5._columnIndex = var88
            var88 = any__GetParentWidget_result1_5._rowIndex
            var88 += 1
            any__GetParentWidget_result1_5._rowIndex = var88
        else
            var88 = any__GetParentWidget_result1_5._columnIndex
            var88 += 1
            any__GetParentWidget_result1_5._columnIndex = var88
        end
        var88 = any__GetParentWidget_result1_5._columnIndex
        return var88
    end
    function arg1.NextRow() -- Line 1993
        local any__GetParentWidget_result1 = arg1.Internal._GetParentWidget()
        local var91
        if any__GetParentWidget_result1 == nil then
            var91 = false
        else
            var91 = true
        end
        assert(var91, "Iris.NextRow() can only called when directly within a table.")
        any__GetParentWidget_result1._columnIndex = 1
        any__GetParentWidget_result1._rowIndex += 1
        return any__GetParentWidget_result1._rowIndex
    end
    function arg1.SetColumnIndex(arg1_57) -- Line 2010
        local any__GetParentWidget_result1_7 = arg1.Internal._GetParentWidget()
        local var94
        if any__GetParentWidget_result1_7 == nil then
            var94 = false
        else
            var94 = true
        end
        assert(var94, "Iris.SetColumnIndex() can only called when directly within a table.")
        var94 = false
        if 1 <= arg1_57 then
            if arg1_57 > any__GetParentWidget_result1_7.arguments.NumColumns then
                var94 = false
            else
                var94 = true
            end
        end
        assert(var94, `The index must be between 1 and {any__GetParentWidget_result1_7.arguments.NumColumns}, inclusive.`)
        any__GetParentWidget_result1_7._columnIndex = arg1_57
    end
    function arg1.SetRowIndex(arg1_58) -- Line 2024
        local any__GetParentWidget_result1_4 = arg1.Internal._GetParentWidget()
        local var97
        if any__GetParentWidget_result1_4 == nil then
            var97 = false
        else
            var97 = true
        end
        assert(var97, "Iris.SetRowIndex() can only called when directly within a table.")
        if 1 > arg1_58 then
            var97 = false
        else
            var97 = true
        end
        assert(var97, "The index must be greater or equal to 1.")
        any__GetParentWidget_result1_4._rowIndex = arg1_58
    end
    function arg1.NextHeaderColumn() -- Line 2038
        local any__GetParentWidget_result1_2 = arg1.Internal._GetParentWidget()
        local var100
        if any__GetParentWidget_result1_2 == nil then
            var100 = false
        else
            var100 = true
        end
        assert(var100, "Iris.NextHeaderColumn() can only called when directly within a table.")
        any__GetParentWidget_result1_2._rowIndex = 0
        var100 = any__GetParentWidget_result1_2._columnIndex % any__GetParentWidget_result1_2.arguments.NumColumns
        any__GetParentWidget_result1_2._columnIndex = var100 + 1
        return any__GetParentWidget_result1_2._columnIndex
    end
    function arg1.SetHeaderColumnIndex(arg1_59) -- Line 2057
        local any__GetParentWidget_result1_6 = arg1.Internal._GetParentWidget()
        local var103
        if any__GetParentWidget_result1_6 == nil then
            var103 = false
        else
            var103 = true
        end
        assert(var103, "Iris.SetHeaderColumnIndex() can only called when directly within a table.")
        var103 = false
        if 1 <= arg1_59 then
            if arg1_59 > any__GetParentWidget_result1_6.arguments.NumColumns then
                var103 = false
            else
                var103 = true
            end
        end
        assert(var103, `The index must be between 1 and {any__GetParentWidget_result1_6.arguments.NumColumns}, inclusive.`)
        any__GetParentWidget_result1_6._rowIndex = 0
        any__GetParentWidget_result1_6._columnIndex = arg1_59
    end
    function arg1.SetColumnWidth(arg1_60, arg2) -- Line 2078
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local any__GetParentWidget_result1_3 = arg1.Internal._GetParentWidget()
        local var106
        if any__GetParentWidget_result1_3 == nil then
            var106 = false
        else
            var106 = true
        end
        assert(var106, "Iris.SetColumnWidth() can only called when directly within a table.")
        var106 = false
        if 1 <= arg1_60 then
            if arg1_60 > any__GetParentWidget_result1_3.arguments.NumColumns then
                var106 = false
            else
                var106 = true
            end
        end
        assert(var106, `The index must be between 1 and {any__GetParentWidget_result1_3.arguments.NumColumns}, inclusive.`)
        var106 = any__GetParentWidget_result1_3.state
        var106 = var106.widths
        var106 = var106.value
        var106 = any__GetParentWidget_result1_3.state
        var106 = var106.widths
        var106 = var106.value
        var106[arg1_60] = arg2
        var106 = any__GetParentWidget_result1_3.state
        var106 = var106.widths
        if arg2 == var106[arg1_60] then
        else
        end
        var106 = var106:set
        var106(any__GetParentWidget_result1_3.state.widths.value, true)
    end
end