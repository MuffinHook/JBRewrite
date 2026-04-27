local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local ProximityCamShakeConsts = require(script.Parent.ProximityCamShakeConsts)
return Binder.new(ProximityCamShakeConsts.TAG_NAME, require(script.Parent.ProximityCamShake))
