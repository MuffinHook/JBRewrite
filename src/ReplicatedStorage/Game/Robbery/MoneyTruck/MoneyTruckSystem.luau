local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio = require(ReplicatedStorage.Std.Audio)
local MoneyTruckConsts = require(script.Parent.MoneyTruckConsts)
local t = {
	onRunningChanged = Signal.new(),
	onVehicleModelChanged = Signal.new(),
	_vehicleModelValue = nil
}
local function onClientEvent() --[[ Line: 14 | Upvalues: t (copy), MoneyTruckConsts (copy), Audio (copy) ]]
	local v1 = t.getVehicleModel()
	if v1 and (v1:FindFirstChild("Model") and v1.Model:FindFirstChild("Cash")) then
		v1.Model.Cash:Destroy()
	end
	local v2 = v1 and v1:FindFirstChild(MoneyTruckConsts.ROBBERY_MUSIC_VALUE_NAME)
	if v2 and v2.Value then
		Audio.promiseFadeTo(v2.Value, 0, 2)
	end
end
function t.init() --[[ Line: 25 | Upvalues: waitForChild (copy), RobberyConsts (copy), MoneyTruckConsts (copy), t (copy) ]]
	waitForChild(workspace, RobberyConsts.FOLDER_NAME, 30):andThen(function(p1) --[[ Line: 27 | Upvalues: waitForChild (ref), MoneyTruckConsts (ref) ]]
		return waitForChild(p1, MoneyTruckConsts.ROBBERY_VALUE_NAME, 30)
	end):andThen(t._setup):catch(warn)
end
function t._setup(p1) --[[ Line: 33 | Upvalues: waitForChild (copy), MoneyTruckConsts (copy), t (copy), onClientEvent (copy) ]]
	waitForChild(p1, MoneyTruckConsts.RUNNING_VALUE_NAME, 30):andThen(function(p1) --[[ Line: 35 | Upvalues: t (ref) ]]
		t.onRunningChanged:Fire(p1.Value)
		p1.Changed:Connect(function(p1) --[[ Line: 37 | Upvalues: t (ref) ]]
			t.onRunningChanged:Fire(p1)
		end)
	end):catch(warn)
	waitForChild(p1, MoneyTruckConsts.VEHICLE_MODEL_VALUE_NAME, 30):andThen(function(p1) --[[ Line: 43 | Upvalues: t (ref) ]]
		t._vehicleModelValue = p1
		t.onVehicleModelChanged:Fire(p1.Value)
		p1.Changed:Connect(function(p1) --[[ Line: 46 | Upvalues: t (ref) ]]
			t.onVehicleModelChanged:Fire(p1)
		end)
	end):catch(warn)
	waitForChild(p1, MoneyTruckConsts.HIDE_CASH_REMOTE_NAME, 30):andThen(function(p1) --[[ Line: 52 | Upvalues: onClientEvent (ref) ]]
		p1.OnClientEvent:Connect(onClientEvent)
	end):catch(warn)
end
function t.getVehicleModel() --[[ Line: 57 | Upvalues: t (copy) ]]
	return t._vehicleModelValue and t._vehicleModelValue.Value
end
return t