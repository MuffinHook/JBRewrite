
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)

local BossNPC = {}
BossNPC.__index = BossNPC
setmetatable(BossNPC, BaseObject)

-- Decomp Error: BossNPCBinder failed decompilation; rebuilt binder shell to preserve Start/Stop binding behavior.
function BossNPC.new(obj)
	local self = BaseObject.new(obj)
	setmetatable(self, BossNPC)
	return self
end

return Binder.new("BossNPC", BossNPC)
