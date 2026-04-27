game:GetService("Players")
game:GetService("Chat")
local RunService = game:GetService("RunService")
local serverAdoptionUtils
if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	serverAdoptionUtils = require(ServerStorage.Game.ServerAdoption.ServerAdoptionUtils)
else
	serverAdoptionUtils = nil
end
local function GetFilteredLicensePlate(playerDriver, plateName)
	local cleanedPlate = plateName:upper():gsub("[^%w%s]", ""):sub(1, 7)
	if #cleanedPlate ~= 0 then
		local filteredPlateText = serverAdoptionUtils.getFilteredDogName(playerDriver, cleanedPlate)
		if filteredPlateText and #filteredPlateText ~= 0 then
			return filteredPlateText
		end
	end
end
return function(vehicleData, vehicleConfig)
	if RunService:IsClient() then
		warn("LICENSE PLATE CUSTOMIZE SHOULD NOT BE RUN LOCALLY!", debug.traceback())
	else
		local Type = vehicleConfig.Type
		local Make = vehicleConfig.Make
		local playerDriver = vehicleConfig.Driver
		local modelPart = vehicleConfig.Model:FindFirstChild("Model")
		if modelPart then
			local plate = modelPart:FindFirstChild("plate")
			if plate and (vehicleData and playerDriver) and plate.SurfaceGui.Frame.TextLabel.Text ~= vehicleData.Name then
				local filteredPlate = GetFilteredLicensePlate(playerDriver, vehicleData.Name)
				if filteredPlate then
					plate.SurfaceGui.Frame.TextLabel.Text = filteredPlate
				end
			end
		end
	end
end
