local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CollectionService_upvr = game:GetService("CollectionService")
local SeekingMissileConsts_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local SeekingMissileBinder_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local RocketLauncherUtils_upvr = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
function module_upvr.new(arg1) -- Line 14
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    assert(CollectionService_upvr:HasTag(any_new_result1.obj, SeekingMissileConsts_upvr.TAG_NAME), "Must be seeking missile")
    SeekingMissileBinder_upvr:Promise(any_new_result1.obj):andThen(function(arg1_2) -- Line 19
        arg1_2.onExploded:Connect(function(arg1_3) -- Line 20
            RocketLauncherUtils_upvr.explodeAt(arg1_3)
        end)
    end)
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(require(ReplicatedStorage.RocketLauncher.RocketLauncherConsts).ROCKET_TAG_NAME, module_upvr)