local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1, arg2) -- Line 12
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.manifest = arg2
    return any_new_result1
end
local Players_upvr = game:GetService("Players")
function module_upvr.GetOwner(arg1) -- Line 20
    return Players_upvr:GetPlayerByUserId(arg1.manifest.networkOwnerIdObj.Value)
end
function module_upvr.GetOwnerChangedSignal(arg1) -- Line 25
    return arg1.manifest.networkOwnerIdObj.Changed
end
return require(ReplicatedStorage.ManifestBinder).new("NetworkOwned", {
    networkOwnerIdObj = require(ReplicatedStorage.NetworkOwned.NetworkOwnedConsts).NETWORK_OWNER_ID_OBJ_NAME;
}, module_upvr)