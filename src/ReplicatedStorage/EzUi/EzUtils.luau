-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:40
-- Luau version 6, Types version 3
-- Time taken: 0.002788 seconds

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
    --[[ Upvalues[1]:
        [1]: CurrentCamera_upvr (readonly)
    ]]
    local X = CurrentCamera_upvr.ViewportSize.X
    if math.min(X, CurrentCamera_upvr.ViewportSize.y) > 500 then
        X = false
    else
        X = true
    end
    return X
end
function module.shouldHaveTouchControls() -- Line 24
    --[[ Upvalues[1]:
        [1]: UserInputService_upvr (readonly)
    ]]
    return UserInputService_upvr.TouchEnabled
end
function module.getViewportSizeChangedSignal() -- Line 27
    return workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
end
local GuiService_upvr = game:GetService("GuiService")
local GamepadService_upvr = game:GetService("GamepadService")
function module.selectIfGamepad(arg1) -- Line 30
    --[[ Upvalues[3]:
        [1]: GuiService_upvr (readonly)
        [2]: GamepadService_upvr (readonly)
        [3]: UserInputService_upvr (readonly)
    ]]
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