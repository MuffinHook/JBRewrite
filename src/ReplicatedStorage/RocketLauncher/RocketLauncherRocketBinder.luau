-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RocketLauncherConsts = require(ReplicatedStorage.RocketLauncher.RocketLauncherConsts)
local RocketLauncherUtils = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
local SeekingMissileBinder = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local tbl = {}
tbl.__index = tbl
setmetatable(tbl, BaseObject)
function tbl.new(p1)
	local instance = BaseObject.new(p1)
	setmetatable(instance, tbl)
	assert(CollectionService:HasTag(instance.obj, SeekingMissileConsts.TAG_NAME), "Must be seeking missile")
	SeekingMissileBinder:Promise(instance.obj):andThen(function(p1)
 p1.onExploded:Connect(function(p1)
 RocketLauncherUtils.explodeAt(p1)
 end)
	end)
	return instance
end
return Binder.new(RocketLauncherConsts.ROCKET_TAG_NAME, tbl)