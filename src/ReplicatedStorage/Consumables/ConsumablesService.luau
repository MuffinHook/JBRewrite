-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local ConsumablesConsts = require(ReplicatedStorage.Consumables.ConsumablesConsts)
local ConsumablesService = {
	onConsumablesUpdated = require(ReplicatedStorage.Std.Signal).new()
}
function ConsumablesService.init()
	waitForChild(ReplicatedStorage, ConsumablesConsts.UPDATE_CONSUMABLES_REMOTE_NAME):andThen(function()
		ConsumablesService.onConsumablesUpdated:Fire()
	end)
end
return ConsumablesService
