local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local DestructibleConsts = require(script.Parent.DestructibleConsts)
return Binder.new(DestructibleConsts.SPAWN_TAG_NAME, require(script.Parent.DestructibleSpawn))
