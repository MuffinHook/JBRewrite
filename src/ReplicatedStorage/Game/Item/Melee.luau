local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GunUtils_upvr = require(ReplicatedStorage_upvr.Game.GunShop.GunUtils)
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
local ConstraintUtils_upvr = require(ReplicatedStorage_upvr.Std.ConstraintUtils)
local Item_upvr = require(script.Parent.Item)
local zero_cframe_upvr = CFrame.new()
local function FromAxisAngle_upvr(arg1) -- Line 15, Named "FromAxisAngle"
    local x = arg1.x
    local y = arg1.y
    local z = arg1.z
    local var12 = (x * x + y * y + z * z) ^ 0.5
    if 0.00001 < var12 then
        local var13 = math.sin(var12 * 0.5) / var12
        return CFrame.new(0, 0, 0, var13 * x, var13 * y, var13 * z, math.cos(var12 * 0.5))
    end
    return zero_cframe_upvr
end
local module_upvr = {
    __ClassName = "Melee";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Item_upvr)
function module_upvr.new(arg1, arg2, arg3, arg4) -- Line 32
    local any_new_result1_upvr = Item_upvr.new(arg1, arg4)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Config = arg3
    any_new_result1_upvr.inventoryItemValue = arg2
    any_new_result1_upvr.JointNeckC0 = any_new_result1_upvr.JointNeck.C0
    any_new_result1_upvr.JointWaistC0 = any_new_result1_upvr.JointWaist.C0
    any_new_result1_upvr.Maid:GiveTask(function() -- Line 41
        ConstraintUtils_upvr.setJointC0(any_new_result1_upvr.JointNeck, any_new_result1_upvr.JointNeckC0)
        ConstraintUtils_upvr.setJointC0(any_new_result1_upvr.JointWaist, any_new_result1_upvr.JointWaistC0)
    end)
    any_new_result1_upvr.IK = R15IKv2_upvr.BuildPacketArms(any_new_result1_upvr.Character)
    any_new_result1_upvr.IsEquipping = false
    any_new_result1_upvr:SetupModel()
    any_new_result1_upvr:AttachModelToPlayer()
    any_new_result1_upvr:SetupSprings(arg4)
    any_new_result1_upvr:Equip()
    return any_new_result1_upvr
end
local GunSystemConsts_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.GunSystemConsts)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Equip(arg1) -- Line 56
    local var19
    if not var19 then
        var19 = GunSystemConsts_upvr
        var19 = var19.GUN_EQUIP_TIME
    end
    if GunUtils_upvr.getShouldAddEquipTime(arg1) and 0 < var19 then
        arg1.IsEquipping = true
        arg1:StartReloadProgressCircle(var19)
        arg1.maid:GiveTask(task.delay(var19, function() -- Line 63
            arg1.IsEquipping = false
        end))
    end
    arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 68
        arg1:Heartbeat()
    end))
    arg1.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 71
        arg1:Stepped()
    end))
end
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function module_upvr.SetupSprings(arg1, arg2) -- Line 75
    if arg1.Local and arg2 and arg2.SpringItemOffset then
        arg1.SpringItemOffset = arg2.SpringItemOffset
        arg1.SpringItemOffset.Damp = 0.85
        arg1.SpringItemOffset.Freq = 8
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
    else
        arg1.SpringItemOffset = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.85, 8)
    end
    if arg1.Local and arg2 and arg2.SpringItemRotation then
        arg1.SpringItemRotation = arg2.SpringItemRotation
        arg1.SpringItemRotation.Damp = 0.85
        arg1.SpringItemRotation.Freq = 8
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    else
        arg1.SpringItemRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.85, 8)
    end
    if arg1.Local and arg2 and arg2.SpringNeckRotation then
        arg1.SpringNeckRotation = arg2.SpringNeckRotation
        arg1.SpringNeckRotation.Damp = 0.85
        arg1.SpringNeckRotation.Freq = 8
        arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    else
        arg1.SpringNeckRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.85, 8)
    end
    if arg1.Local and arg2 and arg2.SpringWaistRotation then
        arg1.SpringWaistRotation = arg2.SpringWaistRotation
        arg1.SpringWaistRotation.Damp = 0.85
        arg1.SpringWaistRotation.Freq = 8
        arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Hip.Springs.WaistRotation)
    else
        arg1.SpringWaistRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.85, 8)
    end
end
function module_upvr.SetupModel(arg1) -- Line 115
    local any_getName_result1 = InventoryItemUtils_upvr.getName(arg1.inventoryItemValue)
    local SOME = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(any_getName_result1)
    if SOME == nil then
        error(string.format("Could not find model for item `%s`", any_getName_result1))
    end
    local clone = SOME:Clone()
    arg1.Model = clone
    local Center = clone.Skeleton.Center
    arg1.Center = Center
    Joint_upvr.WeldAllTo(clone, Center)
    arg1.Maid:GiveTask(function() -- Line 128
        arg1.Model:Destroy()
        arg1.Model = nil
    end)
end
function module_upvr.AttachModelToPlayer(arg1) -- Line 133
    local UpperTorso = arg1.UpperTorso
    arg1.Center.CFrame = UpperTorso.CFrame
    arg1.Model.Parent = workspace.Items
    arg1.Motor = Joint_upvr.BlankMotor(arg1.Center, UpperTorso)
    arg1.Maid:GiveTask(function() -- Line 140
        arg1.Motor:Destroy()
        arg1.Motor = nil
    end)
end
function module_upvr.SwingLunge(arg1) -- Line 145
    error("TODO: Implement")
end
function module_upvr.SwingSwoosh(arg1) -- Line 148
    error("TODO: Implement")
end
function module_upvr.Heartbeat(arg1) -- Line 151
    arg1.Motor.C1 = CFrame.new(arg1.SpringItemOffset:Update()) * FromAxisAngle_upvr(arg1.SpringItemRotation:Update()) * CFrame.new(1.6, 1, -1.5) * arg1.JointWaist.C1
    ConstraintUtils_upvr.setJointC0(arg1.JointWaist, arg1.JointWaistC0 * FromAxisAngle_upvr(arg1.SpringWaistRotation:Update()))
    ConstraintUtils_upvr.setJointC0(arg1.JointNeck, arg1.JointNeckC0 * FromAxisAngle_upvr(arg1.SpringNeckRotation:Update()))
end
function module_upvr.Stepped(arg1) -- Line 163
    local IK = arg1.IK
    IK.RightArm = arg1.Center.CFrame * Vector3.new(0, 0, 0.20000)
    R15IKv2_upvr.Arms(IK)
    IK.LeftWrist.Transform = CFrame.new()
    IK.RightWrist.Transform = CFrame.Angles(0, -0.3, 0)
end
function module_upvr._getLastUse(arg1) -- Line 171
    return arg1.Model:GetAttribute("LastUse") or 0
end
function module_upvr.Swing(arg1, arg2) -- Line 174
    if arg1.IsEquipping then
        return false
    end
    local workspace_GetServerTimeNow_result1 = workspace:GetServerTimeNow()
    if workspace_GetServerTimeNow_result1 - arg1:_getLastUse() < arg1.Config.ReloadTime then
        return false
    end
    arg1.Model:SetAttribute("LastUse", workspace_GetServerTimeNow_result1)
    GunUtils_upvr.setLastShotTime(arg1.Player, workspace_GetServerTimeNow_result1)
    if 0.8 < math.random() then
        arg1:SwingLunge()
    else
        arg1:SwingSwoosh()
    end
    if arg1.Local then
        arg1:BroadcastInputBegan(arg2)
    end
end
function module_upvr.ShootBegin(arg1, arg2) -- Line 193
    arg1:Swing(arg2)
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 196
    local var34 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var34 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var34 = false
            else
                var34 = true
            end
        end
    end
    if var34 then
        arg1:ShootBegin(arg2)
    end
    Item_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1, arg2, arg3) -- Line 206
end
return module_upvr