local Players_upvr = game:GetService("Players")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local ItemCamera_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.RespectCanCollide = true
local function customCollideFunc_upvr(arg1) -- Line 18, Named "customCollideFunc"
    if arg1:GetAttribute("InvisibleToBullets") == true then
        return false
    end
    return arg1.CanCollide
end
local module_2_upvr = {
    __ClassName = "Item";
}
module_2_upvr.__index = module_2_upvr
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local random_state_upvr = Random.new()
local function new(arg1, arg2) -- Line 28
    assert(arg1)
    local Character = arg1.Character
    assert(Character)
    local Humanoid = Character:FindFirstChild("Humanoid")
    assert(Humanoid)
    local UpperTorso = Character:FindFirstChild("UpperTorso")
    assert(UpperTorso)
    RxInstanceUtils_upvr.yieldForProperty(Character, "PrimaryPart")
    local PrimaryPart = Character.PrimaryPart
    assert(PrimaryPart)
    local Neck = Character:FindFirstChild("Head"):FindFirstChild("Neck")
    assert(Neck)
    local Waist = UpperTorso:FindFirstChild("Waist")
    assert(Waist)
    local Root = Character:FindFirstChild("LowerTorso"):FindFirstChild("Root")
    assert(Root)
    local module_upvr = {}
    setmetatable(module_upvr, module_2_upvr)
    module_upvr.Maid = Maid_upvr.new()
    module_upvr.maid = module_upvr.Maid
    module_upvr.Player = arg1
    module_upvr.Character = Character
    module_upvr.Humanoid = Humanoid
    module_upvr.RootPart = PrimaryPart
    module_upvr.UpperTorso = UpperTorso
    module_upvr.JointNeck = Neck
    module_upvr.JointWaist = Waist
    module_upvr.JointRoot = Root
    module_upvr.Locked = false
    local var19 = customCollideFunc_upvr
    module_upvr._customCollideFunc = var19
    if arg1 ~= LocalPlayer_upvr then
        var19 = false
    else
        var19 = true
    end
    module_upvr.Local = var19
    if module_upvr.Local then
        module_upvr.Maid:GiveTask(task.defer(function() -- Line 67
            local var21
            if arg2 == nil then
                var21 = false
            else
                var21 = true
            end
            ItemCamera_upvr.OnItemEquipped(var21, module_upvr.DoNotHide)
        end))
        module_upvr.Maid:GiveTask(function() -- Line 70
            ItemCamera_upvr.OnItemUnequipped()
        end)
    end
    if module_upvr.Local then
        local var23_upvr = "GunCamera"..tostring(random_state_upvr:NextInteger(1, 1000000000))
        RunService_upvr:BindToRenderStep(var23_upvr, Enum.RenderPriority.Camera.Value + 1, function() -- Line 78
            module_upvr:UpdateCamera()
        end)
        module_upvr.Maid:GiveTask(function() -- Line 81
            RunService_upvr:UnbindFromRenderStep(var23_upvr)
        end)
    end
    return module_upvr
end
module_2_upvr.new = new
function module_2_upvr.TransformLocalMousePosition(arg1, arg2) -- Line 88
    return arg2
end
local CurrentCamera_upvr = workspace.CurrentCamera
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module_2_upvr.ProjectMouseLocationToWorld(arg1, arg2) -- Line 91
    local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(arg2.x, arg2.y)
    local var29
    RaycastParams_new_result1_upvr.FilterDescendantsInstances = arg1.IgnoreList
    local any_collidable_result1 = Raycast_upvr.collidable(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, RaycastParams_new_result1_upvr, customCollideFunc_upvr)
    if any_collidable_result1 then
        var29 = any_collidable_result1.Position
    else
        var29 = any_ViewportPointToRay_result1.Origin + any_ViewportPointToRay_result1.Direction * 999
    end
    return arg1:TransformLocalMousePosition(var29)
end
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
function module_2_upvr.GetMouseLocation(arg1) -- Line 104
    if InputUtils_upvr.isTouch() then
        local ViewportSize_2 = workspace.CurrentCamera.ViewportSize
        return Vector3.new(ViewportSize_2.X * 0.5, ViewportSize_2.Y * 0.5, 0)
    end
    if InputUtils_upvr.isGamepad() then
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.new() -- Line 125
    local module = {}
    setmetatable(module, tbl_upvr)
    module.maid = Maid_upvr.new()
    local function createProgressBarGradient(arg1, arg2) -- Line 130
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local Frame = Instance.new("Frame")
        local var38 = 0.5
        Frame.Size = UDim2.fromScale(var38, 1)
        local var39
        if arg2 then
            var38 = 0
        else
            var38 = 0.5
        end
        var39 = 0
        Frame.Position = UDim2.fromScale(var38, var39)
        Frame.BackgroundTransparency = 1
        Frame.ClipsDescendants = true
        Frame.Parent = arg1
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.BackgroundTransparency = 1
        var39 = 2
        ImageLabel.Size = UDim2.fromScale(var39, 1)
        if arg2 then
            var39 = 0
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var39 = -1
        ImageLabel.Position = UDim2.fromScale(var39, 0)
        ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
        ImageLabel.Parent = Frame
        var39 = "UIGradient"
        local any = Instance.new(var39)
        var39 = NumberSequence.new
        var39 = var39({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1)})
        any.Transparency = var39
        if arg2 then
            var39 = 180
        else
            var39 = 0
        end
        any.Rotation = var39
        any.Parent = ImageLabel
        do
            return any
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "CircularProgressBar"
    Frame_2.Size = UDim2.fromOffset(58, 58)
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.Position = UDim2.fromScale(0.5, 0.5)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Visible = true
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "Progress"
    NumberValue.Parent = Frame_2
    module.progressBar = Frame_2
    module.gradient1 = createProgressBarGradient(Frame_2, true)
    module.gradient2 = createProgressBarGradient(Frame_2, false)
    return module
end
function tbl_upvr.UpdatePosition(arg1, arg2) -- Line 179
    arg1.progressBar.Position = UDim2.new(0, arg2.X, 0, arg2.Y)
end
function tbl_upvr.UpdateProgress(arg1, arg2) -- Line 182
    local clamped = math.clamp(arg2 * 360, 0, 360)
    arg1.gradient1.Rotation = math.clamp(clamped, 180, 360)
    arg1.gradient2.Rotation = math.clamp(clamped, 0, 180)
end
local function Destroy(arg1) -- Line 187
    arg1.maid:Destroy()
    setmetatable(arg1, nil)
end
tbl_upvr.Destroy = Destroy
function module_2_upvr.StartReloadProgressCircle(arg1, arg2, arg3) -- Line 191
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GunReload"
    ScreenGui.Enabled = false
    ScreenGui.Parent = Players_upvr.LocalPlayer.PlayerGui
    local any_new_result1_upvr = tbl_upvr.new()
    ScreenGui.IgnoreGuiInset = true
    local any_new_result1 = Maid_upvr.new()
    any_new_result1.gunReloadScreenGui = ScreenGui
    any_new_result1.circularProgressBar = any_new_result1_upvr
    local var49_upvw = arg3
    if not var49_upvw then
        var49_upvw = os.clock()
    end
    if not arg2 then
    end
    local ReloadTime_upvw = arg1.Config.ReloadTime
    any_new_result1.progressBarUpdater = RunService_upvr.Heartbeat:Connect(function() -- Line 207
        local var52 = (os.clock() - var49_upvw) / ReloadTime_upvw
        if 1 <= var52 then
            arg1.Maid.guiMaid = nil
        else
            any_new_result1_upvr:UpdateProgress(var52)
            any_new_result1_upvr:UpdatePosition(arg1:GetMouseLocation())
        end
    end)
    arg1.Maid.guiMaid = any_new_result1
    any_new_result1_upvr.progressBar.Parent = ScreenGui
    ScreenGui.Enabled = true
end
function module_2_upvr.DefaultDisableCamLock(arg1) -- Line 223
    if arg1.Local then
        local Locked_upvr = ItemCamera_upvr.Locked
        if ItemCamera_upvr.Locked == true then
            ItemCamera_upvr.Locked = false
            arg1:UpdateCameraLocked()
        end
        if Locked_upvr then
            arg1.Maid:GiveTask(function() -- Line 232
                ItemCamera_upvr.Locked = Locked_upvr
            end)
        end
    end
end
function module_2_upvr.UpdateCamera(arg1) -- Line 238
    ItemCamera_upvr.Update()
end
function module_2_upvr.UpdateCameraLocked(arg1) -- Line 241
    if ItemCamera_upvr.Locked then
        ItemCamera_upvr.OnItemEquipped(true, arg1.DoNotHide)
    else
        ItemCamera_upvr.OnItemUnequipped()
    end
end
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
function module_2_upvr.InputBegan(arg1, arg2, arg3) -- Line 249
    if arg3 then
    else
        if arg2.UserInputType ~= Enum.UserInputType.Keyboard or arg2.KeyCode ~= Enum.KeyCode.V or arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonB then
            else
            end
        end
        if true then
            ItemCamera_upvr.setLocked(not ItemCamera_upvr.Locked)
            GameSettingsService_upvr.setValue(ItemCamera_upvr.UISetting, ItemCamera_upvr.Locked)
        end
    end
end
function module_2_upvr.InputEnded(arg1, ...) -- Line 261
    error("TODO: Implement")
end
function module_2_upvr.Destroy(arg1) -- Line 264
    arg1.Maid:Destroy()
    arg1.Maid = nil
    arg1.Destroyed = true
    setmetatable(arg1, nil)
end
return module_2_upvr