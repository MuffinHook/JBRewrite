local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlasmaGun_upvr = require(ReplicatedStorage.Game.Item.PlasmaGun)
local module_upvr = {
    __ClassName = "PlasmaShotgun";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, PlasmaGun_upvr)
function module_upvr.Init(arg1) -- Line 10
end
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    local any_new_result1 = PlasmaGun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local Gun_upvr = require(script.Parent.Gun)
function module_upvr.SetupModel(arg1) -- Line 17
    Gun_upvr.SetupModel(arg1)
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.ShootSound(arg1, arg2) -- Line 20
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, 17183453324, {
            Volume = 0.35;
            TimePosition = 0.05;
        })
    end
end
return module_upvr