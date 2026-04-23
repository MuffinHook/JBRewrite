-- Reviewed by Claude
game:GetService("Players")
game:GetService("Chat")
local RunService = game:GetService("RunService")
local v1
if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	v1 = require(ServerStorage.Game.ServerAdoption.ServerAdoptionUtils)
else
	v1 = nil
end
local function GetFilteredLicensePlate(p1, p2)
	local v12 = p2:upper():gsub("[^%w%s]", ""):sub(1, 7)
	if #v12 ~= 0 then
		local v2 = v1.getFilteredDogName(p1, v12)
		if v2 and #v2 ~= 0 then
			return v2
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
				local v1 = GetFilteredLicensePlate(Driver, p1.Name)
				if v1 then
					plate.SurfaceGui.Frame.TextLabel.Text = v1
				end
			end
		end
	end
end