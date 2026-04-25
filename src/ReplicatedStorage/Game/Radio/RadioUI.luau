-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RadioConfig = require(script.Parent.RadioConfig)
local RadioList = require(script.Parent.RadioList)
local RadioPlayer = require(script.Parent.RadioPlayer)
local RadioUtils = require(script.Parent.RadioUtils)
local Slider = require(script.Parent.Slider)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioUI = {}
RadioUI.__index = RadioUI
function RadioUI.new(guiElement)
	assert(guiElement)
	local radioUiInstance = {}
	setmetatable(radioUiInstance, RadioUI)
	radioUiInstance.Gui = guiElement
	radioUiInstance.Maid = Maid.new()
	radioUiInstance:ConnectPlayer()
	radioUiInstance:ConnectStations()
	radioUiInstance.Gui.Enabled = true
	return radioUiInstance
end
function RadioUI.ConnectPlayer(p1)
	local Player = p1.Gui.Container.Player
	local TextBox = Player.Left.SongId.TextBox
	p1.Maid:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		if TextBox.Text:find("%D+") then
			TextBox.Text = TextBox.Text:gsub("%D+", "")
		end
	end))
	p1.Maid:GiveTask(Player.Left.Toggle.MouseButton1Down:Connect(function()
		if RadioPlayer.IsPlaying() then
			p1:StopSong()
		else
			p1:PlayCustomSong()
		end
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongStarted:Connect(function()
		p1:UpdatePlayButton()
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongStopped:Connect(function()
		p1:UpdatePlayButton()
	end))
	p1.Maid:GiveTask(RadioPlayer.OnSongEnded:Connect(function()
		p1:UpdatePlayButton()
	end))
	local bassSlider = Slider.new(Player.Right.SliderBass)
	p1.Maid:GiveTask(bassSlider)
	bassSlider.OnValueChanged:Connect(function(bassValue)
		RadioConfig.Bass = bassValue
		RadioPlayer.SetBass(bassValue)
	end)
	bassSlider:SetValue(RadioConfig.Bass)
	local volumeSlider = Slider.new(Player.Right.SliderVolume)
	volumeSlider.OnValueChanged:Connect(function(volumeValue)
		RadioConfig.Volume = volumeValue
		RadioPlayer.SetVolume(volumeValue)
	end)
	volumeSlider:SetValue(RadioConfig.Volume)
	p1.Maid:GiveTask(volumeSlider)
end
function RadioUI.ConnectStations(p1)
	for i, v in ipairs(p1.Gui.Container.Stations.ContainerStations:GetChildren()) do
		if v:IsA("Frame") then
			p1.Maid:GiveTask(v.Button.MouseButton1Down:Connect(function()
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
function RadioUI.OpenSidebar(p1, p2)
	if p1.mRadioList ~= nil then
		p1.mRadioList:Destroy()
		p1.mRadioList = nil
	end
	p1.mRadioList = RadioList.new(p1.Gui)
	p1.mRadioList:Populate(RadioPlayer.GetPlaylist(p2))
	p1.mRadioList.Maid:GiveTask(p1.mRadioList.OnRefreshRequested:Connect(function()
		p1:OpenSidebar(p2)
	end))
end
function RadioUI.StopSong(p1)
	RadioPlayer.Stop()
end
function RadioUI.PlayCustomSong(p1)
	local songId = tonumber(p1.Gui.Container.Player.Left.SongId.TextBox.Text)
	if songId == nil and RadioConfig.Playlist ~= nil then
		RadioPlayer.PlayRandomSongAfter = true
		RadioPlayer.PlayRandomSong()
	else
		assert(songId)
		if not RadioUtils.CheckOrPromptStereoGamepass() then
			return false
		end
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		RadioPlayer.PlayRandomSongAfter = true
		local isThirdPerson = RadioPlayer.IsPlayingThirdPerson()
		if not isThirdPerson then
			isThirdPerson = if vehiclePacket == nil then false else not vehiclePacket.Passenger
		end
		RadioPlayer.PlayId(songId, nil, isThirdPerson)
	end
end
function RadioUI.UpdatePlayButton(p1)
	p1.Gui.Container.Player.Left.Toggle.TextLabel.Text = if RadioPlayer.IsPlaying() then "PAUSE" else "PLAY"
end
function RadioUI.Destroy(p1)
	p1.Gui.Enabled = false
	p1.Gui = nil
	if p1.mRadioList then
		p1.mRadioList:Destroy()
		p1.mRadioList = nil
	end
	p1.Maid:Destroy()
	p1.Maid = nil
end
return RadioUI
