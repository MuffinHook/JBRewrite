-- Reviewed by Claude
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
function t.new(p1)
	assert(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.Gui = p1
	t2.Maid = Maid.new()
	t2.OnRefreshRequested = Signal.new()
	t2.Maid:GiveTask(t2.OnRefreshRequested)
	t2.ListItem = {}
	return t2
end
function t.Populate(p1, p2)
	assert(p2)
	local ScrollingFrame = p1.Gui.Container.Sidebar.ScrollingFrame
	p1.Maid:GiveTask(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
	end))
	for i, v in ipairs(p2.Songs) do
		local v1
		local v2 = ScrollingFrame.ItemPreset:Clone()
		v2.Name = v.AssetId
		local v3 = v.Name
		if not v3 then
			v3 = tostring(v.AssetId)
		end
		v2.Title.Text = v3
		if v.Name == nil then
			local v4 = nil
			v4 = Promise.resolve():andThen(function()
				return MarketplaceService:GetProductInfo(v.AssetId)
			end):andThen(function(p1)
				v.Name = tostring(p1.Name)
				v2.Title.Text = v.Name
			end):finally(function()
				if v4 then
					v4:cancel()
				end
			end)
			p1.Maid:GiveTask(function()
				if v4 then
					v4:cancel()
				end
			end)
		end
		v2.Visible = true
		v2.Parent = ScrollingFrame
		v2.LayoutOrder = i
		p1.Maid:GiveTask(v2.Play.MouseButton1Down:Connect(function()
			local v1 = VehicleUtils.GetLocalVehiclePacket()
			local v3 = RadioPlayer.IsPlayingThirdPerson()
			if not v3 then
				v3 = if v1 == nil then false else not v1.Passenger
			end
			RadioPlayer.PlayId(v.AssetId, nil, v3)
		end))
		v2.Delete.Visible = p2.Editable
		if p2.Editable then
			p1.Maid:GiveTask(v2.Delete.MouseButton1Down:Connect(function()
				table.remove(p2.Songs, i)
				p1.OnRefreshRequested:Fire()
				RadioPlayer.OnPlaylistUpdated:Fire(p2)
			end))
		end
		p1.Maid:GiveTask(v2)
		v1 = #p1.ListItem == i - 1
		assert(v1)
		table.insert(p1.ListItem, v2)
	end
	if p2.Editable then
		ScrollingFrame.NewSong.LayoutOrder = #p2.Songs + 1
		p1.Maid:GiveTask(ScrollingFrame.NewSong.Add.MouseButton1Down:Connect(function()
			if RadioPlayer.CurrentSound == nil then
				error("Attempted to add song when no song is playing!")
			end
			local CurrentSoundId = RadioPlayer.CurrentSoundId
			for i, v in ipairs(p2.Songs) do
				if v.AssetId == CurrentSoundId then
					error("Attempted to add repeat song to playlist.")
				end
			end
			if not RadioUtils.CheckOrPromptStereoGamepass() then
				return false
			end
			table.insert(p2.Songs, {
				AssetId = CurrentSoundId
			})
			p1.OnRefreshRequested:Fire()
			RadioPlayer.OnPlaylistUpdated:Fire(p2)
		end))
	end
	ScrollingFrame.NewSong.Visible = p2.Editable
end
function t.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
