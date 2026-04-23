local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local HotbarItemConsts = require(script.Parent.HotbarItemConsts)
return Binder.new(HotbarItemConsts.TAG_NAME, require(script.Parent.HotbarItem))