local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local HomeConsts = require(script.Parent.HomeConsts)
return Binder.new(HomeConsts.TAG_NAME, require(script.Parent.Home))
