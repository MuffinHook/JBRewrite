-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RocketLauncherConsts = require(ReplicatedStorage.RocketLauncher.RocketLauncherConsts)
local RocketLauncherUtils = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
local SeekingMissileBinder = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	assert(CollectionService:HasTag(v1.obj, SeekingMissileConsts.TAG_NAME), "Must be seeking missile")
	SeekingMissileBinder:Promise(v1.obj):andThen(function(p1)
 p1.onExploded:Connect(function(p1)
 RocketLauncherUtils.explodeAt(p1)
 end)
	end)
	return v1
end
return Binder.new(RocketLauncherConsts.ROCKET_TAG_NAME, t)