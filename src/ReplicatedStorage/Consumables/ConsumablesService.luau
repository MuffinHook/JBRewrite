local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {
    onConsumablesUpdated = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local ConsumablesConsts_upvr = require(ReplicatedStorage_upvr.Consumables.ConsumablesConsts)
function module_upvr.init() -- Line 9
    waitForChild_upvr(ReplicatedStorage_upvr, ConsumablesConsts_upvr.UPDATE_CONSUMABLES_REMOTE_NAME):andThen(function() -- Line 10
        module_upvr.onConsumablesUpdated:Fire()
    end)
end
return module_upvr