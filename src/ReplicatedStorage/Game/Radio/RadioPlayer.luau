local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Math = require(ReplicatedStorage.Module.Math)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioConfig = require(script.Parent.RadioConfig)
local RadioUtils = require(script.Parent.RadioUtils)
local Music = SoundService:FindFirstChild("Music")
local radioEvent = nil
local t = {
	CacheMapNamePlaylist = {},
	CurrentSound = nil,
	CurrentSoundId = nil,
	FadeInConn = nil,
	PlayRandomSongAfter = true,
	Maid = Maid.new(),
	OnSongStarted = Signal.new(),
	OnSongStopped = Signal.new(),
	OnSongEnded = Signal.new(),
	OnPlaylistUpdated = Signal.new()
}
function t.Init(initConfig)
	radioEvent = initConfig.Event
	VehicleUtils.OnVehicleEntered:Connect(function()
		if t.IsPlaying() then
			t.PlayId(t.CurrentSoundId, t.CurrentSound.TimePosition, true)
		end
	end)
	local lastJumpExitTime = os.clock()
	VehicleUtils.OnVehicleJumpExited:Connect(function()
		if t.IsPlayingThirdPerson() and os.clock() - lastJumpExitTime > 0.5 then
			lastJumpExitTime = os.clock()
			t.PlayId(t.CurrentSoundId, t.CurrentSound.TimePosition, false)
		end
	end)
	t.OnPlaylistUpdated:Connect(function(playlistUpdate)
		if playlistUpdate.Persist then
			radioEvent:FireServer("hwmsi3z1", playlistUpdate.Title, playlistUpdate.Songs)
		end
	end)
	function initConfig.em.gc0vlr85(playlistsTable)
		for playlistName, songsList in pairs(playlistsTable) do
			t.GetPlaylist(playlistName).Songs = songsList
		end
	end
end
function t.PlayId(soundId, timePosition, isThirdPerson)
	assert(soundId)
	assert(type(soundId) == "number")
	assert(soundId > 0)
	if isThirdPerson and not RadioUtils.HasSteroGamepass() then
		print("Requested third person, but no gamepass....")
		isThirdPerson = false
	end
	if MarketplaceService:GetProductInfo(soundId).AssetTypeId ~= Enum.AssetType.Audio.Value then
		error(("AssetId `%d` is not a valid audio asset."):format(soundId))
	end
	t.Stop()
	t.CurrentSoundId = soundId
	local sound
	if isThirdPerson then
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		assert(vehiclePacket)
		sound = vehiclePacket.RadioSound
		assert(sound)
		sound.Volume = 0
		radioEvent:FireServer("hmkuod8p", soundId, timePosition)
	else
		local audioObject = Audio.ObjectLocal(LocalPlayer, soundId, {
			DoNotPlay = true,
			Volume = 0
		})
		if timePosition ~= nil then
			audioObject.TimePosition = timePosition
		end
		sound = audioObject
	end
	t.CurrentSound = sound
	t.Maid.EndedConn = sound.Ended:Connect(function()
		t.Stop()
		t.OnSongEnded:Fire()
	end)
	sound.SoundGroup = Music
	sound.PlaybackSpeed = RadioConfig.PlaybackSpeed
	if not isThirdPerson then
		task.spawn(sound.Play, sound)
	end
	t.Maid.FadeInConn = Audio.FadeTo(sound, RadioConfig.Volume, 1, function()
		t.Maid.FadeInConn = nil
	end)
	RadioConfig.MapSoundIdPlays[soundId] = t.GetPlays(soundId) + 1
	t.OnSongStarted:Fire(soundId)
end
function t.PlayRandomSong()
	local Songs = t.GetPlaylist(RadioConfig.Playlist).Songs
	local songsList = assert(Songs)
	if #songsList ~= 0 then
		local list = {}
		for index, song in ipairs(songsList) do
			list[index] = t.GetPlays(song.AssetId)
		end
		local minPlays = math.min(unpack(list))
		local weights = {}
		for index, playCount in ipairs(list) do
			local weight
			weight = if playCount <= minPlays then 1 else 0
			weights[index] = weight
		end
		local selectedSong = songsList[Math.WeightedRandom(weights)]
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		local playThirdPerson = t.IsPlayingThirdPerson()
		if not playThirdPerson then
			playThirdPerson = if vehiclePacket == nil then false else not vehiclePacket.Passenger
		end
		t.PlayId(selectedSong.AssetId, nil, playThirdPerson)
	end
end
function t.GetPlaylist(playlistName)
	if not t.CacheMapNamePlaylist[playlistName] then
		t.CacheMapNamePlaylist[playlistName] = require(script.Parent.PlaylistData[playlistName])
	end
	return t.CacheMapNamePlaylist[playlistName]
end
function t.GetPlays(soundId)
	return RadioConfig.MapSoundIdPlays[soundId] or 0
end
function t.SetVolume(volume)
	if t.IsPlaying() then
		t.CurrentSound.Volume = volume
	end
end
function t.SetBass(bassLevel)
	local bassReduction = 1 - bassLevel
	local bassAmplification = 1 - bassReduction
	Music.EqualizerSoundEffect.LowGain = bassReduction * -5 + bassAmplification * 5
	Music.EqualizerSoundEffect.MidGain = bassAmplification * -1.5 + bassReduction * 1.5
	Music.EqualizerSoundEffect.HighGain = bassAmplification * -1.5 + bassReduction * 1.5
end
function t.Stop()
	t.Maid.FadeInConn = nil
	if t.CurrentSound ~= nil then
		t.CurrentSoundId = nil
		local CurrentSound = t.CurrentSound
		t.CurrentSound = nil
		if CurrentSound:IsDescendantOf(workspace) then
			radioEvent:FireServer("y983xui6")
		else
			Audio.FadeTo(CurrentSound, 0, 1, function()
				CurrentSound:Destroy()
			end)
		end
		t.OnSongStopped:Fire()
	end
end
function t.IsPlaying()
	return t.CurrentSound ~= nil
end
function t.IsPlayingThirdPerson()
	return t.IsPlaying() and t.CurrentSound:IsDescendantOf(workspace)
end
return t
