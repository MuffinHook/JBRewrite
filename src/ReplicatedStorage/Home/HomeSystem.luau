-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeBinder = require(script.Parent.HomeBinder)
local t = {
	_currentStandingHome = nil,
	onEntered = Signal.new(),
	onExited = Signal.new()
}
function t.init()
	HomeBinder:Start()
	Interval.every(0.25):Connect(function()
		local localPlayer = t.queryCurrentStandingHome()
		if t._currentStandingHome ~= localPlayer then
			local _currentStandingHome = t._currentStandingHome
			t._currentStandingHome = localPlayer
			if localPlayer then
				t.onEntered:Fire(localPlayer)
				return
			end
			t.onExited:Fire(_currentStandingHome)
		end
	end)
end
function t.queryCurrentStandingHome()
	local localPlayer = PlayerUtils.getRootPart(LocalPlayer)
	if localPlayer then
		local Position = localPlayer.Position
		for i, v in ipairs(HomeBinder:GetAll()) do
			if v:IsPointInStandingPrism(Position) then
				return v
			end
		end
	end
end
return t
