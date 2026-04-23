local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local SurfaceConsts = require(script.Parent.SurfaceConsts)
return Binder.new(SurfaceConsts.TAG_NAME, require(script.Parent.Surface))