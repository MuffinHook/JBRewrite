local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.Init(arg1) -- Line 10
    local any_GetScreenGui_result1 = arg1.GetScreenGui("AmmoGui")
    module_2_upvr.Gui = any_GetScreenGui_result1
    module_2_upvr.Frame = any_GetScreenGui_result1:WaitForChild("Frame")
    module_2_upvr.Frame2 = any_GetScreenGui_result1:WaitForChild("Frame2")
end
function module_2_upvr.SetColor(arg1) -- Line 18
end
function module_2_upvr.new(arg1) -- Line 19
    local module = {}
    setmetatable(module, module_2_upvr)
    module_2_upvr.Gui.Enabled = true
    module_2_upvr.Frame.ItemName.Text = string.format("// %s", arg1)
    module_2_upvr.Frame2.ItemName.Text = string.format("// %s", arg1)
    return module
end
function module_2_upvr.Update(arg1, arg2, arg3) -- Line 29
    if arg3 ~= nil then
        arg1.MaxAmmo = arg3
    end
    local Frame = module_2_upvr.Frame
    local Frame2 = module_2_upvr.Frame2
    Frame.Ammo.Text = string.format("%d/", arg2)
    Frame.MagSize.Text = arg3 or ""
    Frame2.Ammo.Text = string.format("%d/", arg2)
    local MagSize = Frame2.MagSize
    MagSize.Text = arg3 or ""
    if arg2 > 0 then
        MagSize = false
    else
        MagSize = true
    end
    if MagSize then
        Frame.Ammo.TextColor3 = Color3.new(1, 0, 0)
        Frame.MagSize.TextColor3 = Color3.new(1, 0, 0)
        Frame2.Ammo.TextColor3 = Color3.new(1, 0, 0)
        Frame2.MagSize.TextColor3 = Color3.new(1, 0, 0)
    else
        Frame.Ammo.TextColor3 = Color3.new(1, 1, 1)
        Frame.MagSize.TextColor3 = Color3.new(1, 1, 1)
        Frame2.Ammo.TextColor3 = Color3.new(1, 1, 1)
        Frame2.MagSize.TextColor3 = Color3.new(1, 1, 1)
    end
end
local CurrentCamera_upvr = workspace.CurrentCamera
function module_2_upvr.UpdatePosition(arg1, arg2, arg3) -- Line 54
    local Frame_2 = module_2_upvr.Frame
    local any_WorldToScreenPoint_result1, any_WorldToScreenPoint_result2 = CurrentCamera_upvr:WorldToScreenPoint(arg2.Position)
    local var12
    if (CurrentCamera_upvr.CFrame.Position - CurrentCamera_upvr.Focus.Position).Magnitude >= 4 then
        var12 = false
    else
        var12 = true
    end
    if any_WorldToScreenPoint_result1 then
        if Frame_2.Visible == false then
            Frame_2.Position = UDim2.new(0, any_WorldToScreenPoint_result1.X + 30, 0, any_WorldToScreenPoint_result1.Y + 75)
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            Frame_2.Position = Frame_2.Position:Lerp(UDim2.new(0, any_WorldToScreenPoint_result1.X + 30, 0, any_WorldToScreenPoint_result1.Y + 75), (0.25) * (60 * arg3))
        end
    end
    local var13 = any_WorldToScreenPoint_result2
    if var13 then
        var13 = not var12
    end
    Frame_2.Visible = var13
    module_2_upvr.Frame2.Visible = not Frame_2.Visible
end
function module_2_upvr.Destroy(arg1) -- Line 70
    module_2_upvr.Gui.Enabled = false
    module_2_upvr.Frame.Visible = false
    module_2_upvr.Frame2.Visible = false
end
return module_2_upvr