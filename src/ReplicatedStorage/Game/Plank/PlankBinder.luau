local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local PlankConsts = require(script.Parent.PlankConsts)
return Binder.new(PlankConsts.TAG_NAME, require(script.Parent.Plank))
