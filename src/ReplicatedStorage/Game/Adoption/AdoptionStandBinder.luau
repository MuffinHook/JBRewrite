local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
return Binder.new(AdoptionStandConsts.TAG_NAME, require(script.Parent.AdoptionStand))
