local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr_3 = {
    Index = 1;
    BaseColors = {Color3.new(1, 0, 0), Color3.fromRGB(0, 120, 255), Color3.fromRGB(189, 0, 255), Color3.fromRGB(255, 154, 0), Color3.fromRGB(1, 255, 31), Color3.fromRGB(227, 255, 0)};
}
local function Reset(arg1) -- Line 22
    arg1.Index = 1
end
tbl_upvr_3.Reset = Reset
local random_state_upvr = Random.new()
function tbl_upvr_3.NextColor(arg1) -- Line 25
    if #arg1.BaseColors <= arg1.Index then
        return Color3.fromHSV(random_state_upvr:NextNumber(), 1, 1)
    end
    arg1.Index += 1
    return arg1.BaseColors[arg1.Index]
end
local function MakeTable_upvr(arg1, arg2) -- Line 33, Named "MakeTable"
    local module = {}
    for i = 1, arg2 do
        module[i] = {}
        for i_2 = 1, arg1 do
            module[i][i_2] = 0
        end
    end
    return module
end
local tbl_upvr = {0, 1, 0, -1}
local tbl_upvr_4 = {-1, 0, 1, 0}
local function _(arg1, arg2, arg3) -- Line 44, Named "IsInside"
    local var14 = false
    if 1 <= arg2 then
        var14 = false
        if arg2 <= #arg1[1] then
            var14 = false
            if 1 <= arg3 then
                if arg3 > #arg1 then
                    var14 = false
                else
                    var14 = true
                end
            end
        end
    end
    return var14
end
local function _(arg1) -- Line 76, Named "IsFilled"
    for i_3 = 1, #arg1 do
        for i_4 = 1, #arg1[1] do
            if arg1[i_3][i_4] < 0 then
                return false
            end
        end
    end
    return true
end
local function _(arg1, arg2, arg3, arg4) -- Line 87, Named "IsNextTo"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local FlowGui_upvr = ReplicatedStorage.Resource.FlowGui
local tbl_upvr_2 = {
    IsOpen = false;
    Maid = nil;
    OnFilled = nil;
    SetGrid = function(arg1, arg2, arg3) -- Line 101, Named "SetGrid"
        arg1.FlowId = arg2
        arg1.Grid = arg3
        local len_4 = #arg3
        local len = #arg3[1]
        arg1.GridClean = MakeTable_upvr(len, len_4)
        for i_5 = 1, len_4 do
            for i_6 = 1, len do
                arg1.GridClean[i_5][i_6] = arg1.Grid[i_5][i_6]
            end
        end
        tbl_upvr_3:Reset()
        arg1.Colors = {}
    end;
    ResetAlpha = function(arg1, arg2) -- Line 116, Named "ResetAlpha"
        assert(arg2)
        for i_7 = 1, #arg1.Grid do
            for i_8 = 1, #arg1.Grid[1] do
                if arg1.Grid[i_7][i_8] == arg2 then
                    arg1.Grid[i_7][i_8] = arg1.GridClean[i_7][i_8]
                end
            end
        end
    end;
    Reset = function(arg1) -- Line 127, Named "Reset"
        if arg1.Grid == nil then
            return false
        end
        for i_9 = 1, #arg1.Grid do
            for i_10 = 1, #arg1.Grid[1] do
                arg1.Grid[i_9][i_10] = arg1.GridClean[i_9][i_10]
            end
        end
    end;
    Colors = {};
    Draw = function(arg1) -- Line 139, Named "Draw"
        local len_3 = #arg1.Grid
        local len_8 = #arg1.Grid[1]
        for i_11 = 1, len_3 do
            for i_12 = 1, len_8 do
                local formatted = "%d.%d":format(i_12, i_11)
                if FlowGui_upvr.Board.Inner:FindFirstChild(formatted) == nil then
                    local TextLabel = Instance.new("TextLabel")
                    TextLabel.Name = formatted
                    TextLabel.BorderSizePixel = 0
                    TextLabel.BackgroundTransparency = 0
                    TextLabel.TextSize = 20
                    TextLabel.TextColor3 = Color3.new(0.1, 0.1, 0.1)
                    TextLabel.Size = UDim2.new(1 / len_8 * 0.5, 0, 1 / len_3 * 0.5, 0)
                    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    TextLabel.Position = UDim2.new((i_12 - 1 + 0.5) / len_8, 0, (i_11 - 1 + 0.5) / len_3, 0)
                    TextLabel.Parent = FlowGui_upvr.Board.Inner
                end
                local var35 = arg1.Grid[i_11][i_12]
                if 0 <= var35 then
                    local var36 = arg1.Colors[var35]
                    if var36 == nil then
                        var36 = tbl_upvr_3:NextColor()
                        arg1.Colors[var35] = var36
                    end
                    TextLabel.BackgroundColor3 = var36
                else
                    TextLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                end
                local var37 = arg1.Grid[i_11][i_12]
                if 0 <= var37 then
                    TextLabel.Text = var37
                else
                    TextLabel.Text = ""
                end
            end
        end
    end;
    GetCoordFromMouse = function(arg1, arg2) -- Line 179, Named "GetCoordFromMouse"
        local Inner = FlowGui_upvr.Board.Inner
        local AbsolutePosition = Inner.AbsolutePosition
        local AbsoluteSize = Inner.AbsoluteSize
        local len_2 = #arg1.Grid
        local len_6 = #arg1.Grid[1]
        local clamped_2 = math.clamp(math.floor(len_6 * (arg2.X - AbsolutePosition.X) / AbsoluteSize.X) + 1, 1, len_6)
        local clamped = math.clamp(math.floor(len_2 * (arg2.Y - AbsolutePosition.Y) / AbsoluteSize.Y) + 1, 1, len_2)
        return clamped_2, clamped, arg1.Grid[clamped][clamped_2]
    end;
}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local UserInputService_upvr = game:GetService("UserInputService")
local ChatUtils_upvr = require(ReplicatedStorage.Chat.ChatUtils)
local GuiService_upvr = game:GetService("GuiService")
function tbl_upvr_2.Show(arg1) -- Line 204
    local var50_upvw
    if arg1.IsOpen then
        var50_upvw = "Board was already.. attempting to remedy.."
        warn(var50_upvw)
        tbl_upvr_2:Reset()
        tbl_upvr_2:Hide()
    end
    if arg1.IsOpen ~= false then
        var50_upvw = false
    else
        var50_upvw = true
    end
    assert(var50_upvw)
    arg1.IsOpen = true
    var50_upvw = LocalPlayer_upvr
    var50_upvw = var50_upvw.PlayerGui
    FlowGui_upvr.Parent = var50_upvw
    arg1.Maid = Maid_upvr.new()
    if UserInputService_upvr.GamepadEnabled then
        var50_upvw = false
        ChatUtils_upvr.setEnabled(var50_upvw)
    end
    arg1.Maid:GiveTask(function() -- Line 217
        if UserInputService_upvr.GamepadEnabled then
            ChatUtils_upvr.setEnabled(true)
        end
    end)
    local var52_upvw
    var50_upvw = nil
    local var53_upvw
    local var54_upvw
    local var55_upvw
    local var56_upvw = false
    local function TouchStart_upvr(arg1_2) -- Line 228, Named "TouchStart"
        local any_GetCoordFromMouse_result1_2, any_GetCoordFromMouse_result2_3, any_GetCoordFromMouse_result3_3 = arg1:GetCoordFromMouse(arg1_2)
        local Grid_3 = arg1.Grid
        local var71 = false
        if 1 <= any_GetCoordFromMouse_result1_2 then
            var71 = false
            if any_GetCoordFromMouse_result1_2 <= #Grid_3[1] then
                var71 = false
                if 1 <= any_GetCoordFromMouse_result2_3 then
                    if any_GetCoordFromMouse_result2_3 > #Grid_3 then
                        var71 = false
                    else
                        var71 = true
                    end
                end
            end
        end
        if var71 == false then
            return false
        end
        if any_GetCoordFromMouse_result3_3 < 0 then
            return false
        end
        var53_upvw = any_GetCoordFromMouse_result1_2
        var54_upvw = any_GetCoordFromMouse_result2_3
        var55_upvw = any_GetCoordFromMouse_result3_3
        var52_upvw = var53_upvw
        var50_upvw = var54_upvw
        arg1:ResetAlpha(var55_upvw)
        arg1:Draw()
        var56_upvw = true
    end
    local function TouchStop_upvr(arg1_3) -- Line 242, Named "TouchStop"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var88
        if var88 == false then
            var88 = false
            return var88
        end
        var88 = false
        var56_upvw = var88
        var88 = var53_upvw
        if var88 == var52_upvw then
            var88 = var54_upvw
            if var88 == var50_upvw then
                var88 = arg1:ResetAlpha
                var88(var55_upvw)
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        end
        var88 = false
        for i_13 = 1, 4 do
            local var89 = var53_upvw + tbl_upvr[i_13]
            local var90 = var54_upvw + tbl_upvr_4[i_13]
            local Grid_6 = arg1.Grid
            local var92
            if 1 <= var89 then
                var92 = false
                if var89 <= #Grid_6[1] then
                    var92 = false
                    if 1 <= var90 then
                        if var90 > #Grid_6 then
                            var92 = false
                        else
                            var92 = true
                        end
                    end
                end
            end
            local function decompInlinedCondition_7() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var92 = arg1.GridClean[var90][var89]
                return var92 == var55_upvw
            end
            local function decompInlinedCondition_8() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var92 = var52_upvw
                return var89 ~= var92
            end
            local function decompInlinedCondition_9() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var92 = var50_upvw
                return var90 ~= var92
            end
            if var92 and decompInlinedCondition_7() and (decompInlinedCondition_8() or decompInlinedCondition_9()) then
                var88 = true
            end
        end
        if var88 == false then
            i_13 = var55_upvw
            arg1:ResetAlpha(i_13)
        else
            if arg1.OnConnection == nil then
                error("No OnConnection function set!")
            end
            arg1.OnConnection()
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var88 = arg1:Draw
        var88()
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local function TouchMove_upvr(arg1_4) -- Line 278, Named "TouchMove"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var93 = var56_upvw
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [35.4]
        if nil == false then
            return false
        end
        local function decompInlinedCondition_10() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [43.2]
            return nil ~= var54_upvw
        end
        if var93 ~= var53_upvw or decompInlinedCondition_10() then
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [46.3]
            if nil < 0 then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                arg1.Grid[nil][var93] = var55_upvw
                var53_upvw = var93
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var54_upvw = nil
                arg1:Draw()
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local function connectBoardInput_upvr() -- Line 296, Named "connectBoardInput"
        arg1.Maid:GiveTask(FlowGui_upvr.Board.InputBegan:Connect(function(arg1_5) -- Line 297
            if arg1_5.UserInputType == Enum.UserInputType.MouseButton1 or arg1_5.UserInputType == Enum.UserInputType.Touch then
                TouchStart_upvr(arg1_5.Position)
            end
        end))
        arg1.Maid:GiveTask(FlowGui_upvr.Board.InputEnded:Connect(function(arg1_6) -- Line 302
            if arg1_6.UserInputType == Enum.UserInputType.MouseButton1 or arg1_6.UserInputType == Enum.UserInputType.Touch then
                TouchStop_upvr(arg1_6.Position)
            end
        end))
        arg1.Maid:GiveTask(FlowGui_upvr.Board.InputChanged:Connect(function(arg1_7) -- Line 307
            if arg1_7.UserInputType == Enum.UserInputType.MouseMovement or arg1_7.UserInputType == Enum.UserInputType.Touch then
                TouchMove_upvr(arg1_7.Position)
            end
        end))
    end
    task.defer(function() -- Line 313
        if not arg1.IsOpen or not arg1.Maid then
        else
            connectBoardInput_upvr()
        end
    end)
    arg1.Maid:GiveTask(FlowGui_upvr.Board.Reset.MouseButton1Down:Connect(function() -- Line 320
        arg1:Reset()
        arg1:Draw()
    end))
    arg1.Maid:GiveTask(FlowGui_upvr.Board.Cancel.MouseButton1Down:Connect(function() -- Line 324
        arg1:Hide()
    end))
    tbl_upvr_2:Draw()
    if not GuiService_upvr.AutoSelectGuiEnabled and UserInputService_upvr:GetLastInputType() == Enum.UserInputType.Gamepad1 then
        local Humanoid_upvr = LocalPlayer_upvr.Character:WaitForChild("Humanoid")
        arg1.Maid:GiveTask(Humanoid_upvr.Changed:connect(function() -- Line 334
            Humanoid_upvr.Jump = false
        end))
        local var102_upvw = 1
        local var103_upvw = 1
        local var104_upvw
        local function UpdateGamepadSelection_upvr() -- Line 340, Named "UpdateGamepadSelection"
            local len_7 = #arg1.Grid
            local len_5 = #arg1.Grid[1]
            if var102_upvw < 1 then
                var102_upvw = 1
            end
            if len_5 < var102_upvw then
                var102_upvw = len_5
            end
            if var103_upvw < 1 then
                var103_upvw = 1
            end
            if len_7 < var103_upvw then
                var103_upvw = len_7
            end
            if var104_upvw then
                var104_upvw.Size = UDim2.new(1 / len_5 * 0.5, 0, 1 / len_7 * 0.5, 0)
            end
            local SOME = FlowGui_upvr.Board.Inner:FindFirstChild("%d.%d":format(var102_upvw, var103_upvw))
            assert(SOME)
            SOME.Size = UDim2.new(1 / len_5 * 0.75, 0, 1 / len_7 * 0.75, 0)
            var104_upvw = SOME
            TouchMove_upvr(SOME.AbsolutePosition + SOME.AbsoluteSize * 0.5)
        end
        arg1.Maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_8) -- Line 365
            if arg1_8.UserInputType == Enum.UserInputType.Gamepad1 then
                if arg1_8.KeyCode == Enum.KeyCode.DPadUp then
                    var103_upvw -= 1
                    UpdateGamepadSelection_upvr()
                    return
                end
                if arg1_8.KeyCode == Enum.KeyCode.DPadDown then
                    var103_upvw += 1
                    UpdateGamepadSelection_upvr()
                    return
                end
                if arg1_8.KeyCode == Enum.KeyCode.DPadLeft then
                    var102_upvw -= 1
                    UpdateGamepadSelection_upvr()
                    return
                end
                if arg1_8.KeyCode == Enum.KeyCode.DPadRight then
                    var102_upvw += 1
                    UpdateGamepadSelection_upvr()
                    return
                end
                if arg1_8.KeyCode == Enum.KeyCode.ButtonA then
                    local SOME_2 = FlowGui_upvr.Board.Inner:FindFirstChild("%d.%d":format(var102_upvw, var103_upvw))
                    TouchStart_upvr(SOME_2.AbsolutePosition + SOME_2.AbsoluteSize * 0.5)
                end
            end
        end))
        arg1.Maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_9) -- Line 386
            if arg1_9.UserInputType == Enum.UserInputType.Gamepad1 and arg1_9.KeyCode == Enum.KeyCode.ButtonA then
                local SOME_3 = FlowGui_upvr.Board.Inner:FindFirstChild("%d.%d":format(var102_upvw, var103_upvw))
                TouchStop_upvr(SOME_3.AbsolutePosition + SOME_3.AbsoluteSize * 0.5)
            end
        end))
        UpdateGamepadSelection_upvr()
    end
end
function tbl_upvr_2.Hide(arg1) -- Line 399
    local var112
    if arg1.IsOpen ~= true then
        var112 = false
    else
        var112 = true
    end
    assert(var112)
    var112 = script
    FlowGui_upvr.Parent = var112
    FlowGui_upvr.Board.Inner:ClearAllChildren()
    var112 = arg1.Maid
    assert(var112)
    arg1.Maid:Destroy()
    arg1.Maid = nil
    arg1.IsOpen = false
end
local var113_upvw
local var114_upvw
return {
    Init = function(arg1) -- Line 410, Named "Init"
        var113_upvw = arg1.Event
        var114_upvw = arg1.em
        function tbl_upvr_2.OnConnection() -- Line 413
            var113_upvw:FireServer('r'.."m3rh":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."".."jtsziiy":sub(4, 6):reverse():reverse():reverse().."".."y1h", tbl_upvr_2.FlowId, tbl_upvr_2.Grid)
        end
        function var114_upvw.ytu0xtjw(arg1_10, arg2) -- Line 416
            tbl_upvr_2:SetGrid(arg1_10, arg2)
            tbl_upvr_2:Show()
        end
        function var114_upvw.nesul6qn(arg1_11) -- Line 420
            if tbl_upvr_2.IsOpen and (arg1_11 == nil or tbl_upvr_2.FlowId == arg1_11) then
                tbl_upvr_2:Reset()
                tbl_upvr_2:Hide()
            end
        end
    end;
}