-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = {
	drill = function(p1, p2)
		local t = {}
		for i, v in ipairs(p2) do
			t[i] = v
		end
		while p1 and #t > 0 do
			p1 = p1:FindFirstChild(table.remove(t))
		end
		return p1
	end,
	getVehiclePath = function(rootPart)
		local t = { rootPart.Name }
		local currentParent = rootPart
		while not currentParent:FindFirstChild("BoundingBox") do
			currentParent = currentParent.Parent
			if not currentParent then
				warn(table.concat(t, "."))
				error("getVehiclePath failed, reached nil")
			end
			table.insert(t, currentParent.Name)
		end
		return t
	end
}
function t.GetDefaultVehiclePart(part)
	local vehiclePath = t.getVehiclePath(part)
	if RunService:IsServer() then
		return t.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), vehiclePath) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), vehiclePath) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), vehiclePath) or t.drill(game:GetService("ServerStorage").Resource:FindFirstChild("ServerVehicles"), vehiclePath)
	else
		return t.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), vehiclePath) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), vehiclePath) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), vehiclePath)
	end
end
return t
