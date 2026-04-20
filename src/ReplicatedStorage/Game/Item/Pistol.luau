local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Pistol";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 15
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1._hasSWAT = false
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.SetupModel(arg1) -- Line 23
    if arg1.Player and arg1.Player.DisplayName and GamepassSystem_upvr.doesPlayerOwnCached(arg1.Player, GamepassUtils_upvr.EnumGamepass.SWAT) then
        arg1._hasSWAT = true
        Gun_upvr.SetupModel(arg1, "PistolSWAT")
    else
        Gun_upvr.SetupModel(arg1)
    end
    local Slide = arg1.Model.Motion.Slide
    Slide.Anchored = false
    arg1.MotorSlide = Joint_upvr.Motor(Slide, arg1.BoundingBox)
    arg1.SpringSlide = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 40)
end
function module_upvr.UpdateItemSprings(arg1) -- Line 45
    Gun_upvr.UpdateItemSprings(arg1)
    arg1.SlidePosition = arg1.SpringSlide:Update()
end
function module_upvr.UpdateItemJoints(arg1) -- Line 50
    Gun_upvr.UpdateItemJoints(arg1)
    arg1.MotorSlide.C1 = CFrame.new(arg1.SlidePosition)
end
function module_upvr.ShootSound(arg1, arg2) -- Line 54
    if not arg2 then
        if arg1._hasSWAT then
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.pistol_shot_silenced, {
                Pitch = 1;
            })
        else
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_shot_04, {
                Pitch = 1;
            })
        end
        delay(0.1, function() -- Line 61
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_slide_fast_01, {
                Volume = 0.3;
                Pitch = 1 + math.random() * 0.1 - 0.05;
            })
        end)
        arg1.SpringSlide:Accelerate(Vector3.new(0, 0, 30))
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 71
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_remove_mag_01, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 76
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_insert_mag_01, {
        RollOffMaxDistance = 129;
    })
    wait(0.4)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_slide_fast_01, {
        RollOffMaxDistance = 129;
    })
    wait(0.1)
end
return module_upvr