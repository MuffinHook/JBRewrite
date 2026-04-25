-- Reviewed by Claude
-- variables reassigned
local SoundService = game:GetService("SoundService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://3066265539"
local animationTrack = nil
local fireworksCallback = nil
local maidCleaner = Maid.new()
local partyModel = nil
local partyActive = false
local function PartyStart()
	assert(not partyActive)
	partyActive = true
	local heartbeatCheckpoint = tick()
	local secondCheckpoint = tick()
	local function Heartbeat(p1)
		local currentTime = tick()
		local v23 = CFrame.Angles(0, 0.3 * p1, 0)
		local Disco = partyModel:FindFirstChild("Disco")
		if Disco then
			local iterNext = next
			local v42, v5 = partyModel:GetChildren()
			for v6, v7 in iterNext, v42, v5 do
				if v7.Name == "Laser" then
					v7.CFrame = Disco.CFrame:toWorldSpace(v23 * Disco.CFrame:toObjectSpace(v7.CFrame))
				end
			end
			Disco.CFrame = Disco.CFrame * v23
			Disco:FindFirstChild("Music").SoundGroup = SoundService.Music
		end
		local Cloud = partyModel:FindFirstChild("Cloud")
		if Cloud then
			local discoColor = Color3.fromHSV(math.cos(currentTime * 0.1) * 0.5 + 0.5, 1, 1)
			local v9 = next
			local v10, v11 = Cloud:GetChildren()
			for v12, v13 in v9, v10, v11 do
				if v13:IsA("Decal") then
					v13.Color3 = discoColor
				end
			end
		end
		if currentTime - heartbeatCheckpoint > 0.5 then
			heartbeatCheckpoint = currentTime
			local SmallDanceFloor = partyModel:FindFirstChild("SmallDanceFloor")
			if SmallDanceFloor then
				local v14 = next
				local v15, v16 = SmallDanceFloor:GetChildren()
				for v17, v18 in v14, v15, v16 do
					if v18.Name == "Color" then
						v18.Transparency = math.random() * 0.35 + 0.1
					end
				end
			end
		end
		if currentTime - secondCheckpoint > 1 then
			secondCheckpoint = currentTime
			fireworksCallback(1)
		end
	end
	maidCleaner.Runtime = RunService.Heartbeat:Connect(Heartbeat)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			animationTrack = Humanoid:LoadAnimation(Animation)
			animationTrack:Play()
		end
	end
end
local function PartyEnd()
	assert(partyActive)
	partyActive = false
	maidCleaner:Destroy()
	animationTrack:Stop()
	animationTrack:Destroy()
	animationTrack = nil
end
local function AddedFun(p1)
	partyModel = p1
	PartyStart()
end
local function RemovedFun(p1)
	assert(partyActive)
	partyActive = false
	maidCleaner:Destroy()
	animationTrack:Stop()
	animationTrack:Destroy()
	animationTrack = nil
	partyModel = nil
end
return {
	Init = function(p1)
		fireworksCallback = p1.Fireworks
		local v1 = next
		local v22, v3 = CollectionService:GetTagged("PartyThemeModel")
		for v42, v5 in v1, v22, v3 do
			partyModel = v5
			PartyStart()
		end
		CollectionService:GetInstanceAddedSignal("PartyThemeModel"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("PartyThemeModel"):Connect(RemovedFun)
	end
}
