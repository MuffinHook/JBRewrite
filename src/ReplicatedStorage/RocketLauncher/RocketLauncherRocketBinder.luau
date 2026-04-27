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
function tbl.new(baseConfig)
	local instance = BaseObject.new(baseConfig)
	setmetatable(instance, tbl)
	assert(CollectionService:HasTag(instance.obj, SeekingMissileConsts.TAG_NAME), "Must be seeking missile")
	SeekingMissileBinder:Promise(instance.obj):andThen(function(seekingMissile)
 seekingMissile.onExploded:Connect(function(explosionPosition)
 RocketLauncherUtils.explodeAt(explosionPosition)
 end)
	end)
	return instance
end
return Binder.new(RocketLauncherConsts.ROCKET_TAG_NAME, tbl)
