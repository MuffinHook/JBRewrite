local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _() -- Line 11, Named "GetRootPart"
    local Character_2 = LocalPlayer_upvr.Character
    if Character_2 == nil then
        return nil
    end
    local Humanoid_3 = Character_2:FindFirstChild("Humanoid")
    if Humanoid_3 == nil then
        return nil
    end
    return Humanoid_3.RootPart
end
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local RunService_upvr = game:GetService("RunService")
function module_upvr_2.new(arg1, arg2) -- Line 27
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1 == nil then
    else
    end
    assert(true)
    if arg2 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true)
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.Maid = Maid_upvr.new()
    module_upvr.Position = arg1
    module_upvr.Duration = assert(arg2.Duration)
    module_upvr.MaxRadius = assert(arg2.MaxRadius)
    module_upvr.FlagPastLocalPlayer = false
    module_upvr.FlagFirstPass = false
    module_upvr.OnPastLocalPlayer = Signal_upvr.new()
    module_upvr.Maid:GiveTask(module_upvr.OnPastLocalPlayer)
    module_upvr.OnDestroyed = Signal_upvr.new()
    module_upvr.Maid:GiveTask(module_upvr.OnDestroyed)
    module_upvr.SpringBlur = Spring_upvr.new(0, 0, 1, 1)
    module_upvr.SpringColor = Spring_upvr.new(0, 0, 1, 0.5)
    if arg2.FxDisabled ~= true then
    else
    end
    module_upvr.FxDisabled = true
    local Color_2 = arg2.Color
    if not Color_2 then
        Color_2 = Color3.fromRGB(234, 117, 90)
    end
    module_upvr.Color = Color_2
    Color_2 = arg2.TintColor
    local var15 = Color_2
    if not var15 then
        var15 = arg2.Color
        if not var15 then
            var15 = Color3.fromRGB(255, 200, 0)
        end
    end
    module_upvr.TintColor = var15
    module_upvr.Power = arg2.Power or 10
    module_upvr.StartTransparency = arg2.StartTransparency
    module_upvr.EndTransparency = arg2.EndTransparency
    module_upvr:CreateFx()
    module_upvr:CreatePart()
    module_upvr.BornAt = tick()
    module_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 58
        module_upvr:Update()
    end))
    do
        return module_upvr
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr_2.Update(arg1) -- Line 64
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var40 = (tick() - arg1.BornAt) / arg1.Duration
    local var41
    if 1 <= var40 then
        var40 = 1
    end
    local Character = LocalPlayer_upvr.Character
    if Character == nil then
        var41 = nil
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local Humanoid_2 = Character:FindFirstChild("Humanoid")
    if Humanoid_2 == nil then
        var41 = nil
    else
        var41 = Humanoid_2.RootPart
    end
    if var41 ~= nil then
        if (arg1.Position - var41.Position).Magnitude >= var40 * arg1.MaxRadius then
            local _ = false
            -- KONSTANTWARNING: Skipped task `defvar` above
        else
        end
    end
    if arg1.FlagPastLocalPlayer ~= true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.FlagPastLocalPlayer = true
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if true == true and arg1.FlagFirstPass == false then
            arg1.FlagFirstPass = true
            if not arg1.FxDisabled then
                arg1.SpringBlur:Accelerate(200 * arg1.Power)
                arg1.SpringColor:Accelerate(400 * arg1.Power)
                Audio_upvr.ObjectLocal(LocalPlayer_upvr, 3217484827)
            end
            arg1.OnPastLocalPlayer:Fire(arg1.Position - var41.Position)
        end
    end
    local any_Update_result1_3 = arg1.SpringBlur:Update()
    if 0.01 > any_Update_result1_3 then
        local _ = false
        -- KONSTANTWARNING: Skipped task `defvar` above
    else
    end
    if true then
        arg1.Blur.Size = any_Update_result1_3
        local var47 = 1 - math.clamp(any_Update_result1_3 / 10, 0, 1) * 0.2
        if var47 < 0.999 then
            arg1.OrangeFrame.Visible = true
        else
            arg1.OrangeFrame.Visible = false
        end
        arg1.OrangeFrame.Transparency = var47
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if arg1.Blur.Enabled ~= true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.Blur.Enabled = true
    end
    local any_Update_result1_6 = arg1.SpringColor:Update()
    if 0.01 >= any_Update_result1_6 then
        local _ = false
        -- KONSTANTWARNING: Skipped task `defvar` above
    else
    end
    if true then
        local clamped = math.clamp(any_Update_result1_6 / 10, 0, 1)
        arg1.ColorCorrection.Saturation = clamped * -1
        arg1.ColorCorrection.TintColor = Color3.new((1 - arg1.TintColor.r) * (1 - clamped) + arg1.TintColor.r, (1 - arg1.TintColor.g) * (1 - clamped) + arg1.TintColor.g, (1 - arg1.TintColor.b) * (1 - clamped) + arg1.TintColor.b)
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if arg1.ColorCorrection.Enabled ~= true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.ColorCorrection.Enabled = true
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    arg1.Mesh.Scale = (Vector3.new(1, 1, 1)) * (var40 * arg1.MaxRadius) * 2
    if arg1.StartTransparency and arg1.EndTransparency then
        arg1.Part.Transparency = arg1.StartTransparency + (arg1.EndTransparency - arg1.StartTransparency) * var40
    end
    if var40 == 1 then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if true == false then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if true == false then
                arg1:Destroy()
            end
        end
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr_2.CreateFx(arg1) -- Line 141
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Enabled = false
    BlurEffect.Parent = game:GetService("Lighting")
    arg1.Blur = BlurEffect
    arg1.Maid:GiveTask(arg1.Blur)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Enabled = false
    ColorCorrectionEffect.Parent = game:GetService("Lighting")
    arg1.ColorCorrection = ColorCorrectionEffect
    arg1.Maid:GiveTask(arg1.ColorCorrection)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = LocalPlayer_upvr.PlayerGui
    arg1.Maid:GiveTask(ScreenGui)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = arg1.Color
    Frame.Visible = false
    Frame.Parent = ScreenGui
    arg1.OrangeFrame = Frame
end
function module_upvr_2.CreatePart(arg1) -- Line 168
    local Part = Instance.new("Part")
    Part.Color = arg1.Color
    Part.Size = Vector3.new(1, 1, 1)
    Part.Material = Enum.Material.Neon
    Part.CastShadow = false
    Part.Anchored = true
    Part.CFrame = CFrame.new(arg1.Position)
    Part.Parent = workspace
    arg1.Maid:GiveTask(Part)
    local SpecialMesh = Instance.new("SpecialMesh")
    SpecialMesh.MeshType = Enum.MeshType.Sphere
    SpecialMesh.Scale = Vector3.new(1, 1, 1)
    SpecialMesh.Parent = Part
    arg1.Mesh = SpecialMesh
    arg1.Part = Part
end
function module_upvr_2.Destroy(arg1) -- Line 190
    arg1.OnDestroyed:Fire()
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr_2