-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Default = require(script.Parent.Default)
local function MakeSound(p1, p2)
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(p2)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = p1
	return Sound
end
local function MakeCar(p1, p2)
	local Model = p1.Model
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
	p1.SoundPart = Part
	p1.SoundHorn = Sound
	local lastTouchTime = tick()
	Model.Model.Front.Touched:connect(function(p1)
		if not RunUtils.isStudio() then
			local currentTouchTime = tick()
			if not (currentTouchTime - lastTouchTime < 0.1) then
				local Vehicles = workspace:FindFirstChild("Vehicles")
				if Vehicles and p1:IsDescendantOf(Vehicles) then
					local currentVehicle = p1
					repeat
						currentVehicle = currentVehicle.Parent
					until currentVehicle.Parent == Vehicles or currentVehicle == Vehicles
					if currentVehicle.Parent == Vehicles then
						ReplicatedStorage:FindFirstChild("HitByTrainRemote"):FireServer()
					end
				end
				local hitObject = p1.Parent
				if hitObject == LocalPlayer.Character then
					local Humanoid = hitObject:FindFirstChild("Humanoid")
					if Humanoid and Humanoid.Health > 1 then
						p2:FireServer("x" .. ("b1v6eb1nt"):sub(2, 5):reverse() .. "us6", 100, "Train")
						lastTouchTime = currentTouchTime
					end
				end
			end
		end
	end)
	p1.LastHorn = 0
	p1.HornWait = 0
	return Default.MakeCar(p1)
end
local function UpdateSound(p1, p2)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local Position = RootPart.Position
				local currentTime = tick()
				if currentTime - p1.LastHorn > p1.HornWait then
					p1.LastHorn = currentTime
					p1.HornWait = math.random() > 0.9 and 4 + math.random() * 2 or math.random() * 20 + 40
					p1.SoundHorn:Play()
				end
				local closestDistance = 500
				closestPosition = nil
				secondClosestDistance = closestDistance
				secondClosestPosition = nil
				for i = 1, #p2.Cars do
					local car = p2.Cars[i]
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
				local SoundPart = p1.SoundPart
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
	MoveCar = function(p1, p2, p3, p4)
		local Speed = p2.Speed
		UpdateSound(p1, p2)
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1)
		p1.SoundPart:Destroy()
		p1.SoundHorn:Destroy()
		return Default.DestroyCar(p1)
	end
}
