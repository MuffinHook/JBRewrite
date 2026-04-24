-- Reviewed by Claude
local SoundService = game:GetService("SoundService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://3066265539"
local v1 = nil
local v2 = nil
local v3 = Maid.new()
local v4 = nil
local v5 = false
local function PartyStart()
	assert(not v5)
	v5 = true
	local v22 = tick()
	local v32 = tick()
	local function Heartbeat(p1)
		local v1 = tick()
		local v23 = CFrame.Angles(0, 0.3 * p1, 0)
		local Disco = v4:FindFirstChild("Disco")
		if Disco then
			local v3 = next
			local v42, v5 = v4:GetChildren()
			for v6, v7 in v3, v42, v5 do
				if v7.Name == "Laser" then
					v7.CFrame = Disco.CFrame:toWorldSpace(v23 * Disco.CFrame:toObjectSpace(v7.CFrame))
				end
			end
			Disco.CFrame = Disco.CFrame * v23
			Disco:FindFirstChild("Music").SoundGroup = SoundService.Music
		end
		local Cloud = v4:FindFirstChild("Cloud")
		if Cloud then
			local v8 = Color3.fromHSV(math.cos(v1 * 0.1) * 0.5 + 0.5, 1, 1)
			local v9 = next
			local v10, v11 = Cloud:GetChildren()
			for v12, v13 in v9, v10, v11 do
				if v13:IsA("Decal") then
					v13.Color3 = v8
				end
			end
		end
		if v1 - v22 > 0.5 then
			v22 = v1
			local SmallDanceFloor = v4:FindFirstChild("SmallDanceFloor")
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
		if v1 - v32 > 1 then
			v32 = v1
			v2(1)
		end
	end
	v3.Runtime = RunService.Heartbeat:Connect(Heartbeat)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			v1 = Humanoid:LoadAnimation(Animation)
			v1:Play()
		end
	end
end
local function PartyEnd()
	assert(v5)
	v5 = false
	v3:Destroy()
	v1:Stop()
	v1:Destroy()
	v1 = nil
end
local function AddedFun(p1)
	v4 = p1
	PartyStart()
end
local function RemovedFun(p1)
	assert(v5)
	v5 = false
	v3:Destroy()
	v1:Stop()
	v1:Destroy()
	v1 = nil
	v4 = nil
end
return {
	Init = function(p1)
		v2 = p1.Fireworks
		local v1 = next
		local v22, v3 = CollectionService:GetTagged("PartyThemeModel")
		for v42, v5 in v1, v22, v3 do
			v4 = v5
			PartyStart()
		end
		CollectionService:GetInstanceAddedSignal("PartyThemeModel"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("PartyThemeModel"):Connect(RemovedFun)
	end
}
