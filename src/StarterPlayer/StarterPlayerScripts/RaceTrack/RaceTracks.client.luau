local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Maid = require(ReplicatedStorage.Std.Maid)
local Binder = require(ReplicatedStorage.Std.Binder)
local Promise = require(ReplicatedStorage.Std.Promise)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Board = require(ReplicatedStorage.RaceTrack.UI.Board)
local TrackService = require(ReplicatedStorage.RaceTrack.TrackService)
RxInstanceUtils.waitForChild(ReplicatedStorage, "RaceTrackScreenText"):andThen(function(self)
	local screenTextPromise = nil
	self.OnClientEvent:Connect(function(self)
		TrackService.updateScreenText(self)
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6874682609, {
			Volume = 0.8
		})
		if screenTextPromise then
			screenTextPromise:cancel()
			screenTextPromise = nil
		end
		screenTextPromise = Promise.delay(3):andThen(function()
			TrackService.updateScreenText("")
		end)
	end)
end)
local BoardComponent = Roact.PureComponent:extend("Board")
function BoardComponent.init(self)
	self._maid = Maid.new()
end
function BoardComponent._fetch(self)
	self:setState({
		numEntries = #self.props.dataFolder:GetChildren()
	})
end
function BoardComponent.didMount(self)
	self:_fetch()
	self._maid:GiveTask(self.props.dataFolder.ChildAdded:Connect(function()
		self:_fetch()
	end))
	self._maid:GiveTask(self.props.dataFolder.ChildRemoved:Connect(function()
		self:_fetch()
	end))
end
function BoardComponent.render(self)
	local configTable = {}
	for i, entryInstance in ipairs(self.props.dataFolder:GetChildren()) do
		local isValidTime
		local raceTime = entryInstance:GetAttribute("Time")
		isValidTime = typeof(raceTime) == "number"
		assert(isValidTime, "time was not a number")
		local minutes = math.floor(raceTime % 3600000 / 60000)
		local seconds = math.floor(raceTime % 60000 / 1000)
		local milliseconds = math.floor(raceTime % 1000)
		local entryConfig = {
			name = entryInstance.Value
		}
		entryConfig.userId = tonumber(entryInstance.Name)
		entryConfig.time = raceTime
		entryConfig.message = ("%d:%02d.%03d"):format(minutes, seconds, milliseconds)
		table.insert(configTable, entryConfig)
	end
	table.sort(configTable, function(self, otherEntry)
		return self.time < otherEntry.time
	end)
	return createElement("SurfaceGui", {
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
		PixelsPerStud = 80,
		Adornee = self.props.adornee
	}, {
		Board = createElement(Board, {
			entries = configTable
		})
	})
end
function BoardComponent.willUnmount(self)
	self._maid:DoCleaning()
end
local BoardBinder = {}
BoardBinder.__index = BoardBinder
function BoardBinder.new(self)
	local binderInstance = {}
	setmetatable(binderInstance, BoardBinder)
	binderInstance._maid = Maid.new()
	binderInstance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self.Parent.Parent, "Data", function(dataFolder, maidTask)
		local mountedComponent = Roact.mount(createElement(BoardComponent, {
			adornee = self,
			dataFolder = dataFolder
		}), Players.LocalPlayer.PlayerGui, "BoardGui")
		maidTask:GiveTask(function()
			Roact.unmount(mountedComponent)
		end)
	end))
	return binderInstance
end
function BoardBinder.Destroy(self)
	self._maid:Destroy()
end
Binder.new("RaceTrackBoard", BoardBinder):Start()
