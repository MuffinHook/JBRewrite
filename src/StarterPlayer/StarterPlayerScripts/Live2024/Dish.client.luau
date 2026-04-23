local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local isMAIN_WORLD_NAME = require(ReplicatedStorage.App.RunUtils).getWorld() == RunConsts.MAIN_WORLD_NAME
local function _(p1, p2) --[[ Unused ]]
	for i = 1, #p1 do
		local v1 = p1[i]
		if v1 == "1" then
			task.spawn(p2, "1", 0.2)
			task.wait(0.2)
			task.wait(0.2)
		elseif v1 == "2" then
			task.spawn(p2, "2", 0.6000000000000001)
			task.wait(0.6000000000000001)
			task.wait(0.2)
		elseif v1 == "4" then
			task.wait(0.6000000000000001)
		elseif v1 == "3" then
			task.wait(1.4000000000000001)
		end
	end
end
local function _() --[[ Unused | Upvalues: v1 (ref) ]]
	v1:Destroy()
end
local function _() --[[ Unused | Upvalues: v2 (ref) ]]
	v2:Destroy()
end
local function _(p1) --[[ Unused | Upvalues: v3 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
	if p1 == "1" then
		v3.Transparency = 0
		v4.Transparency = 0.7
		local v1 = v5.ObjectLocal(v6.PrimaryPart, 17091968256, {
			Volume = 1,
			TimePosition = 0.1,
			RollOffMaxDistance = 1536
		})
		task.wait(0.2)
		v5.promiseFadeTo(v1, 0, 0.1):andThen(function() --[[ Line: 68 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
		v3.Transparency = 1
		v4.Transparency = 1
	elseif p1 == "2" then
		v3.Transparency = 0
		v4.Transparency = 0.7
		local v2 = v5.ObjectLocal(v6.PrimaryPart, 17091967549, {
			Volume = 1,
			TimePosition = 0.1,
			RollOffMaxDistance = 1536
		})
		task.wait(0.6000000000000001)
		v5.promiseFadeTo(v2, 0, 0.1):andThen(function() --[[ Line: 82 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
		v3.Transparency = 1
		v4.Transparency = 1
	end
end
local function _(p1) --[[ Unused | Upvalues: v7 (ref), v8 (ref) ]]
	local Dish = workspace:WaitForChild("Live2024"):WaitForChild("Dish")
	local Door = Dish:WaitForChild("Door")
	local Laser = Dish:WaitForChild("Laser")
	local Sphere = Dish:WaitForChild("Sphere")
	local v1 = os.clock()
	v7(p1, function(p1) --[[ Line: 58 | Upvalues: Laser (copy), Sphere (copy), v8 (ref), Door (copy) ]]
		if p1 == "1" then
			Laser.Transparency = 0
			Sphere.Transparency = 0.7
			local v1 = v8.ObjectLocal(Door.PrimaryPart, 17091968256, {
				Volume = 1,
				TimePosition = 0.1,
				RollOffMaxDistance = 1536
			})
			task.wait(0.2)
			v8.promiseFadeTo(v1, 0, 0.1):andThen(function() --[[ Line: 68 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
			Laser.Transparency = 1
			Sphere.Transparency = 1
		elseif p1 == "2" then
			Laser.Transparency = 0
			Sphere.Transparency = 0.7
			local v2 = v8.ObjectLocal(Door.PrimaryPart, 17091967549, {
				Volume = 1,
				TimePosition = 0.1,
				RollOffMaxDistance = 1536
			})
			task.wait(0.6000000000000001)
			v8.promiseFadeTo(v2, 0, 0.1):andThen(function() --[[ Line: 82 | Upvalues: v2 (copy) ]]
				v2:Destroy()
			end)
			Laser.Transparency = 1
			Sphere.Transparency = 1
		end
	end)
	print("Time taken: ", os.clock() - v1)
end