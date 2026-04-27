local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local PaintUtils = {
	drill = function(startingObject, pathToDrill)
		local remainingPath = {}
		for i, pathElement in ipairs(pathToDrill) do
			remainingPath[i] = pathElement
		end
		while startingObject and #remainingPath > 0 do
			startingObject = startingObject:FindFirstChild(table.remove(remainingPath))
		end
		return startingObject
	end,
	getVehiclePath = function(rootPart)
		local pathArray = { rootPart.Name }
		local currentParent = rootPart
		while not currentParent:FindFirstChild("BoundingBox") do
			currentParent = currentParent.Parent
			if not currentParent then
				warn(table.concat(pathArray, "."))
				error("getVehiclePath failed, reached nil")
			end
			table.insert(pathArray, currentParent.Name)
		end
		return pathArray
	end
}
function PaintUtils.GetDefaultVehiclePart(part)
	local vehiclePath = PaintUtils.getVehiclePath(part)
	if RunService:IsServer() then
		return PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), vehiclePath) or PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), vehiclePath) or PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), vehiclePath) or PaintUtils.drill(game:GetService("ServerStorage").Resource:FindFirstChild("ServerVehicles"), vehiclePath)
	else
		return PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), vehiclePath) or PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), vehiclePath) or PaintUtils.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), vehiclePath)
	end
end
return PaintUtils
