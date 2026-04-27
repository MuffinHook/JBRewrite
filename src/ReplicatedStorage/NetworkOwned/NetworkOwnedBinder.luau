local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetworkOwnedConsts = require(ReplicatedStorage.NetworkOwned.NetworkOwnedConsts)
local NetworkOwnedClass = {}
NetworkOwnedClass.__index = NetworkOwnedClass
setmetatable(NetworkOwnedClass, BaseObject)
function NetworkOwnedClass.new(parentInstance, manifest)
	local instance = BaseObject.new(parentInstance)
	setmetatable(instance, NetworkOwnedClass)
	instance.manifest = manifest
	return instance
end
function NetworkOwnedClass.GetOwner(self)
	return Players:GetPlayerByUserId(self.manifest.networkOwnerIdObj.Value)
end
function NetworkOwnedClass.GetOwnerChangedSignal(self)
	return self.manifest.networkOwnerIdObj.Changed
end
return ManifestBinder.new("NetworkOwned", {
	networkOwnerIdObj = NetworkOwnedConsts.NETWORK_OWNER_ID_OBJ_NAME
}, NetworkOwnedClass)
