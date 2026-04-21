local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local ForcefieldConsts_upvr = require(ReplicatedStorage_upvr.Forcefield.ForcefieldConsts)
local ForcefieldService_upvr = require(ReplicatedStorage_upvr.Forcefield.ForcefieldService)
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
local Item_upvr = require(script.Parent.Item)
local function _() -- Line 24, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local function _(arg1) -- Line 27, Named "Ease_OutBack"
    return 1 + (arg1 - 1) * (arg1 - 1) * (-1 + arg1 + 1.70158 * arg1)
end
local function _(arg1) -- Line 31, Named "Ease_InOutQuad"
    local var11
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var11 = 2 * arg1 * arg1
        return var11
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var11 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var11
end
local var12_upvw
local ForcefieldLauncher_upvr = require(ReplicatedStorage_upvr.Game.ItemConfig.ForcefieldLauncher)
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local function new(arg1) -- Line 45
    local setmetatable_result1 = setmetatable({}, tbl_upvr)
    setmetatable_result1.maid = Maid_upvr.new()
    local clone = ReplicatedStorage_upvr.Resource.ForcefieldMesh:Clone()
    clone.Size = Vector3.new(0, 0, 0)
    setmetatable_result1.MeshPartForcefield = clone
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.Color = Color3.fromRGB(255, 0, 255)
    Part.Transparency = 0.7
    Part.Shape = Enum.PartType.Ball
    Part.TopSurface = 0
    Part.BottomSurface = 0
    Part.Size = Vector3.new(0, 0, 0)
    setmetatable_result1.PartShell = Part
    setmetatable_result1.Radius = ForcefieldConsts_upvr.RADIUS
    setmetatable_result1.Local = arg1
    return setmetatable_result1
end
tbl_upvr.new = new
local SimulatedPhysicsProjectile_upvr = require(ReplicatedStorage_upvr.Module.SimulatedPhysicsProjectile)
local String_upvr = require(ReplicatedStorage_upvr.Std.String)
function tbl_upvr.AttemptLaunch(arg1, arg2, arg3) -- Line 65
    local any_new_result1_upvr = SimulatedPhysicsProjectile_upvr.new(arg2)
    any_new_result1_upvr:HitTargetWithSpeed(arg3, 75, false)
    arg1.PartShell.Parent = workspace
    local any_CalculateNextInstantCollision_result1, any_CalculateNextInstantCollision_result2_upvr = any_new_result1_upvr:CalculateNextInstantCollision(0.03333333333333333)
    if not ForcefieldService_upvr.getIsPositionAllowed(any_CalculateNextInstantCollision_result1) then
        return false
    end
    local os_clock_result1_4_upvr = os.clock()
    local var26_upvw
    var26_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 77
        local minimum = math.min((os.clock() - os_clock_result1_4_upvr) * 5, 1)
        local any_Update_result1, any_Update_result2 = any_new_result1_upvr:Update()
        arg1.PartShell.Size = Vector3.new(minimum, minimum, minimum)
        local var30 = any_Update_result1 - Vector3.new(0, arg1.Radius, 0)
        arg1.PartShell.CFrame = CFrame.new(var30)
        if any_CalculateNextInstantCollision_result2_upvr < any_new_result1_upvr:GetElapsed() or any_Update_result2 then
            var26_upvw:Disconnect()
            local any_base85UUID_result1 = String_upvr.base85UUID(10)
            local workspace_GetServerTimeNow_result1 = workspace:GetServerTimeNow()
            arg1:Grow(var30, any_base85UUID_result1, workspace_GetServerTimeNow_result1)
            var12_upvw:FireServer('z'.."".."lqwuxlp8evgk":sub(4, 8):reverse():reverse():reverse().."".."".."pfxmiibl":sub(5, 5):reverse()..""..'o', var30, any_base85UUID_result1, workspace_GetServerTimeNow_result1)
        end
    end)
    return true
end
function tbl_upvr.SetSize(arg1, arg2) -- Line 96
    local var33 = 1 + (arg2 - 1) * (arg2 - 1) * (-1 + arg2 + 1.70158 * arg2)
    local Radius = arg1.Radius
    local vector3 = Vector3.new(var33 * Radius * 2, var33 * Radius * 2, var33 * Radius * 2)
    local var36
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var36 = 2 * arg2 * arg2
        return var36
    end
    if arg2 >= 0.5 or not decompInlinedCondition_2() then
        var36 = -1 - 2 * (arg2 - 2) * arg2
    end
    var36 = 0
    local var37 = CFrame.new(arg1.Position) * CFrame.Angles(0, var36 * math.pi, var36) + Vector3.new(0, var33 * arg1.Radius, 0)
    arg1.PartShell.Size = vector3 * 1.075
    arg1.PartShell.CFrame = var37
    arg1.MeshPartForcefield.Size = vector3
    arg1.MeshPartForcefield.CFrame = var37
end
local Players_upvr = game:GetService("Players")
local DisplayDamage_upvr = require(ReplicatedStorage_upvr.Game.DisplayDamage)
local TweenService_upvr = game:GetService("TweenService")
function tbl_upvr.Grow(arg1, arg2, arg3, arg4) -- Line 107
    arg1.Position = arg2
    arg1.PartShell.Parent = workspace
    arg1.MeshPartForcefield.Parent = workspace
    local os_clock_result1_3_upvr = os.clock()
    local var43_upvw
    var43_upvw = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 114
        local var44 = (os.clock() - os_clock_result1_3_upvr) * 2
        arg1:SetSize(var44)
        if 1 < var44 then
            var43_upvw:Disconnect()
        end
    end)
    arg1.maid:GiveTask(var43_upvw)
    if not ForcefieldService_upvr.add(arg1.Position + Vector3.new(0, arg1.Radius, 0), arg1.Radius, arg3) then
        arg1:Destroy()
    else
        arg1.ForcefieldId = arg3
        local STARTING_HEALTH_upvw = ForcefieldConsts_upvr.STARTING_HEALTH
        arg1.maid:GiveTask(ReplicatedStorage_upvr.Forcefield:FindFirstChild(ForcefieldConsts_upvr.HEALTH_UPDATE_REMOTE_NAME).OnClientEvent:Connect(function(arg1_3, arg2_2, arg3_2) -- Line 135
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var47
            if arg2_2 ~= arg3 then
            else
                local var48
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var48 = var48.Local
                    var48 = arg1
                    return var48
                end
                if var48 == arg1_3 or decompInlinedCondition_3() then
                    if var47 > 0 then
                        var48 = false
                    else
                        var48 = true
                    end
                    DisplayDamage_upvr.draw(arg2_2, arg1.PartShell, STARTING_HEALTH_upvw - var47, {
                        isVehicleDamage = true;
                        didPopVehicleTires = var48;
                    })
                end
                STARTING_HEALTH_upvw = var47
                var48 = 0
                if var47 <= var48 then
                    var48 = workspace:GetServerTimeNow()
                    local var50 = var48
                    if ForcefieldLauncher_upvr.MinShieldDuration <= var50 - arg4 then
                        arg1:Shrink()
                        return
                    end
                    arg1.maid.shrinkTask = task.delay((ForcefieldLauncher_upvr.MinShieldDuration) - (var50 - arg4), function() -- Line 156
                        arg1:Shrink()
                    end)
                    var47 = 0
                end
                var50 = ForcefieldConsts_upvr
                var50 = var50.STARTING_HEALTH
                local var52_upvr = 0.7 + 0.20000000000000007 * (1 - var47 / var50)
                local any_Create_result1 = TweenService_upvr:Create(arg1.PartShell, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, true), {
                    Transparency = var52_upvr - 0.3;
                })
                arg1.maid.transparencyHitFlicker = any_Create_result1
                arg1.PartShell.Transparency = var52_upvr
                any_Create_result1:Play()
                arg1.maid.afterTween = task.delay(0.1, function() -- Line 172
                    arg1.PartShell.Transparency = var52_upvr
                end)
            end
        end))
        arg1.maid:GiveTask(task.delay(ForcefieldLauncher_upvr.MaxShieldDuration, function() -- Line 178
            arg1:Shrink()
        end))
        Audio_upvr.ObjectLocal(arg1.PartShell, 4058366615)
        Audio_upvr.ObjectLocal(arg1.PartShell, 9058693376, {
            Looped = true;
            MaxDistance = 128;
            Volume = 0.2;
        })
    end
end
function tbl_upvr.Shrink(arg1) -- Line 184
    if arg1.isShrinking then
    else
        arg1.isShrinking = true
        local os_clock_result1_upvr = os.clock()
        arg1.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_4) -- Line 190
            local var60 = (os.clock() - os_clock_result1_upvr) * 2
            arg1:SetSize(1 - var60)
            if 1 < var60 then
                arg1:Destroy()
            end
        end))
        assert(ForcefieldService_upvr.removeById(arg1.ForcefieldId))
        arg1.ForcefieldId = nil
    end
end
function tbl_upvr.Destroy(arg1) -- Line 201
    arg1.PartShell:Destroy()
    arg1.PartShell = nil
    arg1.MeshPartForcefield:Destroy()
    arg1.MeshPartForcefield = nil
    arg1.maid:Destroy()
end
local module_upvr = {
    __ClassName = "ForcefieldLauncher";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Item_upvr)
function module_upvr.Init(arg1) -- Line 215
    var12_upvw = arg1.Event
    arg1.em.z8plxuio = function(arg1_5, arg2, arg3, arg4) -- Line 218, Named "z8plxuio"
        assert(arg1_5)
        assert(arg2)
        tbl_upvr.new():Grow(arg2, arg3, arg4)
    end
end
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module_upvr.new(arg1, arg2, arg3) -- Line 225
    local any_new_result1_upvr_2 = Item_upvr.new(arg1, arg3)
    setmetatable(any_new_result1_upvr_2, module_upvr)
    any_new_result1_upvr_2.Config = ForcefieldLauncher_upvr
    any_new_result1_upvr_2.inventoryItemValue = arg2
    if not InventoryItemUtils_upvr.getAttr(any_new_result1_upvr_2.inventoryItemValue, "LastShoot") then
        InventoryItemUtils_upvr.setAttr(any_new_result1_upvr_2.inventoryItemValue, "LastShoot", 0)
    end
    if any_new_result1_upvr_2.Local then
        any_new_result1_upvr_2.SpringCamera = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.6, 70)
    end
    any_new_result1_upvr_2.IK = R15IKv2_upvr.BuildPacketArms(any_new_result1_upvr_2.Character)
    any_new_result1_upvr_2:SetupModel()
    any_new_result1_upvr_2:AttachModelToPlayer()
    any_new_result1_upvr_2.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 246
        any_new_result1_upvr_2:Stepped()
    end))
    any_new_result1_upvr_2.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function() -- Line 249
        any_new_result1_upvr_2:RenderStepped()
    end))
    local var67_upvw
    if any_new_result1_upvr_2.Local then
        var67_upvw = any_new_result1_upvr_2.inventoryItemValue
        local var68 = InventoryItemUtils_upvr.getAttr(var67_upvw, "NextShootPossible") or 0
        local os_clock_result1_2 = os.clock()
        if os_clock_result1_2 < var68 then
            var67_upvw = var68 - os_clock_result1_2
            any_new_result1_upvr_2:StartReloadProgressCircle(any_new_result1_upvr_2.Config.Reload + any_new_result1_upvr_2.Config.MaxShieldDuration, (os.clock()) - (any_new_result1_upvr_2.Config.Reload + any_new_result1_upvr_2.Config.MaxShieldDuration - var67_upvw))
        end
        if os_clock_result1_2 >= var68 then
            var67_upvw = false
        else
            var67_upvw = true
        end
        any_new_result1_upvr_2.Maid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 267
            local any_getAttr_result1 = InventoryItemUtils_upvr.getAttr(any_new_result1_upvr_2.inventoryItemValue, "NextShootPossible")
            if os.clock() >= (any_getAttr_result1 or 0) then
                any_getAttr_result1 = false
            else
                any_getAttr_result1 = true
            end
            if any_getAttr_result1 ~= var67_upvw then
                var67_upvw = any_getAttr_result1
                if not any_getAttr_result1 then
                    Audio_upvr.ObjectLocal(any_new_result1_upvr_2.Center, 16663715207)
                end
            end
        end))
    end
    return any_new_result1_upvr_2
end
function module_upvr.SetupModel(arg1) -- Line 282
    local any_getName_result1 = InventoryItemUtils_upvr.getName(arg1.inventoryItemValue)
    local SOME = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(any_getName_result1)
    if SOME == nil then
        error(string.format("Could not find model for item `%s`", any_getName_result1))
    end
    local clone_2 = SOME:Clone()
    arg1.Model = clone_2
    local Center = clone_2.Skeleton.Center
    arg1.Center = Center
    Joint_upvr.WeldAllTo(clone_2, Center)
    arg1.Maid:GiveTask(function() -- Line 296
        arg1.Model:Destroy()
        arg1.Model = nil
    end)
end
function module_upvr.AttachModelToPlayer(arg1) -- Line 301
    local UpperTorso = arg1.UpperTorso
    arg1.Center.CFrame = UpperTorso.CFrame
    arg1.Model.Parent = workspace.Items
    arg1.Motor = Joint_upvr.BlankMotor(arg1.Center, UpperTorso)
    arg1.Motor.C1 = CFrame.new(1.2, 0, -1.5)
    arg1.Maid:GiveTask(function() -- Line 310
        arg1.Motor:Destroy()
        arg1.Motor = nil
    end)
end
function module_upvr.RenderStepped(arg1) -- Line 315
    if arg1.Local then
        CurrentCamera_upvr.CFrame = CFrame.new(CurrentCamera_upvr.CFrame.p, CurrentCamera_upvr.CFrame * Vector3.new(0, 0, -2) + arg1.SpringCamera:Update())
    end
end
function module_upvr.Stepped(arg1) -- Line 322
    local IK = arg1.IK
    IK.RightArm = arg1.Center.CFrame * Vector3.new(0, 0, 0.20000)
    R15IKv2_upvr.Arms(IK)
    IK.LeftWrist.Transform = CFrame.new()
    IK.RightWrist.Transform = CFrame.new()
end
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.GetMouseLocation(arg1) -- Line 330
    if InputUtils_upvr.isTouch() then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * (arg1.Config.MobileMouseHeightScalar or 0.5), 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
function module_upvr.ShootBegin(arg1) -- Line 341
    local any_GetMouseLocation_result1 = arg1:GetMouseLocation()
    local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(any_GetMouseLocation_result1.x, any_GetMouseLocation_result1.y)
    local _, workspace_FindPartOnRayWithIgnoreList_result2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction * 200), {arg1.Character, arg1.Model})
    local os_clock_result1 = os.clock()
    if os_clock_result1 < (InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "NextShootPossible") or 0) then
        Audio_upvr.ObjectLocal(arg1.Center, 4058365633)
    else
        local Tip = arg1.Model.Skeleton.Tip
        Audio_upvr.ObjectLocal(Tip, 16652902101)
        arg1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 30)
        local var91 = os_clock_result1 + arg1.Config.Reload
        if tbl_upvr.new(arg1.Local):AttemptLaunch(Tip.Position, workspace_FindPartOnRayWithIgnoreList_result2) then
            var91 += arg1.Config.MaxShieldDuration
        end
        arg1:StartReloadProgressCircle(arg1.Config.Reload + arg1.Config.MaxShieldDuration, os.clock())
        InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "NextShootPossible", var91)
    end
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 375
    local var93 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var93 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var93 = false
            else
                var93 = true
            end
        end
    end
    if var93 then
        arg1:ShootBegin()
    end
    Item_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 385
end
return module_upvr