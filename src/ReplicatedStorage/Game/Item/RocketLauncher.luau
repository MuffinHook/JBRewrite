local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local GunSystemConsts_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.GunSystemConsts)
local RocketLauncherConsts_upvr = require(ReplicatedStorage_upvr.RocketLauncher.RocketLauncherConsts)
local Gun_upvr = require(script.Parent.Gun)
local function randomUnitVector() -- Line 25, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local function attemptSetSightColor(arg1, arg2) -- Line 28, Named "attemptSetSightColor"
    local PlaneGui_3 = arg1.PlaneGui
    local os_clock_result1_3 = os.clock()
    if not arg1.lastSightsColorChange then
        arg1.lastSightsColorChange = 0
    end
    if os_clock_result1_3 - arg1.lastSightsColorChange < 0.1 then
    else
        if PlaneGui_3.Sights.ImageColor3 == arg2 then return end
        arg1.lastSightsColorChange = os_clock_result1_3
        PlaneGui_3.Sights.ImageColor3 = arg2
    end
end
local CollectionService_upvr = game:GetService("CollectionService")
local JetConsts_upvr = require(ReplicatedStorage_upvr.Game.Plane.JetConsts)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local function GetTargetPart_upvr(arg1) -- Line 43, Named "GetTargetPart"
    -- Decomp Error: Reconstructed lock-on target acquisition after Konstant failed to generate this function.
    local Model = arg1.Model
    local Tip = arg1.Tip
    if Model then
        local Skeleton = Model:FindFirstChild("Skeleton")
        if Skeleton then
            Tip = Skeleton:FindFirstChild("Tip") or Tip
        end
    end
    if not Tip then
        return nil
    end
    local bestPart
    local bestScore = -math.huge
    for _, part in ipairs(CollectionService_upvr:GetTagged(JetConsts_upvr.SEEKING_LOCK_TAG_NAME)) do
        if part:IsA("BasePart") and (not Model or not part:IsDescendantOf(Model)) then
            local delta = part.Position - Tip.Position
            local distance = delta.Magnitude
            if 0 < distance and distance < 768 then
                local dot = delta.Unit:Dot(Tip.CFrame.LookVector)
                if 0.9238795325112867 <= dot then
                    local score = dot / distance
                    if bestScore < score then
                        bestScore = score
                        bestPart = part
                    end
                end
            end
        end
    end
    return bestPart
end
local module_upvr = {
    __ClassName = "RocketLauncher";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
function module_upvr.new(arg1, arg2, arg3) -- Line 79
    local any_new_result1_upvr = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr:Setup(arg3)
    any_new_result1_upvr.maid = any_new_result1_upvr.Maid
    any_new_result1_upvr.Maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(any_new_result1_upvr.inventoryItemValue, GunSystemConsts_upvr.SHOOT_REMOTE_NAME, function(arg1_2, arg2_2) -- Line 88
        arg2_2:GiveTask(arg1_2.OnClientEvent:Connect(function(arg1_3, arg2_3, arg3_2) -- Line 90
            any_new_result1_upvr:Shoot(arg1_3, arg2_3, arg3_2)
        end))
    end))
    any_new_result1_upvr.Maid:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 97
        local GetTargetPart_upvr_result1_2 = GetTargetPart_upvr(any_new_result1_upvr)
        if GetTargetPart_upvr_result1_2 ~= any_new_result1_upvr.targetPart then
            any_new_result1_upvr.targetPart = GetTargetPart_upvr_result1_2
            if GetTargetPart_upvr_result1_2 ~= nil then
                any_new_result1_upvr.targetPartFoundAt = os.clock()
            end
        end
    end))
    if any_new_result1_upvr.Local then
        local clone_upvr = ReplicatedStorage_upvr.Resource.Plane.PlaneGui:Clone()
        any_new_result1_upvr.PlaneGui = clone_upvr
        clone_upvr.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
        clone_upvr.Parent = Players_upvr.LocalPlayer.PlayerGui
        any_new_result1_upvr.maid:GiveTask(clone_upvr)
        any_new_result1_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 116
            -- Decomp Error: Reconstructed the rocket lock-on sight update from a failed Konstant control-flow block.
            local targetPart = any_new_result1_upvr.targetPart
            if not targetPart then
                clone_upvr.Sights.Visible = false
                return
            end

            local screenPosition, onScreen = CurrentCamera_upvr:WorldToViewportPoint(targetPart.Position)
            clone_upvr.Sights.Visible = onScreen
            clone_upvr.Sights.Position = UDim2.fromOffset(screenPosition.X, screenPosition.Y)

            local locked = RocketLauncherConsts_upvr.SEEKING_LOCK_MIN_DURATION <= os.clock() - any_new_result1_upvr.targetPartFoundAt
            if locked then
                attemptSetSightColor(any_new_result1_upvr, Color3.new(1, 0, 0))
            else
                attemptSetSightColor(any_new_result1_upvr, Color3.new(0, 1, 0))
            end
        end))
    end
    return any_new_result1_upvr
end
function module_upvr.SetupShoot(arg1) -- Line 157
end
function module_upvr._shootBroadcast(arg1) -- Line 158
end
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
function module_upvr.SetupModel(arg1) -- Line 159
    Gun_upvr.SetupModel(arg1)
    Joint_upvr.Weld(arg1.Model.Skeleton.Rocket, arg1.BoundingBox)
    arg1.Model.Skeleton.Rocket.Anchored = false
end
local HapticEffect_upvr = require(ReplicatedStorage_upvr.App.HapticEffect)
local ItemCamera_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemCamera)
function module_upvr.ShootLocal(arg1) -- Line 165
    if arg1.Local then
        HapticEffect_upvr.basic(0.5, 0.35)
        arg1.SpringCamera:Accelerate(Vector3.new(1, 0, 0) * math.clamp(20 / ItemCamera_upvr.GetCameraDistance(), 0.5, 1) * 10)
        arg1.CrossHair.Spring:Accelerate(900)
    end
    return true
end
function module_upvr.SetupBulletEmitter(arg1) -- Line 178
end
local Raycast_upvr = require(ReplicatedStorage_upvr.Std.Raycast)
local NetObjPoolBinder_upvr = require(ReplicatedStorage_upvr.NetObjPool.NetObjPoolBinder)
local SeekingMissileBinder_upvr = require(ReplicatedStorage_upvr.SeekingMissile.SeekingMissileBinder)
function module_upvr.LaunchRocket(arg1, arg2, arg3, arg4) -- Line 179
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg2, "missing origin")
    assert(arg3, "missing direction")
    assert(arg4, "missing speed")
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local Tip_2 = arg1.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
    local var56_upvw
    if arg1.targetPart and RocketLauncherConsts_upvr.SEEKING_LOCK_MIN_DURATION <= os.clock() - arg1.targetPartFoundAt then
        var56_upvw = arg1.targetPart
    end
    arg1.targetPartFoundAt = os.clock()
    if not var56_upvw then
        local RaycastParams_new_result1_2 = RaycastParams.new()
        RaycastParams_new_result1_2.FilterDescendantsInstances = {arg1.Model, Players_upvr.LocalPlayer.Character}
        if Raycast_upvr.collidable(Tip_2.Position, Tip_2.CFrame.LookVector, 999, RaycastParams_new_result1_2) then
            local var60_upvw
        end
    end
    if not var56_upvw and not var60_upvw then
        var60_upvw = Tip_2.Position + Tip_2.CFrame.LookVector * 4096
    end
    local SOME_2 = arg1.inventoryItemValue:FindFirstChild(RocketLauncherConsts_upvr.MISSILE_OBJ_POOL_NAME)
    if not SOME_2 then
        warn("No missile pool obj available")
        return
    end
    local any_Get_result1 = NetObjPoolBinder_upvr:Get(SOME_2):Get()
    if not any_Get_result1 then
        warn("No missile available in pool")
        return
    end
    local obj = any_Get_result1.obj
    any_Get_result1:SetActive(false)
    obj.CFrame = Tip_2.CFrame
    obj.Velocity = Tip_2.Velocity
    SeekingMissileBinder_upvr:Promise(obj):andThen(function(arg1_5) -- Line 224
        table.insert(arg1_5.ignoreList, arg1.Model)
        arg1_5.raycastParams.FilterDescendantsInstances = arg1_5.ignoreList
        if var56_upvw then
            arg1_5:SetTargetPart(var56_upvw)
        else
            arg1_5:SetTargetPos(var60_upvw)
        end
    end)
    if arg1.PlaneGui then
        attemptSetSightColor(arg1, Color3.new(0, 1, 0))
    end
end
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
function module_upvr.Shoot(arg1) -- Line 239
    if arg1.IsEquipping then
        return false
    end
    local CFrame = arg1.Tip.CFrame
    Audio_upvr.ObjectLocal(arg1.Model.Skeleton.Rocket, arg1.Config.Sound.weapon_cannon_shot_04, {
        Volume = 1;
    })
    if arg1.Local then
        arg1:ShootLocal()
        arg1:LaunchRocket(CFrame.p, CFrame.LookVector, arg1.Config.RocketSpeed)
        if 0 < InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrentLocal") then
            arg1:StartReloadProgressCircle(1 / arg1.Config.FireFreq)
        end
    end
    return true
end
function module_upvr.ShootSound(arg1, arg2) -- Line 255
    if arg2 then
        Audio_upvr.ObjectLocal(arg1.Model.Skeleton.BoundingBox, arg1.Config.Sound.gun_pistol_dry_fire_01, {
            Volume = 0.6;
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 264
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 265
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 266
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 267
end
return module_upvr
