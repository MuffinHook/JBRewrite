-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local SmokeGrenadeConsts = require(script.Parent.SmokeGrenadeConsts)
return Binder.new(SmokeGrenadeConsts.TAG_NAME, require(script.Parent.SmokeGrenade))
