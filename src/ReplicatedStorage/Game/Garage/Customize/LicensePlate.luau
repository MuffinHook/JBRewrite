-- Reviewed by Claude
-- variables reassigned
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
local function GetFilteredLicensePlate(p1, p2)
	local cleanedPlate = p2:upper():gsub("[^%w%s]", ""):sub(1, 7)
	if #cleanedPlate ~= 0 then
		local filteredPlateText = serverAdoptionUtils.getFilteredDogName(p1, cleanedPlate)
		if filteredPlateText and #filteredPlateText ~= 0 then
			return filteredPlateText
		end
	end
end
return function(p1, p2)
	if RunService:IsClient() then
		warn("LICENSE PLATE CUSTOMIZE SHOULD NOT BE RUN LOCALLY!", debug.traceback())
	else
		local Type = p2.Type
		local Make = p2.Make
		local Driver = p2.Driver
		local Model_2 = p2.Model:FindFirstChild("Model")
		if Model_2 then
			local plate = Model_2:FindFirstChild("plate")
			if plate and (p1 and Driver) and plate.SurfaceGui.Frame.TextLabel.Text ~= p1.Name then
				local filteredPlate = GetFilteredLicensePlate(Driver, p1.Name)
				if filteredPlate then
					plate.SurfaceGui.Frame.TextLabel.Text = filteredPlate
				end
			end
		end
	end
end
