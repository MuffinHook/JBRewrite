local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "NerfRevolver";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.ApplySkin = false
    any_new_result1:Setup(arg3)
    return any_new_result1
end
function module_upvr.SetupBulletEmitter(arg1) -- Line 19
    Gun_upvr.SetupBulletEmitter(arg1)
    arg1.BulletEmitter.Color = Color3.fromRGB(50, 255, 50)
end
function module_upvr.ShootSound(arg1, arg2) -- Line 23
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.shoot, {
            Pitch = 1;
        })
        delay(0.1, function() -- Line 26
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.bullet_case, {
                Volume = 0.4;
                Pitch = 1 + math.random() * 0.1 - 0.05;
            })
        end)
    end
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 35
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 36
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 37
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.reload_open, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 42
    for _ = 1, 4 do
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.bullet_insert, {
            RollOffMaxDistance = 129;
        })
        wait(0.2)
    end
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.reload_close, {
        RollOffMaxDistance = 129;
    })
    wait(0.2)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.cylinder_spin, {
        RollOffMaxDistance = 129;
    })
end
return module_upvr