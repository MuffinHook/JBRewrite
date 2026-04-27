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
	local function Heartbeat(elapsedTime)
		local currentTime = tick()
		local rotationAngle = CFrame.Angles(0, 0.3 * elapsedTime, 0)
		local Disco = partyModel:FindFirstChild("Disco")
		if Disco then
			local iterNext = next
			local discoChildren, discoChildIndex = partyModel:GetChildren()
			for childIndex, child in iterNext, discoChildren, discoChildIndex do
				if child.Name == "Laser" then
					child.CFrame = Disco.CFrame:toWorldSpace(rotationAngle * Disco.CFrame:toObjectSpace(child.CFrame))
				end
			end
			Disco.CFrame = Disco.CFrame * rotationAngle
			Disco:FindFirstChild("Music").SoundGroup = SoundService.Music
		end
		local Cloud = partyModel:FindFirstChild("Cloud")
		if Cloud then
			local discoColor = Color3.fromHSV(math.cos(currentTime * 0.1) * 0.5 + 0.5, 1, 1)
			local cloudIterator = next
			local cloudChildren, cloudChildIndex = Cloud:GetChildren()
			for decalIndex, decal in cloudIterator, cloudChildren, cloudChildIndex do
				if decal:IsA("Decal") then
					decal.Color3 = discoColor
				end
			end
		end
		if currentTime - heartbeatCheckpoint > 0.5 then
			heartbeatCheckpoint = currentTime
			local SmallDanceFloor = partyModel:FindFirstChild("SmallDanceFloor")
			if SmallDanceFloor then
				local danceFloorIterator = next
				local danceFloorChildren, danceFloorChildIndex = SmallDanceFloor:GetChildren()
				for colorIndex, colorPart in danceFloorIterator, danceFloorChildren, danceFloorChildIndex do
					if colorPart.Name == "Color" then
						colorPart.Transparency = math.random() * 0.35 + 0.1
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
local function AddedFun(partyTheme)
	partyModel = partyTheme
	PartyStart()
end
local function RemovedFun(partyTheme)
	assert(partyActive)
	partyActive = false
	maidCleaner:Destroy()
	animationTrack:Stop()
	animationTrack:Destroy()
	animationTrack = nil
	partyModel = nil
end
return {
	Init = function(initConfig)
		fireworksCallback = initConfig.Fireworks
		local tagsIterator = next
		local taggedModels, taggedModelIndex = CollectionService:GetTagged("PartyThemeModel")
		for modelIndex, model in tagsIterator, taggedModels, taggedModelIndex do
			partyModel = model
			PartyStart()
		end
		CollectionService:GetInstanceAddedSignal("PartyThemeModel"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("PartyThemeModel"):Connect(RemovedFun)
	end
}
