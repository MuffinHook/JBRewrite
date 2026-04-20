local UserInputService_upvr = game:GetService("UserInputService")
local module = {
    rotatedLine = function(arg1, arg2, arg3, arg4, arg5) -- Line 8, Named "rotatedLine"
        local var3 = arg3 - arg1
        local var4 = arg4 - arg2
        return (arg1 + arg3) * 0.5, (arg2 + arg4) * 0.5, math.sqrt(var4 * var4 * arg5 * arg5 + var3 * var3), math.atan2(var4 * arg5, var3)
    end;
}
local CurrentCamera_upvr = workspace.CurrentCamera
function module.isSmallScreen() -- Line 18
    local X = CurrentCamera_upvr.ViewportSize.X
    if math.min(X, CurrentCamera_upvr.ViewportSize.y) > 500 then
        X = false
    else
        X = true
    end
    return X
end
function module.shouldHaveTouchControls() -- Line 24
    return UserInputService_upvr.TouchEnabled
end
function module.getViewportSizeChangedSignal() -- Line 27
    return workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
end
local GuiService_upvr = game:GetService("GuiService")
local GamepadService_upvr = game:GetService("GamepadService")
function module.selectIfGamepad(arg1) -- Line 30
    if GuiService_upvr.AutoSelectGuiEnabled then
        GamepadService_upvr:EnableGamepadCursor(arg1)
    elseif UserInputService_upvr:GetLastInputType() == Enum.UserInputType.Gamepad1 then
        GuiService_upvr.SelectedObject = arg1
    end
end
function module.isGuiAncestryVisible(arg1) -- Line 40
    repeat
        if arg1:IsA("GuiObject") and not arg1.Visible then
            return false
        end
        if arg1:IsA("ScreenGui") and not arg1.Enabled then
            return false
        end
    until not arg1.Parent
    return true
end
return module