local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local module_upvr = {
    mapPlayerRolling = {};
    mapLastRollTime = {};
    onRollBegan = Signal.new();
    onRollEnded = Signal.new();
}
local Players_upvr = game:GetService("Players")
local Falling_upvr = require(ReplicatedStorage.Game.Falling)
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local any_new_result1_upvr_2 = require(ReplicatedStorage.Std.RateLimiter).new(10, 10)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local UserGameSettings_upvr = UserSettings():GetService("UserGameSettings")
local RunService_upvr = game:GetService("RunService")
function module_upvr.attemptRoll() -- Line 25
    local LocalPlayer_upvr = Players_upvr.LocalPlayer
    local PrimaryPart = LocalPlayer_upvr.Character.PrimaryPart
    local Humanoid_upvr = PrimaryPart.Parent:FindFirstChild("Humanoid")
    local var15_upvw
    if Humanoid_upvr.Sit or Humanoid_upvr.PlatformStand then return end
    if Humanoid_upvr.WalkSpeed < 4 then return end
    if Falling_upvr.IsRagdolling() then return end
    if Falling_upvr.IsSkydiving() then return end
    if CharacterUtil_upvr.IsCrawling then return end
    local RaycastParams_new_result1 = RaycastParams.new()
    local tbl = {}
    var15_upvw = LocalPlayer_upvr.Character
    tbl[1] = var15_upvw
    RaycastParams_new_result1.FilterDescendantsInstances = tbl
    var15_upvw = PrimaryPart.Position
    if not Raycast_upvr.collidable(var15_upvw, Vector3.new(-0, -1, -0), 32, RaycastParams_new_result1) then return end
    var15_upvw = module_upvr.mapLastRollTime[LocalPlayer_upvr]
    if var15_upvw ~= nil then return end
    var15_upvw = Humanoid_upvr.MoveDirection
    if not any_new_result1_upvr_2:UseBudget(LocalPlayer_upvr.UserId, 1) then return end
    if var15_upvw.Magnitude < 0.25 then
        var15_upvw = PrimaryPart.CFrame.LookVector
    end
    local any_new_result1_upvr = Maid_upvr.new()
    local LinearVelocity_upvr = Instance.new("LinearVelocity")
    LinearVelocity_upvr.Attachment0 = PrimaryPart:FindFirstChild("RootAttachment")
    LinearVelocity_upvr.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
    LinearVelocity_upvr.PrimaryTangentAxis = Vector3.new(1, 0, 0)
    LinearVelocity_upvr.SecondaryTangentAxis = Vector3.new(0, 0, 1)
    LinearVelocity_upvr.MaxForce = PrimaryPart.AssemblyMass * 500
    LinearVelocity_upvr.Parent = PrimaryPart
    any_new_result1_upvr:GiveTask(LinearVelocity_upvr)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "ImpulseAttachment"
    Attachment.Parent = PrimaryPart
    local AlignOrientation_upvr = Instance.new("AlignOrientation")
    AlignOrientation_upvr.Name = "ImpulseAlignOrientation"
    AlignOrientation_upvr.Attachment0 = Attachment
    AlignOrientation_upvr.Mode = Enum.OrientationAlignmentMode.OneAttachment
    AlignOrientation_upvr.RigidityEnabled = true
    AlignOrientation_upvr.CFrame = Attachment.WorldCFrame
    AlignOrientation_upvr.Parent = PrimaryPart
    any_new_result1_upvr:GiveTask(function() -- Line 95
        task.delay(0.1, function() -- Line 97
            AlignOrientation_upvr:Destroy()
        end)
    end)
    any_new_result1_upvr:GiveTask(Attachment)
    Humanoid_upvr:ChangeState(Enum.HumanoidStateType.Physics)
    any_new_result1_upvr:GiveTask(function() -- Line 106
        if Humanoid_upvr:GetState() == Enum.HumanoidStateType.Physics and Humanoid_upvr:GetStateEnabled(Enum.HumanoidStateType.Running) then
            Humanoid_upvr:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
    if UserGameSettings_upvr.RotationType == Enum.RotationType.CameraRelative then
        UserGameSettings_upvr.RotationType = Enum.RotationType.MovementRelative
        any_new_result1_upvr:GiveTask(function() -- Line 119
            UserGameSettings_upvr.RotationType = Enum.RotationType.CameraRelative
        end)
    end
    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 124
        local var27 = (var15_upvw * Vector3.new(1, 0, 1)).Unit * 70
        LinearVelocity_upvr.PlaneVelocity = Vector2.new(var27.X, var27.Z)
    end))
    module_upvr.onRollBegan:Fire(LocalPlayer_upvr, 0.3)
    module_upvr.mapPlayerRolling[LocalPlayer_upvr] = true
    any_new_result1_upvr:GiveTask(function() -- Line 132
        module_upvr.mapPlayerRolling[LocalPlayer_upvr] = nil
        module_upvr.onRollEnded:Fire(LocalPlayer_upvr)
    end)
    any_new_result1_upvr:GiveTask(task.delay(0.3, function() -- Line 136
        task.defer(any_new_result1_upvr.Destroy, any_new_result1_upvr)
    end))
    module_upvr.mapLastRollTime[LocalPlayer_upvr] = os.clock()
    task.delay(1, function() -- Line 141
        module_upvr.mapLastRollTime[LocalPlayer_upvr] = nil
    end)
    return true
end
function module_upvr.isPlayerRolling(arg1) -- Line 146
    local var31
    if module_upvr.mapPlayerRolling[arg1] ~= true then
        var31 = false
    else
        var31 = true
    end
    return var31
end
return module_upvr