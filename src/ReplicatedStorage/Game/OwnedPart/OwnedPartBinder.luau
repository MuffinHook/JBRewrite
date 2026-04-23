local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local OwnedPartConsts = require(script.Parent.OwnedPartConsts)
return Binder.new(OwnedPartConsts.TAG_NAME, require(script.Parent.OwnedPart))