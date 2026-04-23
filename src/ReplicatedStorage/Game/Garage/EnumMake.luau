local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
local VehicleData = require(script.Parent.VehicleData)
local t = {}
for i, v in ipairs(VehicleData) do
	t[i] = v.Make
end
return Enumer(t)