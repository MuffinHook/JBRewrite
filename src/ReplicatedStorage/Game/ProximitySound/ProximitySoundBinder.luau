local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local ProximitySoundConsts = require(script.Parent.ProximitySoundConsts)
return Binder.new(ProximitySoundConsts.TAG_NAME, require(script.Parent.ProximitySound))