-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio = require(ReplicatedStorage.Std.Audio)
local MoneyTruckConsts = require(script.Parent.MoneyTruckConsts)
local moneyTruckSystem = {
	onRunningChanged = Signal.new(),
	onVehicleModelChanged = Signal.new(),
	_vehicleModelValue = nil
}
local function onClientEvent()
	local vehicleModel = moneyTruckSystem.getVehicleModel()
	if vehicleModel and (vehicleModel:FindFirstChild("Model") and vehicleModel.Model:FindFirstChild("Cash")) then
		vehicleModel.Model.Cash:Destroy()
	end
	local musicValue = vehicleModel and vehicleModel:FindFirstChild(MoneyTruckConsts.ROBBERY_MUSIC_VALUE_NAME)
	if musicValue and musicValue.Value then
		Audio.promiseFadeTo(musicValue.Value, 0, 2)
	end
end
function moneyTruckSystem.init()
	waitForChild(workspace, RobberyConsts.FOLDER_NAME, 30):andThen(function(robberyFolder)
		return waitForChild(robberyFolder, MoneyTruckConsts.ROBBERY_VALUE_NAME, 30)
	end):andThen(moneyTruckSystem._setup):catch(warn)
end
function moneyTruckSystem._setup(robberyFolder)
	waitForChild(robberyFolder, MoneyTruckConsts.RUNNING_VALUE_NAME, 30):andThen(function(p1)
		moneyTruckSystem.onRunningChanged:Fire(p1.Value)
		p1.Changed:Connect(function(p1)
			moneyTruckSystem.onRunningChanged:Fire(p1)
		end)
	end):catch(warn)
	waitForChild(robberyFolder, MoneyTruckConsts.VEHICLE_MODEL_VALUE_NAME, 30):andThen(function(p1)
		moneyTruckSystem._vehicleModelValue = p1
		moneyTruckSystem.onVehicleModelChanged:Fire(p1.Value)
		p1.Changed:Connect(function(p1)
			moneyTruckSystem.onVehicleModelChanged:Fire(p1)
		end)
	end):catch(warn)
	waitForChild(robberyFolder, MoneyTruckConsts.HIDE_CASH_REMOTE_NAME, 30):andThen(function(p1)
		p1.OnClientEvent:Connect(onClientEvent)
	end):catch(warn)
end
function moneyTruckSystem.getVehicleModel()
	return moneyTruckSystem._vehicleModelValue and moneyTruckSystem._vehicleModelValue.Value
end
return moneyTruckSystem
