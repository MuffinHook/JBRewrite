-- Reviewed by Claude
-- variables reassigned
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Promise = require(ReplicatedStorage.Std.Promise)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioPlayer = require(script.Parent.RadioPlayer)
local RadioUtils = require(script.Parent.RadioUtils)
local t = {}
t.__index = t
function t.new(guiObject)
	assert(guiObject)
	local instance = {}
	setmetatable(instance, t)
	instance.Gui = guiObject
	instance.Maid = Maid.new()
	instance.OnRefreshRequested = Signal.new()
	instance.Maid:GiveTask(instance.OnRefreshRequested)
	instance.ListItem = {}
	return instance
end
function t.Populate(self, playlist)
	assert(playlist)
	local ScrollingFrame = self.Gui.Container.Sidebar.ScrollingFrame
	self.Maid:GiveTask(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
	end))
	for i, v in ipairs(playlist.Songs) do
		local itemVariable
		local itemClone = ScrollingFrame.ItemPreset:Clone()
		itemClone.Name = v.AssetId
		local songName = v.Name
		if not songName then
			songName = tostring(v.AssetId)
		end
		itemClone.Title.Text = songName
		if v.Name == nil then
			local namePromise = nil
			namePromise = Promise.resolve():andThen(function()
				return MarketplaceService:GetProductInfo(v.AssetId)
			end):andThen(function(p1)
				v.Name = tostring(p1.Name)
				itemClone.Title.Text = v.Name
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
			RadioPlayer.PlayId(v.AssetId, nil, isThirdPerson)
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
		itemVariable = #self.ListItem == i - 1
		assert(itemVariable)
		table.insert(self.ListItem, itemClone)
	end
	if playlist.Editable then
		ScrollingFrame.NewSong.LayoutOrder = #playlist.Songs + 1
		self.Maid:GiveTask(ScrollingFrame.NewSong.Add.MouseButton1Down:Connect(function()
			if RadioPlayer.CurrentSound == nil then
				error("Attempted to add song when no song is playing!")
			end
			local CurrentSoundId = RadioPlayer.CurrentSoundId
			for i, v in ipairs(playlist.Songs) do
				if v.AssetId == CurrentSoundId then
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
function t.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return t
