local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local MoneyTruckConsts_upvr = require(script.Parent.MoneyTruckConsts)
local module_upvr = {
    onRunningChanged = Signal.new();
    onVehicleModelChanged = Signal.new();
    _vehicleModelValue = nil;
}
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local function onClientEvent_upvr() -- Line 14, Named "onClientEvent"
    local any_getVehicleModel_result1_2 = module_upvr.getVehicleModel()
    local var10
    if any_getVehicleModel_result1_2 then
        var10 = any_getVehicleModel_result1_2:FindFirstChild("Model")
        if var10 then
            var10 = any_getVehicleModel_result1_2.Model:FindFirstChild("Cash")
            if var10 then
                var10 = any_getVehicleModel_result1_2.Model
                var10 = var10.Cash:Destroy
                var10()
            end
        end
    end
    var10 = any_getVehicleModel_result1_2
    if var10 then
        var10 = any_getVehicleModel_result1_2:FindFirstChild(MoneyTruckConsts_upvr.ROBBERY_MUSIC_VALUE_NAME)
    end
    if var10 and var10.Value then
        Audio_upvr.promiseFadeTo(var10.Value, 0, 2)
    end
end
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
function module_upvr.init() -- Line 25
    waitForChild_upvr(workspace, RobberyConsts_upvr.FOLDER_NAME, 30):andThen(function(arg1) -- Line 27
        return waitForChild_upvr(arg1, MoneyTruckConsts_upvr.ROBBERY_VALUE_NAME, 30)
    end):andThen(module_upvr._setup):catch(warn)
end
function module_upvr._setup(arg1) -- Line 33
    waitForChild_upvr(arg1, MoneyTruckConsts_upvr.RUNNING_VALUE_NAME, 30):andThen(function(arg1_2) -- Line 35
        module_upvr.onRunningChanged:Fire(arg1_2.Value)
        arg1_2.Changed:Connect(function(arg1_3) -- Line 37
            module_upvr.onRunningChanged:Fire(arg1_3)
        end)
    end):catch(warn)
    waitForChild_upvr(arg1, MoneyTruckConsts_upvr.VEHICLE_MODEL_VALUE_NAME, 30):andThen(function(arg1_4) -- Line 43
        module_upvr._vehicleModelValue = arg1_4
        module_upvr.onVehicleModelChanged:Fire(arg1_4.Value)
        arg1_4.Changed:Connect(function(arg1_5) -- Line 46
            module_upvr.onVehicleModelChanged:Fire(arg1_5)
        end)
    end):catch(warn)
    waitForChild_upvr(arg1, MoneyTruckConsts_upvr.HIDE_CASH_REMOTE_NAME, 30):andThen(function(arg1_6) -- Line 52
        arg1_6.OnClientEvent:Connect(onClientEvent_upvr)
    end):catch(warn)
end
function module_upvr.getVehicleModel() -- Line 57
    local _vehicleModelValue = module_upvr._vehicleModelValue
    if _vehicleModelValue then
        _vehicleModelValue = module_upvr
        _vehicleModelValue = _vehicleModelValue._vehicleModelValue
        _vehicleModelValue = _vehicleModelValue.Value
    end
    return _vehicleModelValue
end
return module_upvr