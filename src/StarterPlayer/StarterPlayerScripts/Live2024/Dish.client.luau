local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local isMAIN_WORLD_NAME = require(ReplicatedStorage.App.RunUtils).getWorld() == RunConsts.MAIN_WORLD_NAME
local function _(commands, callback)
	for i = 1, #commands do
		local commandCode = commands[i]
		if commandCode == "1" then
			task.spawn(callback, "1", 0.2)
			task.wait(0.2)
			task.wait(0.2)
		elseif commandCode == "2" then
			task.spawn(callback, "2", 0.6000000000000001)
			task.wait(0.6000000000000001)
			task.wait(0.2)
		elseif commandCode == "4" then
			task.wait(0.6000000000000001)
		elseif commandCode == "3" then
			task.wait(1.4000000000000001)
		end
	end
end
local function _()
	v1:Destroy()
end
local function _()
	v2:Destroy()
end
local function _(commandCode)
	if commandCode == "1" then
		laserVisual.Transparency = 0
		sphereVisual.Transparency = 0.7
		local commandSound = audioManager.ObjectLocal(doorPart.PrimaryPart, 17091968256, {
			Volume = 1,
			TimePosition = 0.1,
			RollOffMaxDistance = 1536
		})
		task.wait(0.2)
		audioManager.promiseFadeTo(commandSound, 0, 0.1):andThen(function()
			commandSound:Destroy()
		end)
		laserVisual.Transparency = 1
		sphereVisual.Transparency = 1
	elseif commandCode == "2" then
		laserVisual.Transparency = 0
		sphereVisual.Transparency = 0.7
		local commandSound = audioManager.ObjectLocal(doorPart.PrimaryPart, 17091967549, {
			Volume = 1,
			TimePosition = 0.1,
			RollOffMaxDistance = 1536
		})
		task.wait(0.6000000000000001)
		audioManager.promiseFadeTo(commandSound, 0, 0.1):andThen(function()
			commandSound:Destroy()
		end)
		laserVisual.Transparency = 1
		sphereVisual.Transparency = 1
	end
end
local function _(commandSequence)
	local Dish = workspace:WaitForChild("Live2024"):WaitForChild("Dish")
	local Door = Dish:WaitForChild("Door")
	local Laser = Dish:WaitForChild("Laser")
	local Sphere = Dish:WaitForChild("Sphere")
	local startTime = os.clock()
	playCommandSequence(commandSequence, function(commandCode)
		if commandCode == "1" then
			Laser.Transparency = 0
			Sphere.Transparency = 0.7
			local commandSound = audioManager.ObjectLocal(Door.PrimaryPart, 17091968256, {
				Volume = 1,
				TimePosition = 0.1,
				RollOffMaxDistance = 1536
			})
			task.wait(0.2)
			audioManager.promiseFadeTo(commandSound, 0, 0.1):andThen(function()
				commandSound:Destroy()
			end)
			Laser.Transparency = 1
			Sphere.Transparency = 1
		elseif commandCode == "2" then
			Laser.Transparency = 0
			Sphere.Transparency = 0.7
			local commandSound = audioManager.ObjectLocal(Door.PrimaryPart, 17091967549, {
				Volume = 1,
				TimePosition = 0.1,
				RollOffMaxDistance = 1536
			})
			task.wait(0.6000000000000001)
			audioManager.promiseFadeTo(commandSound, 0, 0.1):andThen(function()
				commandSound:Destroy()
			end)
			Laser.Transparency = 1
			Sphere.Transparency = 1
		end
	end)
	print("Time taken: ", os.clock() - startTime)
end
