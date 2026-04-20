local PlasmaGun_upvr = require(game:GetService("ReplicatedStorage").Game.Item.PlasmaGun)
local module_upvr = {
    __ClassName = "PlasmaPistol";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, PlasmaGun_upvr)
function module_upvr.Init(arg1) -- Line 9
end
function module_upvr.new(arg1, arg2, arg3) -- Line 10
    local any_new_result1 = PlasmaGun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local Gun_upvr = require(script.Parent.Gun)
function module_upvr.SetupModel(arg1) -- Line 16
    Gun_upvr.SetupModel(arg1)
end
return module_upvr