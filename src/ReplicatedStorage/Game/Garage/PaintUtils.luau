local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = {
	drill = function(p1, p2) --[[ Name: drill | Line: 6 ]]
		local t = {}
		for i, v in ipairs(p2) do
			t[i] = v
		end
		while p1 and #t > 0 do
			p1 = p1:FindFirstChild(table.remove(t))
		end
		return p1
	end,
	getVehiclePath = function(p1) --[[ Name: getVehiclePath | Line: 16 ]]
		local t = { p1.Name }
		local v1 = p1
		while not v1:FindFirstChild("BoundingBox") do
			v1 = v1.Parent
			if not v1 then
				warn(table.concat(t, "."))
				error("getVehiclePath failed, reached nil")
			end
			table.insert(t, v1.Name)
		end
		return t
	end
}
function t.GetDefaultVehiclePart(p1) --[[ Line: 29 | Upvalues: t (copy), RunService (copy), ReplicatedStorage (copy) ]]
	local v1 = t.getVehiclePath(p1)
	if RunService:IsServer() then
		return t.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), v1) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), v1) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), v1) or t.drill(game:GetService("ServerStorage").Resource:FindFirstChild("ServerVehicles"), v1)
	else
		return t.drill(ReplicatedStorage.Resource:FindFirstChild("Vehicles"), v1) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Plane"), v1) or t.drill(ReplicatedStorage.Resource:FindFirstChild("Boat"), v1)
	end
end
return t