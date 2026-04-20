local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
local InputUtils_upvr = require(script.Parent.InputUtils)
local ControllerImage_upvr = require(ReplicatedStorage.ControllerImage)
local UserInputService_upvr = game:GetService("UserInputService")
local CircularProgressBar_upvr = require(script.Parent.CircularProgressBar)
return function(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 9
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local formatted_4 = string.format("%s_%d_%s", arg2, arg3, "pressed")
    local formatted_5_upvr = string.format("%s_%d_%s", arg2, arg3, "onReleased")
    local var40_upvr = arg1[string.format("%s_%d_%s", arg2, arg3, "button")]
    local var41 = arg1[string.format("%s_%d_%s", arg2, arg3, "keyCode")]
    local var42
    if not var42 then
        var42 = Color3.new(1, 1, 1)
    end
    if var40_upvr and var40_upvr.saturateTo then
        var42 = ColorUtils_upvr.saturateTo(var42, var40_upvr.saturateTo)
    end
    local any_brightenBy_result1_2 = ColorUtils_upvr.brightenBy(var42, -0.3)
    local tbl_9 = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 0.8, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        Active = false;
        Image = arg1[string.format("%s_%d_%s", arg2, arg3, "image")];
    }
    if not arg1[formatted_4] or not any_brightenBy_result1_2 then
    end
    tbl_9.ImageColor3 = var42
    local module_2 = {}
    if var40_upvr then
        local var46
        if var40_upvr.title then
            var46 = 0.4
            tbl_9.Position = UDim2.new(0.5, 0, var46, 0)
            var46 = 0.8
            tbl_9.Size = UDim2.new(1, 0, var46, 0)
            local tbl = {}
            var46 = 1
            tbl.BackgroundTransparency = var46
            var46 = UDim2.new(0.8, 0, 0.2, 0)
            tbl.Size = var46
            var46 = Vector2.new(0.5, 0)
            tbl.AnchorPoint = var46
            var46 = UDim2.new(0.5, 0, 0.6, 0)
            tbl.Position = var46
            local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var46 = any_brightenBy_result1_2
                return var46
            end
            if not arg1[formatted_4] or not decompInlinedCondition_3() then
                var46 = var42
            end
            tbl.TextColor3 = var46
            var46 = true
            tbl.TextScaled = var46
            var46 = var40_upvr.title
            tbl.Text = var46
            var46 = Enum.Font.LuckiestGuy
            tbl.Font = var46
            module_2.Label = createElement_upvr("TextLabel", tbl)
        end
    end
    module_2.ImageLabel = createElement_upvr("ImageLabel", tbl_9, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
    })
    if arg1[formatted_4] then
        local _ = 0.5
    else
    end
    if var41 then
        local var51
        if var51 then
            var51 = ControllerImage_upvr
            local tbl_7 = {
                AnchorPoint = Vector2.new(0.5, 0.5);
            }
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tbl_7.Size = UDim2.new(0.7 * 1, 0, 0.7 * 1, 0)
            tbl_7.Position = UDim2.new(0.8, 0, 0.8, 0)
            tbl_7.ZIndex = 4
            var51 = var51:GetRoactImageLabel(var41, "Dark", tbl_7)
            module_2.Input = var51
        else
            var51 = UserInputService_upvr:GetStringForKeyCode(var41)
            if var41 == Enum.KeyCode.LeftShift or var41 == Enum.KeyCode.RightShift then
                var51 = "Shift"
            elseif var41 == Enum.KeyCode.LeftControl or var41 == Enum.KeyCode.RightControl then
                var51 = "Ctrl"
            end
            if #var51 == 0 then
                var51 = var41.Name
            end
            local tbl_4 = {
                BackgroundTransparency = 1;
                AnchorPoint = Vector2.new(0.5, 0.5);
            }
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tbl_4.Size = UDim2.new(0.5 * 1, 0, 0.5 * 1, 0)
            tbl_4.Position = UDim2.new(0.9, 0, 0.9, 0)
            tbl_4.TextColor3 = var42
            tbl_4.TextStrokeColor3 = Color3.new(0, 0, 0)
            tbl_4.TextStrokeTransparency = 0.7
            tbl_4.Font = Enum.Font.LuckiestGuy
            tbl_4.TextScaled = true
            tbl_4.Text = var51:upper()
            tbl_4.ZIndex = 4
            module_2.Input = createElement_upvr("TextLabel", tbl_4)
            local var54
        end
    end
    if var40_upvr and var40_upvr.progressBinding then
        local tbl_10 = {}
        var54 = var40_upvr.progressBinding
        tbl_10.progressBinding = var54
        var54 = UDim2.fromScale(0.94, 0.94)
        tbl_10.size = var54
        var54 = 3
        tbl_10.zIndex = var54
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var54 = any_brightenBy_result1_2
            return var54
        end
        if not arg1[formatted_4] or not decompInlinedCondition_4() then
            var54 = var42
        end
        tbl_10.color = var54
        module_2.Progress = createElement_upvr(CircularProgressBar_upvr, tbl_10)
    end
    local module_4 = {}
    module_4.ZIndex = arg4
    module_4.BackgroundTransparency = 1
    module_4.Size = arg5
    module_4.AnchorPoint = Vector2.new(0.5, 0.5)
    module_4.Position = arg6
    module_4.Image = "rbxassetid://7852334955"
    if var40_upvr then
    end
    module_4.Active = not var40_upvr.noSink
    if not arg1[formatted_4] or not any_brightenBy_result1_2 then
    end
    module_4.ImageColor3 = var42
    local formatted_2_upvr = string.format("%s_%d_%s", arg2, arg3, "onPressed")
    module_4[Roact_upvr.Event.InputBegan] = function(arg1_3, arg2_3) -- Line 108
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var59
        if var59 == Enum.UserInputType.Touch or arg2_3.UserInputType == Enum.UserInputType.MouseButton1 then
            if var40_upvr.allowTouchSlide then
                if arg2_3.UserInputState ~= Enum.UserInputState.Change then
                    local _ = false
                    -- KONSTANTWARNING: Skipped task `defvar` above
                else
                end
            end
            if arg2_3.UserInputState == Enum.UserInputState.Begin or true then
                var40_upvr._inputTypePressed = arg2_3.UserInputType
                if arg1[formatted_2_upvr] then
                    arg1[formatted_2_upvr](arg2_3.UserInputType)
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var40_upvr._enteredViaSlide = true
                local var62_upvr = arg1[formatted_5_upvr]
                var40_upvr._maid.waitForEnd = arg2_3:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 125
                    if arg2_3.UserInputState == Enum.UserInputState.End then
                        var40_upvr._maid.waitForEnd = nil
                        if var62_upvr then
                            var62_upvr(arg2_3.UserInputType)
                        end
                    end
                end)
            end
        end
    end
    module_4[Roact_upvr.Event.MouseLeave] = function() -- Line 139
        if var40_upvr then
            if var40_upvr._enteredViaSlide then
                var40_upvr._maid.waitForEnd = nil
                local var64 = arg1[formatted_5_upvr]
                if var64 then
                    var64()
                end
            end
        end
    end
    return createElement_upvr("ImageButton", module_4, module_2)
end
