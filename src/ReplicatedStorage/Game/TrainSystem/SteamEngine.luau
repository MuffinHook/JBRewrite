local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local Default = require(script.Parent.Default)
local CollectionService = game:GetService("CollectionService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local function MakeSound(car, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(soundId)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = car
	return Sound
end
local function MakeCar(car, train)
	local Model = car.Model
	CollectionService:AddTag(Model.Model.TrainPassenger, "RobberyMarker")
	local Base = car.Base
	local iteratorFunc = next
	local wheelChildren, wheelEndIndex = Model.SteamWheels:GetChildren()
	local wheelMotors = {}
	for wheelIndex, wheelInstance in iteratorFunc, wheelChildren, wheelEndIndex do
		local wheelMotor = Joint.CustomMotor(wheelInstance, Base, CFrame.new(), Base.CFrame:toObjectSpace(wheelInstance.CFrame))
		wheelInstance.Anchored = false
		table.insert(wheelMotors, wheelMotor)
	end
	car.Wheels = wheelMotors
	local WheelLink = Model.WheelLink
	local wheelLinkMotor = Joint.Motor(WheelLink, Base, WheelLink.CFrame:ToObjectSpace(Base.CFrame))
	WheelLink.Anchored = false
	car.WheelLinkMotor = wheelLinkMotor
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	Part.Parent = workspace
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(988440047)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = Model.Model.Bell
	Sound.EmitterSize = 50
	Sound.Volume = 0.4
	local Sound_2 = Instance.new("Sound")
	Sound_2.SoundId = "rbxassetid://" .. tostring(2801432206)
	Sound_2.Volume = 0.25
	Sound_2.RollOffMaxDistance = 768
	Sound_2.RollOffMinDistance = 16
	Sound_2.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_2.Parent = Model.Model.Bell
	Sound_2.EmitterSize = 250
	Sound_2.Volume = 0.5
	local Sound_3 = Instance.new("Sound")
	Sound_3.SoundId = "rbxassetid://" .. tostring(10574713204)
	Sound_3.Volume = 0.25
	Sound_3.RollOffMaxDistance = 768
	Sound_3.RollOffMinDistance = 16
	Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_3.Parent = Model.BackBogey
	local chugSound = Sound_3
	chugSound.PlaybackSpeed = 1
	chugSound.Volume = 0.15
	chugSound.EmitterSize = 10
	chugSound.Looped = true
	chugSound:Play()
	car.SoundChugga = chugSound
	local Sound_4 = Instance.new("Sound")
	Sound_4.SoundId = "rbxassetid://" .. tostring(10563992041)
	Sound_4.Volume = 0.25
	Sound_4.RollOffMaxDistance = 768
	Sound_4.RollOffMinDistance = 16
	Sound_4.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_4.Parent = Part
	local ambientSound = Sound_4
	ambientSound.Looped = true
	ambientSound.Volume = 0.25
	ambientSound:Play()
	car.SoundPart = Part
	car.SoundBell = Sound
	car.SoundWhistle = Sound_2
	local lastTouchTime = tick()
	Model.Model.Front.Touched:connect(function(touchedInstance)
		if not RunUtils.isStudio() then
			local currentTime = tick()
			if not (currentTime - lastTouchTime < 0.1) then
				local Vehicles = workspace:FindFirstChild("Vehicles")
				if Vehicles and touchedInstance:IsDescendantOf(Vehicles) then
					local touchedPart = touchedInstance
					repeat
						touchedPart = touchedPart.Parent
					until touchedPart.Parent == Vehicles or touchedPart == Vehicles
					if touchedPart.Parent == Vehicles then
						ReplicatedStorage:FindFirstChild("HitByTrainRemote"):FireServer()
					end
				end
				local characterParent = touchedInstance.Parent
				if characterParent == LocalPlayer.Character then
					local Humanoid = characterParent:FindFirstChild("Humanoid")
					if Humanoid and Humanoid.Health > 1 then
						train:FireServer("enviornmentDamage", 100, "Train")
						lastTouchTime = currentTime
					end
				end
			end
		end
	end)
	car.LastHorn = 0
	car.HornWait = 0
	car.LastBell = 0
	car.LastBellSpeed = 0
	return Default.MakeCar(car)
end
local function UpdateSound(car, train)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local Position = RootPart.Position
				local currentTime = tick()
				if currentTime - car.LastBell > 5 and math.abs(train.Speed - car.LastBellSpeed) > 30 then
					car.LastBell = currentTime
					car.LastBellSpeed = train.Speed
					car.SoundBell:Play()
				end
				if currentTime - car.LastHorn > car.HornWait then
					car.LastHorn = currentTime
					car.HornWait = math.random() > 0.9 and 4 + math.random() * 2 or math.random() * 20 + 40
					car.SoundWhistle:Play()
				end
				local closestDistance = 500
				local closestPosition = nil
				local secondClosestDistance = closestDistance
				local secondClosestPosition = nil
				for i = 1, #train.Cars do
					local currentCar = train.Cars[i]
					if currentCar.Loaded then
						local Position_2 = currentCar.Model.Base.Position
						local Magnitude = (Position - Position_2).Magnitude
						if Magnitude < closestDistance then
							closestDistance, closestPosition, secondClosestDistance, secondClosestPosition = Magnitude, Position_2, closestDistance, closestPosition
						elseif Magnitude < secondClosestDistance then
							secondClosestDistance = Magnitude
							secondClosestPosition = Position_2
						end
					end
				end
				local SoundPart = car.SoundPart
				if secondClosestPosition and closestPosition then
					if SoundPart.Parent ~= workspace then
						SoundPart.Parent = workspace
					end
					local soundPosition = (closestPosition + secondClosestPosition) / 2
					local lerpAlpha = if (soundPosition - SoundPart.Position).Magnitude > 200 then 0.2 else 0.05
					SoundPart.CFrame = SoundPart.CFrame:Lerp(CFrame.new(soundPosition), lerpAlpha)
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
	MoveCar = function(car, train, deltaTime, additionalParam)
		local wheelRotationSpeed = train.Speed * deltaTime
		local RightVector = car.Base.CFrame.RightVector
		for wheelIndex, wheelMotor in next, car.Wheels do
			wheelMotor.C0 = wheelMotor.C0 * CFrame.Angles(math.sign((wheelMotor.Part0.CFrame.RightVector:Dot(RightVector))) * wheelRotationSpeed / 3.368, 0, 0)
		end
		car._wheelLinkAngle = (car._wheelLinkAngle or 0) + wheelRotationSpeed / 2
		local wheelLinkYPosition = math.cos(car._wheelLinkAngle) * 2
		car.WheelLinkMotor.C1 = CFrame.new(0, math.sin(car._wheelLinkAngle) * 2, wheelLinkYPosition)
		UpdateSound(car, train)
		return Default.MoveCar(car, train, deltaTime, additionalParam)
	end,
	DestroyCar = function(car)
		car.SoundPart:Destroy()
		car.SoundBell:Destroy()
		car.SoundWhistle:Destroy()
		car.SoundChugga:Destroy()
		return Default.DestroyCar(car)
	end
}
