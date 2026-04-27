local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Promise = require(ReplicatedStorage.Std.Promise)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioPlayer = require(script.Parent.RadioPlayer)
local RadioUtils = require(script.Parent.RadioUtils)
local RadioList = {}
RadioList.__index = RadioList
function RadioList.new(guiObject)
	assert(guiObject)
	local instance = {}
	setmetatable(instance, RadioList)
	instance.Gui = guiObject
	instance.Maid = Maid.new()
	instance.OnRefreshRequested = Signal.new()
	instance.Maid:GiveTask(instance.OnRefreshRequested)
	instance.ListItem = {}
	return instance
end
function RadioList.Populate(self, playlist)
	assert(playlist)
	local ScrollingFrame = self.Gui.Container.Sidebar.ScrollingFrame
	self.Maid:GiveTask(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
	end))
	for i, song in ipairs(playlist.Songs) do
		local itemClone = ScrollingFrame.ItemPreset:Clone()
		itemClone.Name = song.AssetId
		local songName = song.Name
		if not songName then
			songName = tostring(song.AssetId)
		end
		itemClone.Title.Text = songName
		if song.Name == nil then
			local namePromise = nil
			namePromise = Promise.resolve():andThen(function()
				return MarketplaceService:GetProductInfo(song.AssetId)
			end):andThen(function(productInfo)
				song.Name = tostring(productInfo.Name)
				itemClone.Title.Text = song.Name
			end):finally(function()
				if namePromise then
					namePromise:cancel()
				end
			end)
			self.Maid:GiveTask(function()
				if namePromise then
					namePromise:cancel()
				end
			end)
		end
		itemClone.Visible = true
		itemClone.Parent = ScrollingFrame
		itemClone.LayoutOrder = i
		self.Maid:GiveTask(itemClone.Play.MouseButton1Down:Connect(function()
			local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
			local isThirdPerson = RadioPlayer.IsPlayingThirdPerson()
			if not isThirdPerson then
				isThirdPerson = if vehiclePacket == nil then false else not vehiclePacket.Passenger
			end
			RadioPlayer.PlayId(song.AssetId, nil, isThirdPerson)
		end))
		itemClone.Delete.Visible = playlist.Editable
		if playlist.Editable then
			self.Maid:GiveTask(itemClone.Delete.MouseButton1Down:Connect(function()
				table.remove(playlist.Songs, i)
				self.OnRefreshRequested:Fire()
				RadioPlayer.OnPlaylistUpdated:Fire(playlist)
			end))
		end
		self.Maid:GiveTask(itemClone)
		local isListLengthValid = #self.ListItem == i - 1
		assert(isListLengthValid)
		table.insert(self.ListItem, itemClone)
	end
	if playlist.Editable then
		ScrollingFrame.NewSong.LayoutOrder = #playlist.Songs + 1
		self.Maid:GiveTask(ScrollingFrame.NewSong.Add.MouseButton1Down:Connect(function()
			if RadioPlayer.CurrentSound == nil then
				error("Attempted to add song when no song is playing!")
			end
			local CurrentSoundId = RadioPlayer.CurrentSoundId
			for i, song in ipairs(playlist.Songs) do
				if song.AssetId == CurrentSoundId then
					error("Attempted to add repeat song to playlist.")
				end
			end
			if not RadioUtils.CheckOrPromptStereoGamepass() then
				return false
			end
			table.insert(playlist.Songs, {
				AssetId = CurrentSoundId
			})
			self.OnRefreshRequested:Fire()
			RadioPlayer.OnPlaylistUpdated:Fire(playlist)
		end))
	end
	ScrollingFrame.NewSong.Visible = playlist.Editable
end
function RadioList.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return RadioList
