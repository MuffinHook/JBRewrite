local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local function _(arg1, arg2) -- Line 19, Named "ShortestAngle"
    return (arg1 - arg2 + math.pi) % (-math.pi*2) - math.pi + arg2
end
local function LookAt_upvr(arg1, arg2) -- Line 23, Named "LookAt"
    local Unit = (arg2 - arg1).Unit
    local any_Cross_result1 = Unit:Cross(Vector3.new(1, 0, 0))
    return CFrame.fromMatrix(arg1, any_Cross_result1, any_Cross_result1:Cross(Unit))
end
local SpotlightConstants_upvr = require(script.Parent.SpotlightConstants)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr_2.new(arg1) -- Line 35
    assert(arg1)
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.SpotlightMotor = arg1
    module_upvr.Maid = Maid_upvr.new()
    local Attachment = Instance.new("Attachment")
    module_upvr.Attachment = Attachment
    Attachment.Parent = module_upvr.SpotlightMotor.Part1
    local PointLight = Instance.new("PointLight")
    PointLight.Range = 32
    PointLight.Enabled = false
    PointLight.Parent = module_upvr.Attachment
    module_upvr.PointLight = PointLight
    local Beam = module_upvr.SpotlightMotor.Part0.Parent.Light.Beam
    Beam.Attachment1 = Attachment
    module_upvr.Beam = Beam
    module_upvr.SpringMouseLocation = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.8, 20)
    module_upvr.SpringAngles = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.8, 20)
    module_upvr.LastMouseWorldPosition = nil
    module_upvr.LastMouseWorldNormal = nil
    module_upvr:SetAngles(Vector3.new())
    module_upvr:SetDistance(0)
    module_upvr:SetEnabled(false)
    module_upvr.LastUpdateAngleDistance = 0
    module_upvr.RemoteEvent = arg1:WaitForChild("RemoteEvent")
    local OnValue_upvr = arg1:WaitForChild("OnValue")
    module_upvr.OnValue = OnValue_upvr
    module_upvr.Maid:GiveTask(OnValue_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 72
        module_upvr:SetEnabled(OnValue_upvr.Value)
    end))
    local AngleValue_upvr = arg1:WaitForChild("AngleValue")
    module_upvr.Maid:GiveTask(AngleValue_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 76
        module_upvr:SetAngles(AngleValue_upvr.Value)
    end))
    local DistanceValue_upvr = arg1:WaitForChild("DistanceValue")
    module_upvr.Maid:GiveTask(DistanceValue_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 80
        module_upvr:SetDistance(DistanceValue_upvr.Value)
    end))
    module_upvr.PoliceValue = arg1:WaitForChild("PoliceValue")
    module_upvr.IgnoreList = {workspace.Vehicles, LocalPlayer_upvr.Character}
    return module_upvr
end
function module_upvr_2.TransformLocalMousePosition(arg1, arg2) -- Line 90
    return arg2
end
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
function module_upvr_2.ProjectMouseLocationToWorld(arg1, arg2) -- Line 93
    local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(arg2.x, arg2.y)
    local _, any_RayIgnoreNonCollideWithIgnoreList_result2, any_RayIgnoreNonCollideWithIgnoreList_result3 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, arg1.IgnoreList)
    return arg1:TransformLocalMousePosition(any_RayIgnoreNonCollideWithIgnoreList_result2), any_RayIgnoreNonCollideWithIgnoreList_result3
end
function module_upvr_2.GetMouseLocation(arg1) -- Line 100
    if InputUtils_upvr.isTouch() then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.875, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
function module_upvr_2.SetEnabled(arg1, arg2) -- Line 111
    if arg2 then
        arg1.Maid.UpdateLoop = RunService_upvr.Heartbeat:Connect(function() -- Line 113
            arg1:Update()
        end)
    else
        arg1.Maid.UpdateLoop = nil
    end
    arg1.Beam.Enabled = arg2
    arg1.PointLight.Enabled = arg2
    if not arg2 or not Enum.Material.Neon then
    end
    arg1.Beam.Parent.Material = Enum.Material.Plastic
end
function module_upvr_2.RequestToggle(arg1) -- Line 123
    if arg1.OnValue.Value then
        arg1.RemoteEvent:FireServer(SpotlightConstants_upvr.EVENT_DISABLE)
        arg1:UnhookLocal()
    else
        arg1.RemoteEvent:FireServer(SpotlightConstants_upvr.EVENT_ENABLE)
        arg1:HookLocal()
    end
end
function module_upvr_2.HookLocal(arg1) -- Line 132
    local var31
    if arg1.Maid.LocalMaid ~= nil then
        var31 = false
    else
        var31 = true
    end
    assert(var31)
    var31 = Maid_upvr
    var31 = var31.new()
    arg1.Maid.LocalMaid = var31
    var31 = "Part"
    local any = Instance.new(var31)
    var31 = Vector3.new(64, 64, 0.10000)
    any.Size = var31
    var31 = true
    any.Anchored = var31
    var31 = 1
    any.Transparency = var31
    var31 = false
    any.CanCollide = var31
    var31 = workspace
    any.Parent = var31
    var31 = Instance.new("Decal")
    var31.Texture = "rbxassetid://5477999115"
    var31.Face = Enum.NormalId.Front
    var31.Transparency = 0.5
    var31.Parent = any
    arg1.FakeCircle = any
    local any_ProjectMouseLocationToWorld_result1, any_ProjectMouseLocationToWorld_result2 = arg1:ProjectMouseLocationToWorld(arg1:GetMouseLocation())
    arg1.LastMouseWorldPosition = any_ProjectMouseLocationToWorld_result1
    arg1.LastMouseWorldNormal = any_ProjectMouseLocationToWorld_result2
    arg1.Maid.LocalMaid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 152
        arg1:UpdateMousePosition()
    end))
    arg1.Maid.LocalMaid:GiveTask(function() -- Line 155
        arg1.Attachment.Position = Vector3.new()
    end)
    arg1.Maid.LocalMaid:GiveTask(function() -- Line 158
        arg1.FakeCircle:Destroy()
        arg1.FakeCircle = nil
    end)
end
function module_upvr_2.UnhookLocal(arg1) -- Line 163
    if arg1.Maid.LocalMaid ~= nil then
        arg1.Maid.LocalMaid = nil
    end
end
function module_upvr_2.SetAngles(arg1, arg2) -- Line 168
    arg1.SpringAngles:SetTarget(arg2)
end
function module_upvr_2.SetDistance(arg1, arg2) -- Line 171
    arg1.Distance = arg2
end
function module_upvr_2.UpdateMousePosition(arg1) -- Line 175
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var38
    if InputUtils_upvr.isTouch() then
        local any_ProjectMouseLocationToWorld_result1_3, any_ProjectMouseLocationToWorld_result2_3 = arg1:ProjectMouseLocationToWorld(arg1:GetMouseLocation())
        var38 = any_ProjectMouseLocationToWorld_result2_3
    elseif InputUtils_upvr.isGamepad() then
        local _, any_ProjectMouseLocationToWorld_result2_2 = arg1:ProjectMouseLocationToWorld(arg1:GetMouseLocation())
        var38 = any_ProjectMouseLocationToWorld_result2_2
    elseif UserInputService_upvr:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or not arg1.LastMouseWorldPosition then
        local any_ProjectMouseLocationToWorld_result1_2, any_ProjectMouseLocationToWorld_result2_4 = arg1:ProjectMouseLocationToWorld(arg1:GetMouseLocation())
        var38 = any_ProjectMouseLocationToWorld_result2_4
        arg1.LastMouseWorldPosition = any_ProjectMouseLocationToWorld_result1_2
        arg1.LastMouseWorldNormal = var38
    else
        var38 = arg1.LastMouseWorldNormal
    end
    local var45 = arg1.LastMouseWorldPosition - arg1.Beam.Attachment0.WorldPosition
    local Magnitude = var45.Magnitude
    if 160 < Magnitude then
        Magnitude = 160
        if arg1.FakeCircle.Parent ~= nil then
            arg1.FakeCircle.Parent = nil
        end
    else
        local var47 = var45.Unit * Magnitude + arg1.Beam.Attachment0.WorldPosition
        arg1.FakeCircle.CFrame = CFrame.new(var47, var47 + var38)
        if arg1.FakeCircle.Parent ~= workspace then
            arg1.FakeCircle.Parent = workspace
        end
    end
    arg1:SetDistance(Magnitude)
    local any_ToEulerAnglesXYZ_result1, any_ToEulerAnglesXYZ_result2, any_ToEulerAnglesXYZ_result3 = arg1.SpotlightMotor.Part1.CFrame:ToObjectSpace(LookAt_upvr(arg1.SpotlightMotor.Part1.Position, arg1.Beam.Attachment0.WorldPosition + arg1.SpotlightMotor.Part1.CFrame.LookVector * 160)):ToEulerAnglesXYZ()
    local x = arg1.SpringAngles:Update().x
    local vector3 = Vector3.new((any_ToEulerAnglesXYZ_result1 - x + math.pi) % (-math.pi*2) - math.pi + x, any_ToEulerAnglesXYZ_result2, any_ToEulerAnglesXYZ_result3)
    arg1:SetAngles(vector3)
    local tick_result1 = tick()
    if 0.125 < tick_result1 - arg1.LastUpdateAngleDistance then
        arg1.LastUpdateAngleDistance = tick_result1
        arg1.RemoteEvent:FireServer(SpotlightConstants_upvr.EVENT_UPDATE_ANGLE_DISTANCE, vector3, Magnitude)
    end
end
local Math_upvr = require(ReplicatedStorage.Module.Math)
function module_upvr_2.Update(arg1) -- Line 231
    local any_Update_result1 = arg1.SpringAngles:Update()
    local Distance = arg1.Distance
    arg1.SpotlightMotor.C1 = CFrame.fromEulerAnglesXYZ(any_Update_result1.X, any_Update_result1.Y, any_Update_result1.Z)
    local CFrame = arg1.SpotlightMotor.Part0.CFrame
    arg1.Attachment.WorldPosition = CFrame.p + CFrame.LookVector * (Distance + 4)
    arg1.Beam.TextureLength = Distance + 4
    arg1.Beam.Width1 = Distance * 2 / 3
    if arg1.Maid.LocalMaid == nil and arg1.PoliceValue.Value then
        local Character_2 = LocalPlayer_upvr.Character
        if Character_2 ~= nil then
            local Humanoid_2 = Character_2:FindFirstChild("Humanoid")
            if Humanoid_2 ~= nil then
                local RootPart = Humanoid_2.RootPart
                if RootPart ~= nil then
                    arg1.IsLocalInSpotlight = Math_upvr.DoesFixedConeIntersectSphere(CFrame.p, CFrame.LookVector, Distance + 4, 0.23561944901923448, RootPart.Position, 3)
                end
            end
        end
    end
end
function module_upvr_2.Destroy(arg1) -- Line 274
    arg1.IsLocalInSpotlight = false
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr_2