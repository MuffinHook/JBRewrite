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
local v1 = nil
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
function t.Init(p1) --[[ Line: 33 | Upvalues: v1 (ref), VehicleUtils (copy), t (copy) ]]
	v1 = p1.Event
	VehicleUtils.OnVehicleEntered:Connect(function() --[[ Line: 37 | Upvalues: t (ref) ]]
		if t.IsPlaying() then
			t.PlayId(t.CurrentSoundId, t.CurrentSound.TimePosition, true)
		end
	end)
	local v12 = os.clock()
	VehicleUtils.OnVehicleJumpExited:Connect(function() --[[ Line: 43 | Upvalues: t (ref), v12 (ref) ]]
		if t.IsPlayingThirdPerson() and os.clock() - v12 > 0.5 then
			v12 = os.clock()
			t.PlayId(t.CurrentSoundId, t.CurrentSound.TimePosition, false)
		end
	end)
	t.OnPlaylistUpdated:Connect(function(p1) --[[ Line: 52 | Upvalues: v1 (ref) ]]
		if p1.Persist then
			v1:FireServer("h" .. ("jay3z3ismwn"):sub(5, 10):reverse():reverse():reverse():reverse():reverse() .. "1", p1.Title, p1.Songs)
		end
	end)
	function p1.em.gc0vlr85(p1) --[[ Line: 58 | Upvalues: t (ref) ]]
		for k, v in pairs(p1) do
			t.GetPlaylist(k).Songs = v
		end
	end
end
function t.PlayId(p1, p2, p3) --[[ Line: 65 | Upvalues: RadioUtils (copy), MarketplaceService (copy), t (copy), RadioConfig (copy), VehicleUtils (copy), v1 (ref), Audio (copy), LocalPlayer (copy), Music (copy) ]]
	assert(p1)
	assert(type(p1) == "number")
	assert(p1 > 0)
	if p3 and not RadioUtils.HasSteroGamepass() then
		print("Requested third person, but no gamepass....")
		p3 = false
	end
	if MarketplaceService:GetProductInfo(p1).AssetTypeId ~= Enum.AssetType.Audio.Value then
		error(("AssetId `%d` is not a valid audio asset."):format(p1))
	end
	t.Stop()
	t.CurrentSoundId = p1
	local v3
	if p3 then
		local v4 = VehicleUtils.GetLocalVehiclePacket()
		assert(v4)
		v3 = v4.RadioSound
		assert(v3)
		v3.Volume = 0
		v1:FireServer("h" .. ("dfukmba4x"):sub(3, 5):reverse():reverse():reverse() .. "" .. "" .. ("cuuoj4"):sub(4, 4):reverse() .. "d8p", p1, p2)
	else
		local v5 = Audio.ObjectLocal(LocalPlayer, p1, {
			DoNotPlay = true,
			Volume = 0
		})
		if p2 ~= nil then
			v5.TimePosition = p2
		end
		v3 = v5
	end
	t.CurrentSound = v3
	t.Maid.EndedConn = v3.Ended:Connect(function() --[[ Line: 101 | Upvalues: t (ref) ]]
		t.Stop()
		t.OnSongEnded:Fire()
	end)
	v3.SoundGroup = Music
	v3.PlaybackSpeed = RadioConfig.PlaybackSpeed
	if not p3 then
		task.spawn(v3.Play, v3)
	end
	t.Maid.FadeInConn = Audio.FadeTo(v3, RadioConfig.Volume, 1, function() --[[ Line: 111 | Upvalues: t (ref) ]]
		t.Maid.FadeInConn = nil
	end)
	RadioConfig.MapSoundIdPlays[p1] = t.GetPlays(p1) + 1
	t.OnSongStarted:Fire(p1)
end
function t.PlayRandomSong() --[[ Line: 117 | Upvalues: t (copy), RadioConfig (copy), Math (copy), VehicleUtils (copy) ]]
	local Songs = t.GetPlaylist(RadioConfig.Playlist).Songs
	local v1 = assert(Songs)
	if #v1 ~= 0 then
		local list = {}
		for i, v in ipairs(v1) do
			list[i] = t.GetPlays(v.AssetId)
		end
		local v3 = math.min(unpack(list))
		local t2 = {}
		for i, v in ipairs(list) do
			local v4
			v4 = if v <= v3 then 1 else 0
			t2[i] = v4
		end
		local v5 = v1[Math.WeightedRandom(t2)]
		local v6 = VehicleUtils.GetLocalVehiclePacket()
		local v8 = t.IsPlayingThirdPerson()
		if not v8 then
			v8 = if v6 == nil then false else not v6.Passenger
		end
		t.PlayId(v5.AssetId, nil, v8)
	end
end
function t.GetPlaylist(p1) --[[ Line: 142 | Upvalues: t (copy) ]]
	if not t.CacheMapNamePlaylist[p1] then
		t.CacheMapNamePlaylist[p1] = require(script.Parent.PlaylistData[p1])
	end
	return t.CacheMapNamePlaylist[p1]
end
function t.GetPlays(p1) --[[ Line: 149 | Upvalues: RadioConfig (copy) ]]
	return RadioConfig.MapSoundIdPlays[p1] or 0
end
function t.SetVolume(p1) --[[ Line: 152 | Upvalues: t (copy) ]]
	if t.IsPlaying() then
		t.CurrentSound.Volume = p1
	end
end
function t.SetBass(p1) --[[ Line: 157 | Upvalues: Music (copy) ]]
	local v1 = 1 - p1
	local v2 = 1 - v1
	Music.EqualizerSoundEffect.LowGain = v1 * -5 + v2 * 5
	Music.EqualizerSoundEffect.MidGain = v2 * -1.5 + v1 * 1.5
	Music.EqualizerSoundEffect.HighGain = v2 * -1.5 + v1 * 1.5
end
function t.Stop() --[[ Line: 173 | Upvalues: t (copy), v1 (ref), Audio (copy) ]]
	t.Maid.FadeInConn = nil
	if t.CurrentSound ~= nil then
		t.CurrentSoundId = nil
		local CurrentSound = t.CurrentSound
		t.CurrentSound = nil
		if CurrentSound:IsDescendantOf(workspace) then
			v1:FireServer("y" .. ("rky9ixk"):sub(4, 4):reverse() .. "" .. "" .. ("lr38h"):sub(3, 4):reverse():reverse():reverse() .. "xui6")
		else
			Audio.FadeTo(CurrentSound, 0, 1, function() --[[ Line: 182 | Upvalues: CurrentSound (copy) ]]
				CurrentSound:Destroy()
			end)
		end
		t.OnSongStopped:Fire()
	end
end
function t.IsPlaying() --[[ Line: 189 | Upvalues: t (copy) ]]
	return t.CurrentSound ~= nil
end
function t.IsPlayingThirdPerson() --[[ Line: 192 | Upvalues: t (copy) ]]
	return t.IsPlaying() and t.CurrentSound:IsDescendantOf(workspace)
end
return t