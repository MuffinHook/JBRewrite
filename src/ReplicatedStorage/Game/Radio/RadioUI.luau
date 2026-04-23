local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RadioConfig = require(script.Parent.RadioConfig)
local RadioList = require(script.Parent.RadioList)
local RadioPlayer = require(script.Parent.RadioPlayer)
local RadioUtils = require(script.Parent.RadioUtils)
local Slider = require(script.Parent.Slider)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 15 | Upvalues: t (copy), Maid (copy) ]]
	assert(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.Gui = p1
	t2.Maid = Maid.new()
	t2:ConnectPlayer()
	t2:ConnectStations()
	t2.Gui.Enabled = true
	return t2
end
function t.ConnectPlayer(p1) --[[ Line: 30 | Upvalues: RadioPlayer (copy), Slider (copy), RadioConfig (copy) ]]
	local Player = p1.Gui.Container.Player
	local TextBox = Player.Left.SongId.TextBox
	p1.Maid:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 34 | Upvalues: TextBox (copy) ]]
		if TextBox.Text:find("%D+") then
			TextBox.Text = TextBox.Text:gsub("%D+", "")
		end
	end))
	p1.Maid:GiveTask(Player.Left.Toggle.MouseButton1Down:Connect(function() --[[ Line: 39 | Upvalues: RadioPlayer (ref), p1 (copy) ]]
		if RadioPlayer.IsPlaying() then
			p1:StopSong()
		else
			p1:PlayCustomSong()
		end
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongStarted:Connect(function() --[[ Line: 46 | Upvalues: p1 (copy) ]]
		p1:UpdatePlayButton()
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongStopped:Connect(function() --[[ Line: 49 | Upvalues: p1 (copy) ]]
		p1:UpdatePlayButton()
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongEnded:Connect(function() --[[ Line: 52 | Upvalues: p1 (copy) ]]
		p1:UpdatePlayButton()
	end))
	local v1 = Slider.new(Player.Right.SliderBass)
	p1.Maid:GiveTask(v1)
	v1.OnValueChanged:Connect(function(p1) --[[ Line: 58 | Upvalues: RadioConfig (ref), RadioPlayer (ref) ]]
		RadioConfig.Bass = p1
		RadioPlayer.SetBass(p1)
	end)
	v1:SetValue(RadioConfig.Bass)
	local v2 = Slider.new(Player.Right.SliderVolume)
	v2.OnValueChanged:Connect(function(p1) --[[ Line: 66 | Upvalues: RadioConfig (ref), RadioPlayer (ref) ]]
		RadioConfig.Volume = p1
		RadioPlayer.SetVolume(p1)
	end)
	v2:SetValue(RadioConfig.Volume)
	p1.Maid:GiveTask(v2)
end
function t.ConnectStations(p1) --[[ Line: 74 | Upvalues: RadioConfig (copy), RadioPlayer (copy) ]]
	for i, v in ipairs(p1.Gui.Container.Stations.ContainerStations:GetChildren()) do
		if v:IsA("Frame") then
			p1.Maid:GiveTask(v.Button.MouseButton1Down:Connect(function() --[[ Line: 79 | Upvalues: v (copy), RadioConfig (ref), RadioPlayer (ref), p1 (copy) ]]
				RadioConfig.Playlist = v.Name
				RadioPlayer.PlayRandomSongAfter = true
				RadioPlayer.PlayRandomSong()
				p1:OpenSidebar(RadioConfig.Playlist)
			end))
		end
	end
	if RadioConfig.Playlist then
		p1:OpenSidebar(RadioConfig.Playlist)
	end
end
function t.OpenSidebar(p1, p2) --[[ Line: 93 | Upvalues: RadioList (copy), RadioPlayer (copy) ]]
	if p1.mRadioList ~= nil then
		p1.mRadioList:Destroy()
		p1.mRadioList = nil
	end
	p1.mRadioList = RadioList.new(p1.Gui)
	p1.mRadioList:Populate(RadioPlayer.GetPlaylist(p2))
	p1.mRadioList.Maid:GiveTask(p1.mRadioList.OnRefreshRequested:Connect(function() --[[ Line: 100 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:OpenSidebar(p2)
	end))
end
function t.StopSong(p1) --[[ Line: 104 | Upvalues: RadioPlayer (copy) ]]
	RadioPlayer.Stop()
end
function t.PlayCustomSong(p1) --[[ Line: 107 | Upvalues: RadioConfig (copy), RadioPlayer (copy), RadioUtils (copy), VehicleUtils (copy) ]]
	local v1 = tonumber(p1.Gui.Container.Player.Left.SongId.TextBox.Text)
	if v1 == nil and RadioConfig.Playlist ~= nil then
		RadioPlayer.PlayRandomSongAfter = true
		RadioPlayer.PlayRandomSong()
	else
		assert(v1)
		if not RadioUtils.CheckOrPromptStereoGamepass() then
			return false
		end
		local v2 = VehicleUtils.GetLocalVehiclePacket()
		RadioPlayer.PlayRandomSongAfter = true
		local v4 = RadioPlayer.IsPlayingThirdPerson()
		if not v4 then
			v4 = if v2 == nil then false else not v2.Passenger
		end
		RadioPlayer.PlayId(v1, nil, v4)
	end
end
function t.UpdatePlayButton(p1) --[[ Line: 131 | Upvalues: RadioPlayer (copy) ]]
	p1.Gui.Container.Player.Left.Toggle.TextLabel.Text = if RadioPlayer.IsPlaying() then "PAUSE" else "PLAY"
end
function t.Destroy(p1) --[[ Line: 136 ]]
	p1.Gui.Enabled = false
	p1.Gui = nil
	if p1.mRadioList then
		p1.mRadioList:Destroy()
		p1.mRadioList = nil
	end
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t