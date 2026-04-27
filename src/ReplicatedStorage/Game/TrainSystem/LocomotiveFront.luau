local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Default = require(script.Parent.Default)
local function MakeSound(soundParent, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(soundId)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = soundParent
	return Sound
end
local function MakeCar(locomotiveData, hitRemote)
	local Model = locomotiveData.Model
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(690528575)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = Model.Model.Front
	Sound.EmitterSize = 50
	Sound.Volume = 0.45
	local Sound_2 = Instance.new("Sound")
	Sound_2.SoundId = "rbxassetid://" .. tostring(10563947644)
	Sound_2.Volume = 0.25
	Sound_2.RollOffMaxDistance = 768
	Sound_2.RollOffMinDistance = 16
	Sound_2.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_2.Parent = Model.BackBogey
	local hornBogeySound = Sound_2
	hornBogeySound.Looped = true
	hornBogeySound:Play()
	local Sound_3 = Instance.new("Sound")
	Sound_3.SoundId = "rbxassetid://" .. tostring(10563992041)
	Sound_3.Volume = 0.25
	Sound_3.RollOffMaxDistance = 768
	Sound_3.RollOffMinDistance = 16
	Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_3.Parent = Part
	local wheelSound = Sound_3
	wheelSound.Looped = true
	wheelSound:Play()
	locomotiveData.SoundPart = Part
	locomotiveData.SoundHorn = Sound
	local lastTouchTime = tick()
	Model.Model.Front.Touched:connect(function(hitPart)
		if not RunUtils.isStudio() then
			local currentTouchTime = tick()
			if not (currentTouchTime - lastTouchTime < 0.1) then
				local Vehicles = workspace:FindFirstChild("Vehicles")
				if Vehicles and hitPart:IsDescendantOf(Vehicles) then
					local currentVehicle = hitPart
					repeat
						currentVehicle = currentVehicle.Parent
					until currentVehicle.Parent == Vehicles or currentVehicle == Vehicles
					if currentVehicle.Parent == Vehicles then
						ReplicatedStorage:FindFirstChild("HitByTrainRemote"):FireServer()
					end
				end
				local hitObject = hitPart.Parent
				if hitObject == LocalPlayer.Character then
					local Humanoid = hitObject:FindFirstChild("Humanoid")
					if Humanoid and Humanoid.Health > 1 then
						hitRemote:FireServer("xe6v1us6", 100, "Train")
						lastTouchTime = currentTouchTime
					end
				end
			end
		end
	end)
	locomotiveData.LastHorn = 0
	locomotiveData.HornWait = 0
	return Default.MakeCar(locomotiveData)
end
local function UpdateSound(locomotiveData, trainCars)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local Position = RootPart.Position
				local currentTime = tick()
				if currentTime - locomotiveData.LastHorn > locomotiveData.HornWait then
					locomotiveData.LastHorn = currentTime
					locomotiveData.HornWait = math.random() > 0.9 and 4 + math.random() * 2 or math.random() * 20 + 40
					locomotiveData.SoundHorn:Play()
				end
				local closestDistance = 500
				closestPosition = nil
				secondClosestDistance = closestDistance
				secondClosestPosition = nil
				for i = 1, #trainCars.Cars do
					local car = trainCars.Cars[i]
					if car.Loaded then
						local Position_2 = car.Model.Base.Position
						local Magnitude = (Position - Position_2).Magnitude
						if Magnitude < closestDistance then
							closestDistance, closestPosition, secondClosestDistance, secondClosestPosition = Magnitude, Position_2, closestDistance, closestPosition
						elseif Magnitude < secondClosestDistance then
							secondClosestDistance = Magnitude
							secondClosestPosition = Position_2
						end
					end
				end
				local SoundPart = locomotiveData.SoundPart
				if secondClosestPosition and closestPosition then
					if SoundPart.Parent ~= workspace then
						SoundPart.Parent = workspace
					end
					local midPoint = (closestPosition + secondClosestPosition) / 2
					local lerpSpeed = if (midPoint - SoundPart.Position).Magnitude > 200 then 0.2 else 0.05
					SoundPart.CFrame = SoundPart.CFrame:Lerp(CFrame.new(midPoint), lerpSpeed)
					return
				elseif SoundPart.Parent == workspace then
					SoundPart.Parent = nil
				end
			end
		end
	end
	return false
end
return {
	MakeCar = MakeCar,
	MoveCar = function(carData, trainData, deltaTime, velocityFactor)
		local Speed = trainData.Speed
		UpdateSound(carData, trainData)
		return Default.MoveCar(carData, trainData, deltaTime, velocityFactor)
	end,
	DestroyCar = function(carData)
		carData.SoundPart:Destroy()
		carData.SoundHorn:Destroy()
		return Default.DestroyCar(carData)
	end
}
