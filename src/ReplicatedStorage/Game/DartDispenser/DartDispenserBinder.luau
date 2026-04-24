-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local DartDispenserConsts = require(script.Parent.DartDispenserConsts)
return Binder.new(DartDispenserConsts.TAG_NAME, require(script.Parent.DartDispenser))
