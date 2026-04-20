local CurrentCamera_upvr = workspace.CurrentCamera
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CinematicCamera_upvr = require(ReplicatedStorage.Module.CinematicCamera)
local SpectateGui_upvr = ReplicatedStorage.Resource.SpectateGui
local function _(arg1) -- Line 27, Named "GetHumanoid"
    assert(arg1)
    local Character_3 = arg1.Character
    if Character_3 then
        local Humanoid = Character_3:FindFirstChild("Humanoid")
        if Humanoid then
            return Humanoid
        end
    end
    return nil
end
local function _(arg1) -- Line 38, Named "GetRootPart"
    assert(arg1)
    assert(arg1)
    local Character_5 = arg1.Character
    if Character_5 then
        if Character_5:FindFirstChild("Humanoid") then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    end
    local var17
    if var17 then
        local RootPart_2 = var17.RootPart
        if RootPart_2 then
            return RootPart_2
        end
    end
end
local function _(arg1) -- Line 48, Named "SetCenterText"
    SpectateGui_upvr.Spectate.Center.TextLabel.Text = arg1
end
local module_upvr = {
    IsOpen = false;
    NameList = nil;
    SpectatingName = nil;
    Viewing = false;
    Maid = nil;
    Signal = {};
}
local function _() -- Line 64, Named "GetIndexFromName"
    if module_upvr.SpectatingName == nil then
        return nil
    end
    if module_upvr.NameList == nil then
        return nil
    end
    for i = 1, #module_upvr.NameList do
        if module_upvr.NameList[i] == module_upvr.SpectatingName then
            return i
        end
    end
end
local function CycleRight_upvr() -- Line 77, Named "CycleRight"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.SpectatingName == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.NameList == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function CycleLeft_upvr() -- Line 88, Named "CycleLeft"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.SpectatingName == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.NameList == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function ToggleView_upvr() -- Line 99, Named "ToggleView"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local any_MakeCinematicCamera_result1_upvr = CinematicCamera_upvr.MakeCinematicCamera()
local function Heartbeat_upvr(arg1) -- Line 129, Named "Heartbeat"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.NameList and 0 < #module_upvr.NameList then
        print("Choosing new player")
        module_upvr.SpectatingName = module_upvr.NameList[math.random(1, #module_upvr.NameList)]
        SpectateGui_upvr.Spectate.Center.TextLabel.Text = module_upvr.SpectatingName
        return
    end
    print("Could not find new player")
    module_upvr.SpectatingName = nil
    ToggleView_upvr()
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Start() -- Line 166
    local var28
    if module_upvr.IsOpen ~= false then
        var28 = false
    else
        var28 = true
    end
    assert(var28)
    var28 = true
    module_upvr.IsOpen = var28
    var28 = Maid_upvr
    var28 = var28.new()
    module_upvr.Maid = var28
    var28 = LocalPlayer_upvr.PlayerGui
    SpectateGui_upvr.Parent = var28
    var28 = "Spectate"
    SpectateGui_upvr.Spectate.Center.TextLabel.Text = var28
    var28 = nil
    module_upvr.SpectatingName = var28
    var28 = false
    module_upvr.Viewing = var28
    module_upvr.Maid:GiveTask(SpectateGui_upvr.Spectate.Center.MouseButton1Down:Connect(ToggleView_upvr))
    module_upvr.Maid:GiveTask(SpectateGui_upvr.Spectate.ButtonRight.MouseButton1Down:Connect(CycleRight_upvr))
    module_upvr.Maid:GiveTask(SpectateGui_upvr.Spectate.ButtonLeft.MouseButton1Down:Connect(CycleLeft_upvr))
    module_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(Heartbeat_upvr))
end
function module_upvr.Stop() -- Line 182
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var33
    if module_upvr.IsOpen ~= true then
        var33 = false
    else
        var33 = true
    end
    assert(var33)
    var33 = script
    SpectateGui_upvr.Parent = var33
    module_upvr.Maid:Destroy()
    var33 = nil
    module_upvr.Maid = var33
    var33 = Enum.CameraType.Custom
    CurrentCamera_upvr.CameraType = var33
    local var34 = LocalPlayer_upvr
    assert(var34)
    local Character_2 = var34.Character
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local Humanoid_2 = Character_2:FindFirstChild("Humanoid")
    if Humanoid_2 then
        var33 = Humanoid_2
    else
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var33 = nil
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    CurrentCamera_upvr.CameraSubject = var33
    var33 = false
    module_upvr.IsOpen = var33
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Update(arg1) -- Line 191
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    module_upvr.NameList = arg1
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if nil == nil then
        print("Player no longer exists, will look for new one")
        module_upvr.SpectatingName = nil
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return module_upvr