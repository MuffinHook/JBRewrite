-- Reviewed by Claude
-- variables reassigned
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
	local v1 = nil
	self.OnClientEvent:Connect(function(self)
		TrackService.updateScreenText(self)
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6874682609, {
			Volume = 0.8
		})
		if v1 then
			v1:cancel()
			v1 = nil
		end
		v1 = Promise.delay(3):andThen(function()
			TrackService.updateScreenText("")
		end)
	end)
end)
local v1 = Roact.PureComponent:extend("Board")
function v1.init(self)
	self._maid = Maid.new()
end
function v1._fetch(self)
	self:setState({
		numEntries = #self.props.dataFolder:GetChildren()
	})
end
function v1.didMount(self)
	self:_fetch()
	self._maid:GiveTask(self.props.dataFolder.ChildAdded:Connect(function()
		self:_fetch()
	end))
	self._maid:GiveTask(self.props.dataFolder.ChildRemoved:Connect(function()
		self:_fetch()
	end))
end
function v1.render(self)
	local configTable = {}
	for i, v in ipairs(self.props.dataFolder:GetChildren()) do
		local v1
		local v2 = v:GetAttribute("Time")
		v1 = typeof(v2) == "number"
		assert(v1, "time was not a number")
		local mathFunc = math.floor(v2 % 3600000 / 60000)
		local mathFunc = math.floor(v2 % 60000 / 1000)
		local mathFunc = math.floor(v2 % 1000)
		local configTable = {
			name = v.Value
		}
		configTable.userId = tonumber(v.Name)
		configTable.time = v2
		configTable.message = ("%d:%02d.%03d"):format(mathFunc, mathFunc, mathFunc)
		table.insert(configTable, configTable)
	end
	table.sort(configTable, function(self, p2)
		return self.time < p2.time
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
function v1.willUnmount(self)
	self._maid:DoCleaning()
end
local configTable = {}
configTable.__index = configTable
function configTable.new(self)
	local configTable = {}
	setmetatable(configTable, configTable)
	configTable._maid = Maid.new()
	configTable._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self.Parent.Parent, "Data", function(p12, p2)
		local var12 = Roact.mount(createElement(v1, {
			adornee = self,
			dataFolder = p12
		}), Players.LocalPlayer.PlayerGui, "BoardGui")
		p2:GiveTask(function()
			Roact.unmount(var12)
		end)
	end))
	return configTable
end
function configTable.Destroy(self)
	self._maid:Destroy()
end
Binder.new("RaceTrackBoard", configTable):Start()
