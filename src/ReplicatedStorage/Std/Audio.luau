-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local function Preload(p1)
	local t = {}
	for v1, v2 in next, p1 do
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://" .. v2
		table.insert(t, Sound)
	end
	spawn(function()
		ContentProvider:PreloadAsync(t)
		for v1, v2 in next, t do
			v2:Destroy()
		end
	end)
	return true
end
local function PreloadHash(p1)
	local t = {}
	for v1, v2 in next, p1 do
		table.insert(t, v2)
	end
	return Preload(t)
end
local function ObjectLocal(p1, p2, p3)
	assert(p1, "SourceObject cannot be nil")
	assert(typeof(p1) == "Instance", "SourceObject must be an Instance")
	if p1:IsDescendantOf(workspace) and not (p1:IsA("BasePart") or p1:IsA("Attachment")) then
		warn("SourceObject should be a BasePart or Attachment, but was a: " .. p1.ClassName .. " (Name: " .. p1:GetFullName() .. ")")
	end
	local Sound = Instance.new("Sound")
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.RollOffMaxDistance = 512
	if type(p2) == "number" then
		Sound.SoundId = "rbxassetid://" .. p2
	else
		Sound.SoundId = p2
	end
	Sound.Name = tostring(p2)
	local v2 = nil
	local v3 = false
	if p3 then
		if p3.Volume then
			Sound.Volume = p3.Volume
		end
		if p3.Pitch then
			Sound.PlaybackSpeed = p3.Pitch
		end
		if p3.TimePosition then
			Sound.TimePosition = p3.TimePosition
		end
		if p3.EmitterSize then
			Sound.EmitterSize = p3.EmitterSize
		end
		if p3.MaxDistance then
			Sound.MaxDistance = p3.MaxDistance
		end
		if p3.RollOffMode then
			Sound.RollOffMode = p3.RollOffMode
		end
		if p3.RollOffMinDistance then
			Sound.RollOffMinDistance = p3.RollOffMinDistance
		end
		if p3.RollOffMaxDistance then
			Sound.RollOffMaxDistance = p3.RollOffMaxDistance
		end
		if p3.Looped then
			Sound.Looped = true
		end
		if p3.MaxPlaybackTime then
			v2 = p3.MaxPlaybackTime
		end
		if p3.DoNotPlay then
			v3 = true
		end
		if p3.Group then
			Sound.SoundGroup = p3.Group
		end
		if p3.SoundGroup then
			Sound.SoundGroup = p3.SoundGroup
		end
		if p3.GroupName then
			Sound.SoundGroup = game:GetService("SoundService"):FindFirstChild(p3.GroupName)
		end
		if p3.SoundGroupName then
			Sound.SoundGroup = game:GetService("SoundService"):FindFirstChild(p3.SoundGroupName)
		end
	end
	Sound.Parent = p1
	if p3 and (p3.YieldForLoaded and not Sound.IsLoaded) then
		Sound.Loaded:Wait()
	end
	if not v3 then
		Sound:Play()
		if not Sound.Looped then
			task.spawn(function()
				local v1 = v2
				if v1 == nil then
					if not Sound.IsLoaded then
						Sound.Loaded:Wait()
					end
					v1 = Sound.TimeLength + 1
				end
				game:GetService("Debris"):AddItem(Sound, v1)
			end)
		end
	end
	return Sound
end
local function WorldPositionLocal(p1, p2, p3)
	local SoundPart = Instance.new("Part")
	SoundPart.Anchored = true
	SoundPart.CanCollide = false
	SoundPart.Size = Vector3.new(0.1, 0.1, 0.1)
	SoundPart.Position = p1
	SoundPart.Transparency = 1
	SoundPart.Name = "SoundPart"
	SoundPart.Parent = workspace
	return ObjectLocal(SoundPart, p2, p3)
end
local function FadeOut(p1, p2)
	spawn(function()
		local Volume = p1.Volume
		for i = 1, 0, -0.03 / p2 do
			p1.Volume = Volume * i
			wait()
		end
		p1.Volume = 0
	end)
end
local function Ease_InOutQuad(p1)
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
return {
	ObjectLocal = ObjectLocal,
	WorldPositionLocal = WorldPositionLocal,
	Preload = Preload,
	PreloadHash = PreloadHash,
	FadeOut = FadeOut,
	FadeTo = function(p1, p2, p3, p4)
		assert(p1)
		assert(p2)
		assert(p3)
		local Volume = p1.Volume
		local v1 = tick()
		local v2 = nil
		v2 = RunService.Heartbeat:Connect(function()
			if p1.Parent == nil then
				v2:Disconnect()
			else
				local v12 = (tick() - v1) / p3
				if v12 >= 1 then
					v2:Disconnect()
					v12 = 1
				end
				local v22, v3
				if v12 < 0.5 then
					v22 = 2 * v12 * v12
					if not v22 then
						v3 = v12
						v22 = -1 - 2 * (v12 - 2) * v12
					end
				else
					v3 = v12
					v22 = -1 - 2 * (v12 - 2) * v12
				end
				p1.Volume = Volume * (1 - v22) + p2 * v22
				if v22 == 1 and p4 ~= nil then
					p4()
				end
			end
		end)
		return v2
	end,
	promiseFadeTo = function(p1, p2, p3)
		assert(p1)
		assert(p2)
		assert(p3)
		local v1 = os.clock()
		return Promise.new(function(p12, p22, p32)
			local v12 = Maid.new()
			if not p32(function()
				v12:Destroy()
				v12 = nil
			end) then
				local Volume = p1.Volume
				v12:GiveTask(RunService.Heartbeat:Connect(function()
					local v13 = (os.clock() - v1) / p3
					if v13 >= 1 then
						v13 = 1
					end
					local v2, v3
					if v13 < 0.5 then
						v2 = 2 * v13 * v13
						if not v2 then
							v3 = v13
							v2 = -1 - 2 * (v13 - 2) * v13
						end
					else
						v3 = v13
						v2 = -1 - 2 * (v13 - 2) * v13
					end
					if p1.Parent then
						p1.Volume = Volume * (1 - v2) + p2 * v2
						if v2 == 1 then
							v12:Destroy()
							p12()
						end
					else
						v12:Destroy()
						p22("No Parent to sound")
					end
				end))
			end
		end)
	end
}
