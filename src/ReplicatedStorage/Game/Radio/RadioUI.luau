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
function RadioUI.ConnectPlayer(self)
	local Player = self.Gui.Container.Player
	local TextBox = Player.Left.SongId.TextBox
	self.Maid:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		if TextBox.Text:find("%D+") then
			TextBox.Text = TextBox.Text:gsub("%D+", "")
		end
	end))
	self.Maid:GiveTask(Player.Left.Toggle.MouseButton1Down:Connect(function()
		if RadioPlayer.IsPlaying() then
			self:StopSong()
		else
			self:PlayCustomSong()
		end
	end))
	self.Maid:GiveTask(RadioPlayer.OnSongStarted:Connect(function()
		self:UpdatePlayButton()
	end))
	self.Maid:GiveTask(RadioPlayer.OnSongStopped:Connect(function()
		self:UpdatePlayButton()
	end))
	self.Maid:GiveTask(RadioPlayer.OnSongEnded:Connect(function()
		self:UpdatePlayButton()
	end))
	local bassSlider = Slider.new(Player.Right.SliderBass)
	self.Maid:GiveTask(bassSlider)
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
	self.Maid:GiveTask(volumeSlider)
end
function RadioUI.ConnectStations(self)
	for i, stationFrame in ipairs(self.Gui.Container.Stations.ContainerStations:GetChildren()) do
		if stationFrame:IsA("Frame") then
			self.Maid:GiveTask(stationFrame.Button.MouseButton1Down:Connect(function()
				RadioConfig.Playlist = stationFrame.Name
				RadioPlayer.PlayRandomSongAfter = true
				RadioPlayer.PlayRandomSong()
				self:OpenSidebar(RadioConfig.Playlist)
			end))
		end
	end
	if RadioConfig.Playlist then
		self:OpenSidebar(RadioConfig.Playlist)
	end
end
function RadioUI.OpenSidebar(self, playlistName)
	if self.mRadioList ~= nil then
		self.mRadioList:Destroy()
		self.mRadioList = nil
	end
	self.mRadioList = RadioList.new(self.Gui)
	self.mRadioList:Populate(RadioPlayer.GetPlaylist(playlistName))
	self.mRadioList.Maid:GiveTask(self.mRadioList.OnRefreshRequested:Connect(function()
		self:OpenSidebar(playlistName)
	end))
end
function RadioUI.StopSong(self)
	RadioPlayer.Stop()
end
function RadioUI.PlayCustomSong(self)
	local songId = tonumber(self.Gui.Container.Player.Left.SongId.TextBox.Text)
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
function RadioUI.UpdatePlayButton(self)
	self.Gui.Container.Player.Left.Toggle.TextLabel.Text = if RadioPlayer.IsPlaying() then "PAUSE" else "PLAY"
end
function RadioUI.Destroy(self)
	self.Gui.Enabled = false
	self.Gui = nil
	if self.mRadioList then
		self.mRadioList:Destroy()
		self.mRadioList = nil
	end
	self.Maid:Destroy()
	self.Maid = nil
end
return RadioUI
