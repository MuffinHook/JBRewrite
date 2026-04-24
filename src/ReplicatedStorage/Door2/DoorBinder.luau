-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local DoorConsts = require(script.Parent.DoorConsts)
return ManifestBinder.new(DoorConsts.TAG_NAME, {
	innerModel = DoorConsts.INNER_MODEL_NAME
}, require(script.Parent.Door))
