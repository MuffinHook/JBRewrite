local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Default = require(script.Parent.Default)
local function MakeSound(p1, p2) --[[ Line: 7 ]]
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. tostring(p2)
	Sound.Volume = 0.25
	Sound.RollOffMaxDistance = 768
	Sound.RollOffMinDistance = 16
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = p1
	return Sound
end
local function MakeCar(p1, p2) --[[ Line: 18 | Upvalues: RunUtils (copy), ReplicatedStorage (copy), LocalPlayer (copy), Default (copy) ]]
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
	local v1 = Sound_2
	v1.Looped = true
	v1:Play()
	local Sound_3 = Instance.new("Sound")
	Sound_3.SoundId = "rbxassetid://" .. tostring(10563992041)
	Sound_3.Volume = 0.25
	Sound_3.RollOffMaxDistance = 768
	Sound_3.RollOffMinDistance = 16
	Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound_3.Parent = Part
	local v2 = Sound_3
	v2.Looped = true
	v2:Play()
	p1.SoundPart = Part
	p1.SoundHorn = Sound
	local v3 = tick()
	Model.Model.Front.Touched:connect(function(p1) --[[ Line: 38 | Upvalues: RunUtils (ref), v3 (ref), ReplicatedStorage (ref), LocalPlayer (ref), p2 (copy) ]]
		if not RunUtils.isStudio() then
			local v1 = tick()
			if not (v1 - v3 < 0.1) then
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
				local v32 = p1.Parent
				if v32 == LocalPlayer.Character then
					local Humanoid = v32:FindFirstChild("Humanoid")
					if Humanoid and Humanoid.Health > 1 then
						p2:FireServer("x" .. ("b1v6eb1nt"):sub(2, 5):reverse() .. "us6", 100, "Train")
						v3 = v1
					end
				end
			end
		end
	end)
	p1.LastHorn = 0
	p1.HornWait = 0
	return Default.MakeCar(p1)
end
local function UpdateSound(p1, p2) --[[ Line: 74 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local Position = RootPart.Position
				local v1 = tick()
				if v1 - p1.LastHorn > p1.HornWait then
					p1.LastHorn = v1
					p1.HornWait = math.random() > 0.9 and 4 + math.random() * 2 or math.random() * 20 + 40
					p1.SoundHorn:Play()
				end
				local v3 = 500
				v4 = nil
				v5 = v3
				v6 = nil
				for i = 1, #p2.Cars do
					local v7 = p2.Cars[i]
					if v7.Loaded then
						local Position_2 = v7.Model.Base.Position
						local Magnitude = (Position - Position_2).Magnitude
						if Magnitude < v3 then
							v3, v4, v5, v6 = Magnitude, Position_2, v3, v4
						elseif Magnitude < v5 then
							v5 = Magnitude
							v6 = Position_2
						end
					end
				end
				local SoundPart = p1.SoundPart
				if v6 and v4 then
					if SoundPart.Parent ~= workspace then
						SoundPart.Parent = workspace
					end
					local v8 = (v4 + v6) / 2
					local v9 = if (v8 - SoundPart.Position).Magnitude > 200 then 0.2 else 0.05
					SoundPart.CFrame = SoundPart.CFrame:Lerp(CFrame.new(v8), v9)
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
	MoveCar = function(p1, p2, p3, p4) --[[ Name: MoveCar | Line: 125 | Upvalues: UpdateSound (copy), Default (copy) ]]
		local Speed = p2.Speed
		UpdateSound(p1, p2)
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1) --[[ Name: DestroyCar | Line: 131 | Upvalues: Default (copy) ]]
		p1.SoundPart:Destroy()
		p1.SoundHorn:Destroy()
		return Default.DestroyCar(p1)
	end
}