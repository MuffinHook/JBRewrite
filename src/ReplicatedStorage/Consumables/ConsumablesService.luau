local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local ConsumablesConsts = require(ReplicatedStorage.Consumables.ConsumablesConsts)
local t = {
	onConsumablesUpdated = require(ReplicatedStorage.Std.Signal).new()
}
function t.init() --[[ Line: 9 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), ConsumablesConsts (copy), t (copy) ]]
	waitForChild(ReplicatedStorage, ConsumablesConsts.UPDATE_CONSUMABLES_REMOTE_NAME):andThen(function() --[[ Line: 10 | Upvalues: t (ref) ]]
		t.onConsumablesUpdated:Fire()
	end)
end
return t