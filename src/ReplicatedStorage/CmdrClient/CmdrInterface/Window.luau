local GuiService_upvr = game:GetService("GuiService")
local StarterGui_upvr = game:GetService("StarterGui")
local UserInputService_upvr = game:GetService("UserInputService")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local tbl_2_upvr = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch}
local module_upvr = {
    Valid = true;
    AutoComplete = nil;
    ProcessEntry = nil;
    OnTextChanged = nil;
    Cmdr = nil;
    HistoryState = nil;
}
local Value_upvr = LocalPlayer_upvr:WaitForChild("CmdrFrameValue").Value
local Line_upvr = Value_upvr:WaitForChild("Line")
local Entry_upvr = Value_upvr:WaitForChild("Entry")
Line_upvr.Parent = nil
function module_upvr.UpdateLabel(arg1) -- Line 29
    local var10
    if arg1.Cmdr.PlaceName and arg1.Cmdr.PlaceName ~= "" then
        var10 = `@{arg1.Cmdr.PlaceName}`
    else
        var10 = ""
    end
    Entry_upvr.TextLabel.Text = `{LocalPlayer_upvr.Name}{var10}$`
end
function module_upvr.GetLabel(arg1) -- Line 35
    return Entry_upvr.TextLabel.Text
end
function module_upvr.UpdateWindowHeight(arg1) -- Line 40
    Value_upvr.CanvasPosition = Vector2.new(0, math.max(Value_upvr.UIListLayout.AbsoluteContentSize.Y + 20 - Value_upvr.AbsoluteWindowSize.Y, 0))
end
function module_upvr.AddLine(arg1, arg2, arg3) -- Line 48
    local var11 = arg3
    if not var11 then
        var11 = {}
    end
    arg3 = var11
    local var12 = arg3
    local tostring_result1 = tostring(arg2)
    if typeof(var12) == "Color3" then
        var12 = {
            Color = var12;
        }
    end
    if #tostring_result1 == 0 then
        module_upvr:UpdateWindowHeight()
    else
        local clone = Line_upvr:Clone()
        clone.Text = arg1.Cmdr.Util.EmulateTabstops(tostring_result1 or "nil", 8)
        local Color = var12.Color
        if not Color then
            Color = clone.TextColor3
        end
        clone.TextColor3 = Color
        Color = var12.RichText or false
        local var17 = Color
        clone.RichText = var17
        if #tostring_result1 >= 150 then
            var17 = false
        else
            var17 = true
        end
        clone.TextWrapped = var17
        clone.Parent = Value_upvr
    end
end
function module_upvr.IsVisible(arg1) -- Line 72
    return Value_upvr.Visible
end
local function _(arg1) -- Line 78, Named "SafeGetCore"
    local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 79
        return StarterGui_upvr:GetCore(arg1)
    end)
    if pcall_result1_2 then
        return pcall_result2_2
    end
    return true
end
local function _(arg1, arg2) -- Line 84, Named "SafeSetCore"
    local _, _ = pcall(function() -- Line 85
        return StarterGui_upvr:SetCore(arg1, arg2)
    end)
end
function module_upvr.SetVisible(arg1, arg2) -- Line 90
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    Value_upvr.Visible = arg2
    local var24_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var24_upvr = UserInputService_upvr
    var24_upvr = var24_upvr.MouseBehavior
    arg1.PreviousMouseBehavior = var24_upvr
    var24_upvr = UserInputService_upvr
    var24_upvr.MouseBehavior = Enum.MouseBehavior.Default
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var26_upvr = "ChatActive"
    local pcall_result1, pcall_result2 = pcall(function() -- Line 79
        return StarterGui_upvr:GetCore(var26_upvr)
    end)
    if pcall_result1 then
        var24_upvr = pcall_result2
    else
        var24_upvr = true
    end
    if not var24_upvr then
        var24_upvr = arg1.PreviousChatActive
        var26_upvr = "ChatActive"
        local pcall_result1_3, _ = pcall(function() -- Line 85
            return StarterGui_upvr:SetCore(var26_upvr, var24_upvr)
        end)
    end
    var24_upvr = Entry_upvr
    var24_upvr = var24_upvr.TextBox:ReleaseFocus
    var24_upvr()
    var24_upvr = arg1.AutoComplete:Hide
    var24_upvr()
    var24_upvr = arg1.PreviousMouseBehavior
    if var24_upvr then
        var24_upvr = UserInputService_upvr
        var24_upvr.MouseBehavior = arg1.PreviousMouseBehavior
        var24_upvr = nil
        arg1.PreviousMouseBehavior = var24_upvr
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Hide(arg1) -- Line 121
    return arg1:SetVisible(false)
end
function module_upvr.Show(arg1) -- Line 126
    return arg1:SetVisible(true)
end
function module_upvr.SetEntryText(arg1, arg2) -- Line 131
    Entry_upvr.TextBox.Text = arg2
    if arg1:IsVisible() then
        Entry_upvr.TextBox:CaptureFocus()
        Entry_upvr.TextBox.CursorPosition = #arg2 + 1
        module_upvr:UpdateWindowHeight()
    end
end
function module_upvr.GetEntryText(arg1) -- Line 142
    return Entry_upvr.TextBox.Text:gsub('\t', "")
end
function module_upvr.SetIsValidInput(arg1, arg2, arg3) -- Line 148
    local var32
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var32 = Color3.fromRGB(255, 255, 255)
        return var32
    end
    if not arg2 or not decompInlinedCondition() then
        var32 = Color3.fromRGB(255, 73, 73)
    end
    Entry_upvr.TextBox.TextColor3 = var32
    arg1.Valid = arg2
    arg1._errorText = arg3
end
function module_upvr.HideInvalidState(arg1) -- Line 154
    Entry_upvr.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function module_upvr.LoseFocus(arg1, arg2) -- Line 159
    arg1:ClearHistoryState()
    if Value_upvr.Visible and not GuiService_upvr.MenuIsOpen and not UserInputService_upvr.TouchEnabled then
        Entry_upvr.TextBox:CaptureFocus()
    elseif GuiService_upvr.MenuIsOpen and Value_upvr.Visible then
        arg1:Hide()
    end
    if arg2 and arg1.Valid then
        wait()
        arg1:SetEntryText("")
        arg1.ProcessEntry(Entry_upvr.TextBox.Text)
    elseif arg2 then
        arg1:AddLine(arg1._errorText, Color3.fromRGB(255, 153, 153))
    end
end
function module_upvr.TraverseHistory(arg1, arg2) -- Line 180
    local any_GetHistory_result1 = arg1.Cmdr.Dispatcher:GetHistory()
    local var34
    if arg1.HistoryState == nil then
        local tbl = {}
        var34 = #any_GetHistory_result1
        tbl.Position = var34 + 1
        tbl.InitialText = arg1:GetEntryText()
        arg1.HistoryState = tbl
    end
    var34 = arg1.HistoryState.Position + arg2
    arg1.HistoryState.Position = math.clamp(var34, 1, #any_GetHistory_result1 + 1)
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var34 = var34.InitialText
        var34 = arg1.HistoryState
        return var34
    end
    if arg1.HistoryState.Position ~= #any_GetHistory_result1 + 1 or not decompInlinedCondition_2() then
        var34 = any_GetHistory_result1[arg1.HistoryState.Position]
    end
    arg1:SetEntryText(var34)
end
function module_upvr.ClearHistoryState(arg1) -- Line 198
    arg1.HistoryState = nil
end
function module_upvr.SelectVertical(arg1, arg2) -- Line 202
    if arg1.AutoComplete:IsVisible() and not arg1.HistoryState then
        arg1.AutoComplete:Select(arg2)
    else
        arg1:TraverseHistory(arg2)
    end
end
local const_number_upvw_2 = 0
local const_number_upvw = 0
function module_upvr.BeginInput(arg1, arg2, arg3) -- Line 213
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1:Hide()
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
Entry_upvr.TextBox.FocusLost:Connect(function(arg1) -- Line 324
    return module_upvr:LoseFocus(arg1)
end)
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 328
    return module_upvr:BeginInput(arg1, arg2)
end)
Entry_upvr.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line 332
    Value_upvr.CanvasPosition = Vector2.new(0, Value_upvr.AbsoluteCanvasSize.Y)
    if Entry_upvr.TextBox.Text:match('\t') then
        Entry_upvr.TextBox.Text = Entry_upvr.TextBox.Text:gsub('\t', "")
    elseif module_upvr.OnTextChanged then
        return module_upvr.OnTextChanged(Entry_upvr.TextBox.Text)
    end
end)
Value_upvr.ChildAdded:Connect(function() -- Line 344
    task.defer(module_upvr.UpdateWindowHeight)
end)
return module_upvr