local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
local VehicleData = require(script.Parent.VehicleData)
local makesList = {}
for i, vehicleData in ipairs(VehicleData) do
	makesList[i] = vehicleData.Make
end
return Enumer(makesList)
