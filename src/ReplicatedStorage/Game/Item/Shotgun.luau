local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Shotgun";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 14
    local any_new_result1_upvr = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr:Setup(arg3)
    any_new_result1_upvr.LastHitBucketTime = 0
    any_new_result1_upvr.LastHitBucketCount = 0
    any_new_result1_upvr.BulletEmitter.BulletWhizEnabled = false
    any_new_result1_upvr:_updateAmmoVisual()
    any_new_result1_upvr.Maid:GiveTask(any_new_result1_upvr.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(function() -- Line 25
        any_new_result1_upvr:_updateAmmoVisual()
    end))
    return any_new_result1_upvr
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.SetupModel(arg1) -- Line 31
    Gun_upvr.SetupModel(arg1)
    local Pump = arg1.Model.Motion.Pump
    Pump.Anchored = false
    arg1.MotorPump = Joint_upvr.Motor(Pump, arg1.BoundingBox)
    arg1.SpringPump = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 20)
end
function module_upvr.SetupArmWelds(arg1) -- Line 44
    Joint_upvr.Weld(arg1.Model.Skeleton.LeftArm, arg1.Model.Motion.Pump)
    Joint_upvr.Weld(arg1.Model.Skeleton.RightArm, arg1.BoundingBox)
    arg1.Model.Skeleton.LeftArm.Anchored = false
    arg1.Model.Skeleton.RightArm.Anchored = false
end
function module_upvr.UpdateItemSprings(arg1) -- Line 50
    Gun_upvr.UpdateItemSprings(arg1)
    arg1.PumpPosition = arg1.SpringPump:Update()
end
function module_upvr.UpdateItemJoints(arg1) -- Line 55
    Gun_upvr.UpdateItemJoints(arg1)
    arg1.MotorPump.C1 = CFrame.new(arg1.PumpPosition)
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 59
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 60
end
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...) -- Line 63
    local tick_result1_2 = tick()
    if 0.5 < tick_result1_2 - arg1.LastHitBucketTime then
        arg1.LastHitBucketTime = tick_result1_2
        arg1.LastHitBucketCount = 0
    end
    arg1.LastHitBucketCount += 1
    if arg1.LastHitBucketCount <= 10 then
        Gun_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...)
    end
end
function module_upvr.BulletEmitterShieldDamage(arg1, ...) -- Line 76
    local tick_result1 = tick()
    if 0.5 < tick_result1 - arg1.LastHitBucketTime then
        arg1.LastHitBucketTime = tick_result1
        arg1.LastHitBucketCount = 0
    end
    arg1.LastHitBucketCount += 1
    if arg1.LastHitBucketCount <= 10 then
        Gun_upvr.BulletEmitterShieldDamage(arg1, ...)
    end
end
function module_upvr.ShootSound(arg1, arg2) -- Line 89
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_shotgun_shot_01, {
            Pitch = 1 + math.random() * 0.1 - 0.05;
            Volume = 0.4;
        })
        task.delay(0.3, function() -- Line 97
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_shotgun_cock_01, {
                Pitch = 1 + math.random() * 0.1 - 0.05;
            })
            arg1.SpringPump:Accelerate(Vector3.new(0, 0, 35))
        end)
    end
end
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
function module_upvr._updateAmmoVisual(arg1, arg2) -- Line 107
    local var18
    if not arg1.Local then
    else
        local Ammo = arg1.Model:FindFirstChild("Model"):FindFirstChild("Ammo")
        if not var18 then
            var18 = InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrentLocal") - 1
        end
        local len = #Ammo:GetChildren()
        for i_2 = 1, len do
            if i_2 <= var18 then
                Ammo:FindFirstChild(tostring(len - i_2 + 1)).Transparency = 0
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                Ammo:FindFirstChild(tostring(len - i_2 + 1)).Transparency = 1
            end
        end
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 127
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_shotgun_dry_fire_01, {
        Pitch = 0.5;
        RollOffMaxDistance = 64;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 130
    for i = 1, 4 do
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_shotgun_cock_01, {
            Pitch = 0.9;
            RollOffMaxDistance = 64;
        })
        if not arg1._updateAmmoVisual then return end
        arg1:_updateAmmoVisual(i)
        task.wait(0.375)
    end
    task.wait(0.1)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_shotgun_dry_fire_01, {
        Pitch = 0.5;
        RollOffMaxDistance = 64;
    })
    arg1.SpringPump:Accelerate(Vector3.new(0, 0, 35))
end
return module_upvr