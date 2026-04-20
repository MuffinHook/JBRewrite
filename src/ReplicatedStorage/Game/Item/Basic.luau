local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local ConstraintUtils_upvr = require(ReplicatedStorage_upvr.Std.ConstraintUtils)
local Item_upvr = require(script.Parent.Item)
local zero_cframe_upvr = CFrame.new()
local function FromAxisAngle_upvr(arg1) -- Line 17, Named "FromAxisAngle"
    local x = arg1.x
    local y = arg1.y
    local z = arg1.z
    local var10 = (x * x + y * y + z * z) ^ 0.5
    if 0.00001 < var10 then
        local var11 = math.sin(var10 * 0.5) / var10
        return CFrame.new(0, 0, 0, var11 * x, var11 * y, var11 * z, math.cos(var10 * 0.5))
    end
    return zero_cframe_upvr
end
local module_upvr = {
    __ClassName = "Basic";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Item_upvr)
function module_upvr.new(arg1, arg2, arg3, arg4) -- Line 32
    local any_new_result1 = Item_upvr.new(arg1, arg4)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.inventoryItemValue = arg2
    any_new_result1.Config = arg3
    any_new_result1.DoNotHide = true
    any_new_result1:SetupModel()
    any_new_result1:AttachModelToPlayer()
    any_new_result1:SetupSprings()
    any_new_result1:Equip()
    return any_new_result1
end
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
function module_upvr.SetupModel(arg1) -- Line 49
    local any_getName_result1 = InventoryItemUtils_upvr.getName(arg1.inventoryItemValue)
    local SOME = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(any_getName_result1)
    if SOME == nil then
        error("Could not find model for item `%s`":format(any_getName_result1))
    end
    local clone = SOME:Clone()
    arg1.Model = clone
    local Center = clone.Skeleton.Center
    arg1.Center = Center
    Joint_upvr.WeldAllTo(clone, Center)
    arg1.Maid:GiveTask(function() -- Line 63
        arg1.Model:Destroy()
        arg1.Model = nil
    end)
end
function module_upvr.SetupArmWelds(arg1) -- Line 68
    Joint_upvr.Weld(arg1.Model.Skeleton.LeftArm, arg1.Center)
    Joint_upvr.Weld(arg1.Model.Skeleton.RightArm, arg1.Center)
    arg1.Model.Skeleton.LeftArm.Anchored = false
    arg1.Model.Skeleton.RightArm.Anchored = false
end
function module_upvr.AttachModelToPlayer(arg1) -- Line 74
    local UpperTorso = arg1.UpperTorso
    arg1.Center.CFrame = UpperTorso.CFrame
    arg1.Model.Parent = workspace.Items
    arg1.Motor = Joint_upvr.BlankMotor(arg1.Center, UpperTorso)
    arg1.Maid:GiveTask(function() -- Line 81
        arg1.Motor:Destroy()
        arg1.Motor = nil
    end)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.Equip(arg1) -- Line 86
    arg1.IK = R15IKv2_upvr.BuildPacketArms(arg1.Character)
    arg1.JointNeckC0 = arg1.JointNeck.C0
    arg1.JointWaistC0 = arg1.JointWaist.C0
    arg1.Maid:GiveTask(function() -- Line 90
        ConstraintUtils_upvr.setJointC0(arg1.JointNeck, arg1.JointNeckC0)
        ConstraintUtils_upvr.setJointC0(arg1.JointWaist, arg1.JointWaistC0)
    end)
    arg1.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 94
        arg1:Stepped()
    end))
    arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 97
        arg1:Heartbeat()
    end))
end
function module_upvr.GetRightArmPosition(arg1) -- Line 101
    return arg1.Model.Skeleton.RightArm.Position
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 105
    return arg1.Model.Skeleton.LeftArm.Position
end
function module_upvr.UpdateArmIK(arg1) -- Line 109
    local IK_2 = arg1.IK
    IK_2.RightArm = arg1:GetRightArmPosition()
    IK_2.LeftArm = arg1:GetLeftArmPosition()
    IK_2.RightAngle = arg1.Config.Motion.RightElbowAngle
    IK_2.LeftAngle = arg1.Config.Motion.LeftElbowAngle
end
function module_upvr.ComputeArmJoints(arg1) -- Line 117
    arg1:UpdateArmIK()
    R15IKv2_upvr.ComputeArms(arg1.IK)
end
function module_upvr.ApplyArmJoints(arg1) -- Line 122
    local IK = arg1.IK
    R15IKv2_upvr.ApplyArms(IK)
    if arg1.Config.Motion.RightWristRotation then
        IK.RightWrist.Transform = arg1.Config.Motion.RightWristRotation
    end
    if arg1.Config.Motion.LeftWristRotation then
        IK.LeftWrist.Transform = arg1.Config.Motion.LeftWristRotation
    end
end
function module_upvr.Stepped(arg1) -- Line 133
    arg1:ApplyArmJoints()
end
function module_upvr.Heartbeat(arg1) -- Line 136
    arg1.Motor.C1 = FromAxisAngle_upvr(arg1.SpringItemRotation:Update()) * CFrame.new(arg1.SpringItemOffset:Update()) * arg1.JointWaist.C1
    ConstraintUtils_upvr.setJointC0(arg1.JointWaist, arg1.JointWaistC0 * FromAxisAngle_upvr(arg1.SpringWaistRotation:Update()))
    ConstraintUtils_upvr.setJointC0(arg1.JointNeck, arg1.JointNeckC0 * FromAxisAngle_upvr(arg1.SpringNeckRotation:Update()))
    arg1:ComputeArmJoints()
end
function module_upvr.TransformLocalMousePosition(arg1, arg2) -- Line 151
    return arg2
end
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.GetMouseLocation(arg1) -- Line 154
    if InputUtils_upvr.isGamepad() then
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
local CurrentCamera_upvr = workspace.CurrentCamera
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
function module_upvr.UpdateMousePosition(arg1) -- Line 174
    local var33
    if arg1.Local then
        local any_GetMouseLocation_result1 = arg1:GetMouseLocation()
        local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(any_GetMouseLocation_result1.x, any_GetMouseLocation_result1.y)
        local any_RayIgnoreNonCollideWithIgnoreList_result1, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, arg1.IgnoreList)
        var33 = arg1:TransformLocalMousePosition(any_RayIgnoreNonCollideWithIgnoreList_result2)
    end
    arg1.MousePosition = var33
end
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function module_upvr.SetupSprings(arg1, arg2) -- Line 185
    if arg1.Local and arg2 and arg2.SpringItemOffset then
        arg1.SpringItemOffset = arg2.SpringItemOffset
        arg1.SpringItemOffset.Damp = 0.9
        arg1.SpringItemOffset.Freq = 20
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
    else
        arg1.SpringItemOffset = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.9, 20)
    end
    if arg1.Local and arg2 and arg2.SpringItemRotation then
        arg1.SpringItemRotation = arg2.SpringItemRotation
        arg1.SpringItemRotation.Damp = 0.9
        arg1.SpringItemRotation.Freq = 20
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    else
        arg1.SpringItemRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 20)
    end
    if arg1.Local and arg2 and arg2.SpringNeckRotation then
        arg1.SpringNeckRotation = arg2.SpringNeckRotation
        arg1.SpringNeckRotation.Damp = 0.9
        arg1.SpringNeckRotation.Freq = 20
        arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    else
        arg1.SpringNeckRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 20)
    end
    if arg1.Local and arg2 and arg2.SpringWaistRotation then
        arg1.SpringWaistRotation = arg2.SpringWaistRotation
        arg1.SpringWaistRotation.Damp = 0.9
        arg1.SpringWaistRotation.Freq = 20
        arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Hip.Springs.WaistRotation)
    else
        arg1.SpringWaistRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.9, 20)
    end
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 225
    Item_upvr.InputBegan(arg1, arg2, arg3)
end
return module_upvr