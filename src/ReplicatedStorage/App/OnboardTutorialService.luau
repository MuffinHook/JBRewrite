-- Reviewed by Claude
-- variables reassigned
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local MinimapService = require(script.Parent.MinimapService)
local module = {}
local function getRobberyMarkerForName(markerName)
	for index, marker in CollectionService:GetTagged("RobberyMarker") do
		if marker.Name == markerName then
			return marker
		end
	end
	return nil
end
function module.init()
	task.spawn(function()
		local SetRobberyWaypointRemote = ReplicatedStorage.App:WaitForChild("SetRobberyWaypointRemote")
		local requestCounter = 0
		SetRobberyWaypointRemote.OnClientEvent:Connect(function(waypointData)
			local currentRequest = requestCounter + 1
			requestCounter = currentRequest
			while true do
				local markerName = waypointData.markerName
				local foundMarker = nil
				local success = false
				for idx, marker in CollectionService:GetTagged("RobberyMarker") do
					if marker.Name == markerName then
						foundMarker = marker
						break
					end
				end
				if foundMarker then
					MinimapService.addWaypoint(Dictionary.merge(waypointData, {
						part = foundMarker
					}))
					success = true
				else
					warn("No part found for marker name", waypointData.markerName)
					task.wait(1)
				end
				if success or currentRequest ~= currentRequest then
					return
				end
			end
		end)
	end)
end
return module
