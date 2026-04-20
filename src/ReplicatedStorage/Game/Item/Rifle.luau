local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Rifle";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 12
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
function module_upvr.ShootSound(arg1, arg2) -- Line 19
    if arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_dry_fire_01, {
            Volume = 0.4;
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    else
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_shot_01, {
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 34
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 39
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
        RollOffMaxDistance = 129;
    })
end
return module_upvr