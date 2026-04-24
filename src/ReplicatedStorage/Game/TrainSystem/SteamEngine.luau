-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local Default = require(script.Parent.Default)
local CollectionService = game:GetService("CollectionService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
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
	CollectionService:AddTag(Model.Model.TrainPassenger, "RobberyMarker")
	local Base = p1.Base
	local v1 = next
	local v2, v3 = Model.SteamWheels:GetChildren()
	local t = {}
	for v4, v5 in v1, v2, v3 do
		local v6 = Joint.CustomMotor(v5, Base, CFrame.new(), Base.CFrame:toObjectSpace(v5.CFrame))
		v5.Anchored = false
		table.insert(t, v6)
	end
	p1.Wheels = t
	local WheelLink = Model.WheelLink
	local v7 = Joint.Motor(WheelLink, Base, WheelLink.CFrame:ToObjectSpace(Base.CFrame))
	WheelLink.Anchored = false
	p1.WheelLinkMotor = v7
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
	local v8 = Sound_3
	v8.PlaybackSpeed = 1
	v8.Volume = 0.15
	v8.EmitterSize = 10
	v8.Looped = true
	v8:Play()
	p1.SoundChugga = v8
	local Sound_4 = Instance.new("Sound")
	Sound_4.SoundId = "rbxassetid://" .. tostring(10563992041)
	Sound_4.Volume = 0.25
	Sound_4.RollOffMaxDistance = 768
	Sound_4.RollOffMinDistance = 16
	Sound_4.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_4.Parent = Part
	local v9 = Sound_4
	v9.Looped = true
	v9.Volume = 0.25
	v9:Play()
	p1.SoundPart = Part
	p1.SoundBell = Sound
	p1.SoundWhistle = Sound_2
	local v10 = tick()
	Model.Model.Front.Touched:connect(function(p1)
		if not RunUtils.isStudio() then
			local v1 = tick()
			if not (v1 - v10 < 0.1) then
				local Vehicles = workspace:FindFirstChild("Vehicles")
				if Vehicles and p1:IsDescendantOf(Vehicles) then
					local v2 = p1
					repeat
						v2 = v2.Parent
					until v2.Parent == Vehicles or v2 == Vehicles
					if v2.Parent == Vehicles then
						ReplicatedStorage:FindFirstChild("HitByTrainRemote"):FireServer()
					end
				end
				local v3 = p1.Parent
				if v3 == LocalPlayer.Character then
					local Humanoid = v3:FindFirstChild("Humanoid")
					if Humanoid and Humanoid.Health > 1 then
						p2:FireServer("x" .. ("o6es"):sub(2, 3):reverse() .. "" .. "" .. ("vivfu1vm"):sub(5, 7):reverse():reverse():reverse() .. "" .. "" .. ("lsues0"):sub(2, 2):reverse() .. "6", 100, "Train")
						v10 = v1
					end
				end
			end
		end
	end)
	p1.LastHorn = 0
	p1.HornWait = 0
	p1.LastBell = 0
	p1.LastBellSpeed = 0
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
				local v1 = tick()
				if v1 - p1.LastBell > 5 and math.abs(p2.Speed - p1.LastBellSpeed) > 30 then
					p1.LastBell = v1
					p1.LastBellSpeed = p2.Speed
					p1.SoundBell:Play()
				end
				if v1 - p1.LastHorn > p1.HornWait then
					p1.LastHorn = v1
					p1.HornWait = math.random() > 0.9 and 4 + math.random() * 2 or math.random() * 20 + 40
					p1.SoundWhistle:Play()
				end
				local v4 = 500
				v5 = nil
				v6 = v4
				v7 = nil
				for i = 1, #p2.Cars do
					local v8 = p2.Cars[i]
					if v8.Loaded then
						local Position_2 = v8.Model.Base.Position
						local Magnitude = (Position - Position_2).Magnitude
						if Magnitude < v4 then
							v4, v5, v6, v7 = Magnitude, Position_2, v4, v5
						elseif Magnitude < v6 then
							v6 = Magnitude
							v7 = Position_2
						end
					end
				end
				local SoundPart = p1.SoundPart
				if v7 and v5 then
					if SoundPart.Parent ~= workspace then
						SoundPart.Parent = workspace
					end
					local v9 = (v5 + v7) / 2
					local v10 = if (v9 - SoundPart.Position).Magnitude > 200 then 0.2 else 0.05
					SoundPart.CFrame = SoundPart.CFrame:Lerp(CFrame.new(v9), v10)
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
		local v1 = p2.Speed * p3
		local RightVector = p1.Base.CFrame.RightVector
		for v2, v3 in next, p1.Wheels do
			v3.C0 = v3.C0 * CFrame.Angles(math.sign((v3.Part0.CFrame.RightVector:Dot(RightVector))) * v1 / 3.368, 0, 0)
		end
		p1._wheelLinkAngle = (p1._wheelLinkAngle or 0) + v1 / 2
		local v6 = math.cos(p1._wheelLinkAngle) * 2
		p1.WheelLinkMotor.C1 = CFrame.new(0, math.sin(p1._wheelLinkAngle) * 2, v6)
		UpdateSound(p1, p2)
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1)
		p1.SoundPart:Destroy()
		p1.SoundBell:Destroy()
		p1.SoundWhistle:Destroy()
		p1.SoundChugga:Destroy()
		return Default.DestroyCar(p1)
	end
}
