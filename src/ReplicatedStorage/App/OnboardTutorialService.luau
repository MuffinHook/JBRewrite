-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local MinimapService = require(script.Parent.MinimapService)
local t = {}
local function getRobberyMarkerForName(p1)
	for v1, v2 in CollectionService:GetTagged("RobberyMarker") do
		if v2.Name == p1 then
			return v2
		end
	end
	return nil
end
function t.init()
	task.spawn(function()
		local SetRobberyWaypointRemote = ReplicatedStorage.App:WaitForChild("SetRobberyWaypointRemote")
		local v1 = 0
		SetRobberyWaypointRemote.OnClientEvent:Connect(function(p1)
			local v12 = v1 + 1
			v1 = v12
			while true do
				local markerName = p1.markerName
				local v2 = nil
				local v3 = false
				for v4, v5 in CollectionService:GetTagged("RobberyMarker") do
					if v5.Name == markerName then
						v2 = v5
						break
					end
				end
				if v2 then
					MinimapService.addWaypoint(Dictionary.merge(p1, {
						part = v2
					}))
					v3 = true
				else
					warn("No part found for marker name", p1.markerName)
					task.wait(1)
				end
				if v3 or v12 ~= v12 then
					return
				end
			end
		end)
	end)
end
return t