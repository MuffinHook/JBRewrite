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
RxInstanceUtils.waitForChild(ReplicatedStorage, "RaceTrackScreenText"):andThen(function(p1) --[[ Line: 14 | Upvalues: TrackService (copy), Audio (copy), Players (copy), Promise (copy) ]]
	local v1 = nil
	p1.OnClientEvent:Connect(function(p1) --[[ Line: 16 | Upvalues: TrackService (ref), Audio (ref), Players (ref), v1 (ref), Promise (ref) ]]
		TrackService.updateScreenText(p1)
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6874682609, {
			Volume = 0.8
		})
		if v1 then
			v1:cancel()
			v1 = nil
		end
		v1 = Promise.delay(3):andThen(function() --[[ Line: 24 | Upvalues: TrackService (ref) ]]
			TrackService.updateScreenText("")
		end)
	end)
end)
local v1 = Roact.PureComponent:extend("Board")
function v1.init(p1) --[[ Line: 31 | Upvalues: Maid (copy) ]]
	p1._maid = Maid.new()
end
function v1._fetch(p1) --[[ Line: 34 ]]
	p1:setState({
		numEntries = #p1.props.dataFolder:GetChildren()
	})
end
function v1.didMount(p1) --[[ Line: 39 ]]
	p1:_fetch()
	p1._maid:GiveTask(p1.props.dataFolder.ChildAdded:Connect(function() --[[ Line: 41 | Upvalues: p1 (copy) ]]
		p1:_fetch()
	end))
	p1._maid:GiveTask(p1.props.dataFolder.ChildRemoved:Connect(function() --[[ Line: 44 | Upvalues: p1 (copy) ]]
		p1:_fetch()
	end))
end
function v1.render(p1) --[[ Line: 48 | Upvalues: createElement (copy), Board (copy) ]]
	local t = {}
	for i, v in ipairs(p1.props.dataFolder:GetChildren()) do
		local v1
		local v2 = v:GetAttribute("Time")
		v1 = typeof(v2) == "number"
		assert(v1, "time was not a number")
		local v3 = math.floor(v2 % 3600000 / 60000)
		local v4 = math.floor(v2 % 60000 / 1000)
		local v5 = math.floor(v2 % 1000)
		local t2 = {
			name = v.Value
		}
		t2.userId = tonumber(v.Name)
		t2.time = v2
		t2.message = ("%d:%02d.%03d"):format(v3, v4, v5)
		table.insert(t, t2)
	end
	table.sort(t, function(p1, p2) --[[ Line: 64 ]]
		return p1.time < p2.time
	end)
	return createElement("SurfaceGui", {
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
		PixelsPerStud = 80,
		Adornee = p1.props.adornee
	}, {
		Board = createElement(Board, {
			entries = t
		})
	})
end
function v1.willUnmount(p1) --[[ Line: 79 ]]
	p1._maid:DoCleaning()
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 86 | Upvalues: t (copy), Maid (copy), RxInstanceUtils (copy), Roact (copy), createElement (copy), v1 (copy), Players (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1.Parent.Parent, "Data", function(p12, p2) --[[ Line: 91 | Upvalues: Roact (ref), createElement (ref), v1 (ref), p1 (copy), Players (ref) ]]
		local v12 = Roact.mount(createElement(v1, {
			adornee = p1,
			dataFolder = p12
		}), Players.LocalPlayer.PlayerGui, "BoardGui")
		p2:GiveTask(function() --[[ Line: 101 | Upvalues: Roact (ref), v12 (copy) ]]
			Roact.unmount(v12)
		end)
	end))
	return t2
end
function t.Destroy(p1) --[[ Line: 108 ]]
	p1._maid:Destroy()
end
Binder.new("RaceTrackBoard", t):Start()