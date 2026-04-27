local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local MilitaryTurretConsts = require(script.Parent.MilitaryTurretConsts)
return Binder.new(MilitaryTurretConsts.TAG_NAME, require(script.Parent.MilitaryTurret))
