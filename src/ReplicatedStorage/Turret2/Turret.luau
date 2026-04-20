local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TurretConsts_upvr = require(script.Parent.TurretConsts)
local TurretUtils_upvr = require(script.Parent.TurretUtils)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local function _(arg1, arg2) -- Line 15, Named "ShortAngleDist"
    local var6 = (arg2 - arg1) % (-math.pi*2)
    return 2 * var6 % (-math.pi*2) - var6
end
local tbl_4_upvr = {
    weapon_cannon_shot_04 = 2205008075;
}
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local RocketWorld_upvr = require(ReplicatedStorage_upvr.Game.RocketWorld)
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function module_2_upvr.new(arg1) -- Line 27
    assert(arg1)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Maid = Maid_upvr.new()
    module.RocketWorld = RocketWorld_upvr.new()
    module.RocketWorld.AddSmoke = function(arg1_2, arg2) -- Line 35, Named "AddSmoke"
        ReplicatedStorage_upvr.Resource.Robbery.CargoShip.RocketSmoke:Clone().Parent = arg2
    end
    module.Maid:GiveTask(module.RocketWorld)
    module.Model = arg1
    module:SetupJoints()
    module.LastUpdate = os.clock()
    module.LastShoot = os.clock()
    module.LastHit = os.clock()
    module.onLocalPlayerHit = Signal_upvr.new()
    module.Target = Vector3.new()
    module.MaxDHorizontalAngle = 1.2566370614359172
    module.HorizontalAngle = (math.pi/2)
    module.TargetHorizontalAngle = 0
    module.SpringHorizontalAngle = Spring_upvr.new(module.HorizontalAngle, 0, 0.7, 15)
    module.MaxDVerticalAngle = 1.2566370614359172
    module.VerticalAngle = 0
    module.TargetVerticalAngle = 0
    module.SpringVerticalAngle = Spring_upvr.new(module.VerticalAngle, 0, 0.7, 15)
    module.SpringShoot = Spring_upvr.new(0, 0, 0.6, 10)
    return module
end
function module_2_upvr.SetupJoints(arg1) -- Line 65
    arg1.MotorBase = arg1.Model.Base.Root:WaitForChild("MotorBase", 5)
    assert(arg1.MotorBase)
    arg1.MotorBaseC0 = arg1.MotorBase.C0
    arg1.MotorArm = arg1.Model.Arm.Root:WaitForChild("MotorArm", 5)
    assert(arg1.MotorArm)
    arg1.MotorBarrel = arg1.Model.Arm.Barrel:WaitForChild("MotorBarrel", 5)
    assert(arg1.MotorBarrel)
end
function module_2_upvr.PointAt(arg1, arg2) -- Line 74
    arg1.Target = arg2
    if arg2 then
        arg1.TargetHorizontalAngle = TurretUtils_upvr.computeHorizontalAngle(arg1.Model, arg1.MotorBase, arg2)
        arg1.TargetVerticalAngle = TurretUtils_upvr.computeVerticalAngle(arg1.Model, arg1.MotorArm, arg2)
    else
        arg1.TargetHorizontalAngle = (math.pi/2)
        arg1.TargetVerticalAngle = 0
    end
end
function module_2_upvr.Update(arg1) -- Line 84
    local os_clock_result1 = os.clock()
    local var14 = os_clock_result1 - arg1.LastUpdate
    arg1.LastUpdate = os_clock_result1
    local var15 = (arg1.TargetHorizontalAngle - arg1.HorizontalAngle) % (-math.pi*2)
    arg1.HorizontalAngle += math.clamp(2 * var15 % (-math.pi*2) - var15, -arg1.MaxDHorizontalAngle * var14, arg1.MaxDHorizontalAngle * var14)
    arg1.VerticalAngle = math.clamp(arg1.VerticalAngle + math.clamp(arg1.TargetVerticalAngle - arg1.VerticalAngle, -arg1.MaxDVerticalAngle * var14, arg1.MaxDVerticalAngle * var14), -0.9424777960769379, (math.pi/2))
    TurretUtils_upvr.updateModel(arg1.MotorBase, arg1.MotorArm, arg1.SpringHorizontalAngle:SetTarget(arg1.HorizontalAngle), arg1.SpringVerticalAngle:SetTarget(arg1.VerticalAngle))
    arg1.MotorBarrel.C1 = arg1.MotorBarrel.C0:Inverse() * CFrame.new(0, 0, arg1.SpringShoot:Update()) * arg1.MotorBarrel.C0
    if arg1.Target and 1 / arg1:GetShootHz() < os_clock_result1 - arg1.LastShoot then
        arg1.LastShoot = os_clock_result1
        if arg1.Model:GetAttribute(TurretConsts_upvr.USE_LASER_ATTR_NAME) == true then
            arg1:ShootLaser()
            return
        end
        arg1:ShootRocket()
    end
end
function module_2_upvr.GetShootHz(arg1) -- Line 124
    return arg1.Model:GetAttribute(TurretConsts_upvr.SHOOT_HZ_ATTR_NAME) or 0.6666666666666666
end
function module_2_upvr.ShootRocket(arg1) -- Line 127
    arg1.SpringShoot:Accelerate(100)
    arg1.SpringVerticalAngle:Accelerate(1)
    arg1.SpringHorizontalAngle:Accelerate(-1)
    local Tip = arg1.Model.Arm.Tip
    Audio_upvr.ObjectLocal(Tip, tbl_4_upvr.weapon_cannon_shot_04, {
        Volume = 1;
    })
    arg1.RocketWorld:Launch(Tip.Position, Tip.CFrame.LookVector, 400)
end
local Raycast_upvr = require(ReplicatedStorage_upvr.Std.Raycast)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local Players_upvr = game:GetService("Players")
local GeomUtils_upvr = require(ReplicatedStorage_upvr.Std.GeomUtils)
local RunService_upvr = game:GetService("RunService")
function module_2_upvr.ShootLaser(arg1) -- Line 139
    arg1.SpringShoot:Accelerate(50)
    arg1.SpringVerticalAngle:Accelerate(1)
    arg1.SpringHorizontalAngle:Accelerate(-1)
    local any_new_result1 = Maid_upvr.new()
    local Part_upvr = Instance.new("Part")
    Part_upvr.Anchored = true
    Part_upvr.CanCollide = false
    Part_upvr.CanQuery = false
    Part_upvr.CanTouch = false
    Part_upvr.Transparency = 0
    Part_upvr.Color = Color3.fromRGB(181, 113, 102)
    Part_upvr.CastShadow = false
    Part_upvr.Material = Enum.Material.Neon
    Part_upvr.TopSurface = Enum.SurfaceType.Smooth
    Part_upvr.BottomSurface = Enum.SurfaceType.Smooth
    any_new_result1:GiveTask(Part_upvr)
    arg1.Maid.laserMaid = any_new_result1
    local var25_upvr = 1 / arg1:GetShootHz() * 0.5
    local Tip_upvr = arg1.Model.Arm.Tip
    local Vehicles_upvr = workspace:FindFirstChild("Vehicles")
    local function updateLaserToTarget_upvr(arg1_3) -- Line 164, Named "updateLaserToTarget"
        local RaycastParams_new_result1_2 = RaycastParams.new()
        RaycastParams_new_result1_2.FilterType = Enum.RaycastFilterType.Exclude
        RaycastParams_new_result1_2.FilterDescendantsInstances = {arg1.Model, Vehicles_upvr}
        RaycastParams_new_result1_2.IgnoreWater = true
        local var44 = arg1_3 - Tip_upvr.Position
        local any_collidable_result1 = Raycast_upvr.collidable(Tip_upvr.Position, var44.Unit, var44.Magnitude, RaycastParams_new_result1_2, function(arg1_5) -- Line 170
            if arg1_5:GetAttribute("InvisibleToBullets") == true then
                return false
            end
            if arg1_5.CanCollide then
                return true
            end
            return false
        end)
        if any_collidable_result1 then
            var44 = any_collidable_result1.Position - Tip_upvr.Position
        end
        local Magnitude = var44.Magnitude
        Part_upvr.Size = Vector3.new(0.5, 0.5, Magnitude)
        Part_upvr.CFrame = CFrame.new(Vector3.new(0, 0, 0), var44.Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(0, 0, os.clock() * 20 % (-math.pi*2)) + Tip_upvr.Position
        if not arg1.shoot1Sound then
            arg1.shoot1Sound = Audio_upvr.ObjectLocal(Tip_upvr, 11793588989, {
                Volume = 0.6;
                RollOffMaxDistance = 1280;
            })
            arg1.Maid:GiveTask(function() -- Line 193
                arg1.shoot1Sound:Destroy()
                arg1.shoot1Sound = nil
            end)
        else
            arg1.shoot1Sound:Play()
        end
        if not arg1.laserLoop then
            arg1.laserLoop = Audio_upvr.ObjectLocal(Tip_upvr, 11793547887, {
                Looped = true;
                Volume = 0.5;
                RollOffMaxDistance = 1280;
            })
            arg1.Maid:GiveTask(function() -- Line 204
                arg1.laserLoop:Destroy()
                arg1.laserLoop = nil
            end)
        else
            arg1.laserLoop:Play()
        end
        task.delay(var25_upvr, function() -- Line 211
            arg1.laserLoop:Stop()
        end)
        local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
        if any_getRootPart_result1 then
            local any_closestPointOnLine_result1, any_closestPointOnLine_result2_2 = GeomUtils_upvr.closestPointOnLine(arg1.Model.Arm.Tip.Position, var44, any_getRootPart_result1.Position)
            if any_closestPointOnLine_result2_2 < 8 and 1 / arg1:GetShootHz() <= os.clock() - arg1.LastHit then
                arg1.LastHit = os.clock()
                arg1.onLocalPlayerHit:Fire(Players_upvr.LocalPlayer)
            end
        end
    end
    updateLaserToTarget_upvr(Tip_upvr.Position + Vector3.new(0.00999, 0.00999, 0.00999))
    Part_upvr.Parent = workspace
    local os_clock_result1_2_upvr = os.clock()
    any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 229
        if not arg1.Target then
            arg1.Maid.laserMaid = nil
        else
            local var58 = os.clock() - os_clock_result1_2_upvr
            if var25_upvr <= var58 then
                var58 = var25_upvr
            end
            updateLaserToTarget_upvr(Tip_upvr.Position:Lerp(arg1.Target, math.clamp(var58 / var25_upvr * 5, 0, 1)))
            if var58 == var25_upvr then
                arg1.Maid.laserMaid = nil
            end
        end
    end))
end
function module_2_upvr.Destroy(arg1) -- Line 246
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_2_upvr