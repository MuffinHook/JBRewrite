local ReplicatedStorage = game:GetService("ReplicatedStorage")
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
return require(ReplicatedStorage.Std.Binder).new(C4Consts.TAG_NAME, require(script.Parent.C4))