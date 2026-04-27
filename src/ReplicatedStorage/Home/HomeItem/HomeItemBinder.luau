local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local HomeItemConsts = require(script.Parent.HomeItemConsts)
return Binder.new(HomeItemConsts.TAG_NAME, require(script.Parent.HomeItem))
