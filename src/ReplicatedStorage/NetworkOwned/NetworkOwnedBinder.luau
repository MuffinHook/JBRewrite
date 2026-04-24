-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetworkOwnedConsts = require(ReplicatedStorage.NetworkOwned.NetworkOwnedConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local instance = BaseObject.new(p1)
	setmetatable(instance, t)
	instance.manifest = p2
	return instance
end
function t.GetOwner(p1)
	return Players:GetPlayerByUserId(p1.manifest.networkOwnerIdObj.Value)
end
function t.GetOwnerChangedSignal(p1)
	return p1.manifest.networkOwnerIdObj.Changed
end
return ManifestBinder.new("NetworkOwned", {
	networkOwnerIdObj = NetworkOwnedConsts.NETWORK_OWNER_ID_OBJ_NAME
}, t)
