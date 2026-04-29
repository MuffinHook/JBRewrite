local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local function Preload(audioIds)
	local soundsToPreload = {}
	for _, soundId in next, audioIds do
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://" .. soundId
		table.insert(soundsToPreload, Sound)
	end
	task.spawn(function()
		ContentProvider:PreloadAsync(soundsToPreload)
		for _, sound in next, soundsToPreload do
			sound:Destroy()
		end
	end)
	return true
end
local function PreloadHash(audioIdsHash)
	local audioIdsList = {}
	for _, soundId in next, audioIdsHash do
		table.insert(audioIdsList, soundId)
	end
	return Preload(audioIdsList)
end
local function ObjectLocal(sourceObject, soundId, options)
	assert(sourceObject, "SourceObject cannot be nil")
	assert(typeof(sourceObject) == "Instance", "SourceObject must be an Instance")
	if sourceObject:IsDescendantOf(workspace) and not (sourceObject:IsA("BasePart") or sourceObject:IsA("Attachment")) then
		warn("SourceObject should be a BasePart or Attachment, but was a: " .. sourceObject.ClassName .. " (Name: " .. sourceObject:GetFullName() .. ")")
	end
	local Sound = Instance.new("Sound")
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.RollOffMaxDistance = 512
	if type(soundId) == "number" then
		Sound.SoundId = "rbxassetid://" .. soundId
	else
		Sound.SoundId = soundId
	end
	Sound.Name = tostring(soundId)
	local maxPlaybackTime = nil
	local shouldNotPlay = false
	if options then
		if options.Volume then
			Sound.Volume = options.Volume
		end
		if options.Pitch then
			Sound.PlaybackSpeed = options.Pitch
		end
		if options.TimePosition then
			Sound.TimePosition = options.TimePosition
		end
		if options.EmitterSize then
			Sound.EmitterSize = options.EmitterSize
		end
		if options.MaxDistance then
			Sound.MaxDistance = options.MaxDistance
		end
		if options.RollOffMode then
			Sound.RollOffMode = options.RollOffMode
		end
		if options.RollOffMinDistance then
			Sound.RollOffMinDistance = options.RollOffMinDistance
		end
		if options.RollOffMaxDistance then
			Sound.RollOffMaxDistance = options.RollOffMaxDistance
		end
		if options.Looped then
			Sound.Looped = true
		end
		if options.MaxPlaybackTime then
			maxPlaybackTime = options.MaxPlaybackTime
		end
		if options.DoNotPlay then
			shouldNotPlay = true
		end
		if options.Group then
			Sound.SoundGroup = options.Group
		end
		if options.SoundGroup then
			Sound.SoundGroup = options.SoundGroup
		end
		if options.GroupName then
			Sound.SoundGroup = game:GetService("SoundService"):FindFirstChild(options.GroupName)
		end
		if options.SoundGroupName then
			Sound.SoundGroup = game:GetService("SoundService"):FindFirstChild(options.SoundGroupName)
		end
	end
	Sound.Parent = sourceObject
	if options and (options.YieldForLoaded and not Sound.IsLoaded) then
		Sound.Loaded:Wait()
	end
	if not shouldNotPlay then
		Sound:Play()
		if not Sound.Looped then
			task.spawn(function()
				local delayDuration = maxPlaybackTime
				if delayDuration == nil then
					if not Sound.IsLoaded then
						Sound.Loaded:Wait()
					end
					delayDuration = Sound.TimeLength + 1
				end
				game:GetService("Debris"):AddItem(Sound, delayDuration)
			end)
		end
	end
	return Sound
end
local function WorldPositionLocal(position, soundId, options)
	local SoundPart = Instance.new("Part")
	SoundPart.Anchored = true
	SoundPart.CanCollide = false
	SoundPart.Size = Vector3.new(0.1, 0.1, 0.1)
	SoundPart.Position = position
	SoundPart.Transparency = 1
	SoundPart.Name = "SoundPart"
	SoundPart.Parent = workspace
	return ObjectLocal(SoundPart, soundId, options)
end
local function FadeOut(sound, fadeDuration)
	task.spawn(function()
		local Volume = sound.Volume
		for i = 1, 0, -0.03 / fadeDuration do
			sound.Volume = Volume * i
			task.wait()
		end
		sound.Volume = 0
	end)
end
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
return {
	ObjectLocal = ObjectLocal,
	WorldPositionLocal = WorldPositionLocal,
	Preload = Preload,
	PreloadHash = PreloadHash,
	FadeOut = FadeOut,
	FadeTo = function(sound, targetVolume, fadeDuration, onComplete)
		assert(sound)
		assert(targetVolume)
		assert(fadeDuration)
		local Volume = sound.Volume
		local startTime = tick()
		local connection = nil
		connection = RunService.Heartbeat:Connect(function()
			if sound.Parent == nil then
				connection:Disconnect()
			else
				local progress = (tick() - startTime) / fadeDuration
				if progress >= 1 then
					connection:Disconnect()
					progress = 1
				end
				local easedProgress, _
				if progress < 0.5 then
					easedProgress = 2 * progress * progress
					if not easedProgress then
						_ = progress
						easedProgress = -1 - 2 * (progress - 2) * progress
					end
				else
					_ = progress
					easedProgress = -1 - 2 * (progress - 2) * progress
				end
				sound.Volume = Volume * (1 - easedProgress) + targetVolume * easedProgress
				if easedProgress == 1 and onComplete ~= nil then
					onComplete()
				end
			end
		end)
		return connection
	end,
	promiseFadeTo = function(sound, targetVolume, fadeDuration)
		assert(sound)
		assert(targetVolume)
		assert(fadeDuration)
		local startTime = os.clock()
		return Promise.new(function(resolve, reject, onCancel)
			local maid = Maid.new()
			if not onCancel(function()
				maid:Destroy()
				maid = nil
			end) then
				local Volume = sound.Volume
				maid:GiveTask(RunService.Heartbeat:Connect(function()
					local progress = (os.clock() - startTime) / fadeDuration
					if progress >= 1 then
						progress = 1
					end
					local easedProgress, _
					if progress < 0.5 then
						easedProgress = 2 * progress * progress
						if not easedProgress then
							_ = progress
							easedProgress = -1 - 2 * (progress - 2) * progress
						end
					else
						_ = progress
						easedProgress = -1 - 2 * (progress - 2) * progress
					end
					if sound.Parent then
						sound.Volume = Volume * (1 - easedProgress) + targetVolume * easedProgress
						if easedProgress == 1 then
							maid:Destroy()
							resolve()
						end
					else
						maid:Destroy()
						reject("No Parent to sound")
					end
				end))
			end
		end)
	end
}
