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
		local v1 = t.queryCurrentStandingHome()
		if t._currentStandingHome ~= v1 then
			local _currentStandingHome = t._currentStandingHome
			t._currentStandingHome = v1
			if v1 then
				t.onEntered:Fire(v1)
				return
			end
			t.onExited:Fire(_currentStandingHome)
		end
	end)
end
function t.queryCurrentStandingHome()
	local v1 = PlayerUtils.getRootPart(LocalPlayer)
	if v1 then
		local Position = v1.Position
		for i, v in ipairs(HomeBinder:GetAll()) do
			if v:IsPointInStandingPrism(Position) then
				return v
			end
		end
	end
end
return t
