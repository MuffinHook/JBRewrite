local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetworkOwnedConsts = require(ReplicatedStorage.NetworkOwned.NetworkOwnedConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 12 | Upvalues: BaseObject (copy), t (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.manifest = p2
	return v1
end
function t.GetOwner(p1) --[[ Line: 20 | Upvalues: Players (copy) ]]
	return Players:GetPlayerByUserId(p1.manifest.networkOwnerIdObj.Value)
end
function t.GetOwnerChangedSignal(p1) --[[ Line: 25 ]]
	return p1.manifest.networkOwnerIdObj.Changed
end
return ManifestBinder.new("NetworkOwned", {
	networkOwnerIdObj = NetworkOwnedConsts.NETWORK_OWNER_ID_OBJ_NAME
}, t)