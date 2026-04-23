local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local CartConsts = require(script.Parent.CartConsts)
return Binder.new(CartConsts.TAG_NAME, require(script.Parent.Cart))