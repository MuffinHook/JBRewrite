local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local DogConsts = require(script.Parent.DogConsts)
return Binder.new(DogConsts.TAG_NAME, require(script.Parent.Dog))