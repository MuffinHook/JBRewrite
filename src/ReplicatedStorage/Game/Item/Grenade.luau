local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local GunSystemConsts_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.GunSystemConsts)
local Gun_upvr = require(script.Parent.Gun)
local function _() -- Line 11, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local function CalculateProjectileVelocity_upvr(arg1, arg2, arg3) -- Line 17, Named "CalculateProjectileVelocity"
    local var5 = arg2 - arg1
    local var6 = (var5.x * var5.x + var5.z * var5.z) ^ 0.5
    local var7 = 0.7853981633974483
    local Gravity = workspace.Gravity
    local var9 = arg3 * arg3 * arg3 * arg3 - Gravity * (Gravity * var6 * var6 + 2 * var5.Y * arg3 * arg3)
    if 0 <= var9 then
        local var10 = var9 ^ 0.5
        var7 = math.min(math.atan((arg3 * arg3 + var10) / (Gravity * var6)), math.atan((arg3 * arg3 - var10) / (Gravity * var6)))
    end
    return Vector3.new(arg3 * var5.x / var6 * math.cos(var7), arg3 * math.sin(var7), arg3 * var5.z / var6 * math.cos(var7)), (var6) / (arg3 * math.cos(var7))
end
local module_upvr = {
    __ClassName = "Grenade";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 37
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    any_new_result1.ShootProxy = 1
    return any_new_result1
end
function module_upvr.SetupArmWelds(arg1) -- Line 49
end
function module_upvr.UpdateArmIK(arg1) -- Line 50
    local IK = arg1.IK
    IK.RightArm = arg1.Model.Model.Base.Position
    IK.RightAngle = arg1.Config.Motion.RightElbowAngle
end
function module_upvr.SetupTip(arg1) -- Line 56
    arg1.TipOffset = Vector3.new()
end
local function GrenadeExplode_upvr(arg1, arg2) -- Line 59, Named "GrenadeExplode"
    local Position = arg2.Skeleton.BoundingBox.Position
    if arg1.BulletEmitter.Bullets then
        for _ = 1, 30 do
            arg1.BulletEmitter:Emit(Position, Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit, 400)
        end
    end
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(0.10000, 0.10000, 0.10000)
    Part.CanCollide = false
    Part.Anchored = true
    Part.Transparency = 1
    Part.Position = Position
    Part.Parent = workspace
    local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Explosion:Clone()
    clone.Parent = Part
    clone:Emit(4)
    local clone_4 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Debris:Clone()
    clone_4.Parent = Part
    clone_4:Emit(50)
    local clone_5 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Smoke:Clone()
    clone_5.Parent = Part
    clone_5:Emit(3)
    local clone_6_upvr = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
    clone_6_upvr.Enabled = true
    clone_6_upvr.Parent = Part
    delay(5 - clone_6_upvr.Lifetime.Max, function() -- Line 97
        clone_6_upvr.Enabled = false
    end)
    game.Debris:AddItem(Part, 5)
    Audio_upvr.ObjectLocal(Part, arg1.Config.Sound.explosion_large_02, {
        Volume = 1;
    }).EmitterSize = 20
    if arg1.Local then
        arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.DAMAGE_REMOTE_NAME):FireServer(Position)
    end
end
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
function module_upvr.GrenadeThrow(arg1, arg2, arg3) -- Line 110
    local clone_3_upvw = assert(ReplicatedStorage_upvr.Resource.ItemSystem.Models.Grenade, "Item model for %s does not exist.":format("Grenade")):Clone()
    clone_3_upvw.Model.Handle:Destroy()
    Joint_upvr.Weld(clone_3_upvw.Model.Base, clone_3_upvw.Skeleton.BoundingBox)
    clone_3_upvw.Model.Base.Anchored = false
    clone_3_upvw.Skeleton.BoundingBox.Anchored = false
    clone_3_upvw.Parent = workspace.Items
    clone_3_upvw.PrimaryPart = clone_3_upvw.Skeleton.BoundingBox
    local PrimaryPart_upvr = clone_3_upvw.PrimaryPart
    PrimaryPart_upvr.Velocity = CalculateProjectileVelocity_upvr(arg1.Model.Skeleton.BoundingBox.Position, arg2, 100)
    clone_3_upvw:SetPrimaryPartCFrame(CFrame.new(Vector3.new(), PrimaryPart_upvr.Velocity) + arg1.Model.Skeleton.BoundingBox.Position)
    PrimaryPart_upvr.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.9, 0.5, 20, 1)
    delay(0, function() -- Line 131
        PrimaryPart_upvr.CanCollide = true
    end)
    delay(arg3, function() -- Line 134
        GrenadeExplode_upvr(arg1, clone_3_upvw)
        clone_3_upvw.Model.Base.CanCollide = true
        clone_3_upvw.Model.Base.Velocity = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 50
    end)
    delay(arg3 + 2, function() -- Line 141
        clone_3_upvw:Destroy()
    end)
    if arg1.Local then
        arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.SHOOT_REMOTE_NAME):FireServer()
    end
end
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1) -- Line 150
end
function module_upvr.ShootBegin(arg1, arg2) -- Line 151
    if not arg1:ShootCheckConditions() then
        return false
    end
    arg1:DecrementAmmo()
    arg1:SetNextShotPossible()
    arg1.GrenadeHeldAt = tick()
    local var30_upvr = arg1.ShootProxy + 1
    arg1.ShootProxy = var30_upvr
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Raise.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Raise.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Raise.Springs.NeckRotation)
    local clone_2_upvr = arg1.Model.Model.Handle:Clone()
    clone_2_upvr:ClearAllChildren()
    clone_2_upvr.CanCollide = true
    clone_2_upvr.Anchored = false
    clone_2_upvr.Parent = workspace
    clone_2_upvr.Velocity = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 50
    delay(5, function() -- Line 173
        clone_2_upvr:Destroy()
    end)
    arg1.Model.Model.Handle.Transparency = 1
    delay(arg1.Config.FuseTime, function() -- Line 179
        if arg1.Destroyed then
        else
            if arg1.ShootProxy ~= var30_upvr then
                return false
            end
            arg1:ShootEnd(arg2)
        end
    end)
    if arg1.Local then
        arg1:BroadcastInputBegan(arg2)
    end
end
function module_upvr.ShootEnd(arg1, arg2) -- Line 193
    if not arg1.GrenadeHeldAt then
        return false
    end
    arg1.GrenadeHeldAt = nil
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Launch.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Launch.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Launch.Springs.NeckRotation)
    delay(0.2, function() -- Line 203
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
        arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    end)
    local Model_upvr = arg1.Model
    Model_upvr.Model.Base.Transparency = 1
    Model_upvr.Model.Handle.Transparency = 1
    delay(arg1.Config.ReloadTime, function() -- Line 213
        if arg1.Destroyed then
            return false
        end
        Model_upvr.Model.Base.Transparency = 0
        Model_upvr.Model.Handle.Transparency = 0
    end)
    arg1:GrenadeThrow(arg1.MousePosition, (arg1.Config.FuseTime) - (tick() - arg1.GrenadeHeldAt))
    if arg1.Local then
        arg1:BroadcastInputEnded(arg2)
    end
end
function module_upvr.ShootOther(arg1) -- Line 227
end
function module_upvr.ShootSound(arg1, arg2) -- Line 228
    if arg2 then
        Audio_upvr.ObjectLocal(arg1.Model.Skeleton.BoundingBox, arg1.Config.Sound.gun_pistol_dry_fire_01, {
            Volume = 0.6;
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    end
end
module_upvr.ApplySkin = false
module_upvr.ScopeBegin = false
module_upvr.ScopeEnd = false
module_upvr.Reload = false
return module_upvr