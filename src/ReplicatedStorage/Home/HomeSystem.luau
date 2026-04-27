local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeBinder = require(script.Parent.HomeBinder)
local HomeSystem = {
	_currentStandingHome = nil,
	onEntered = Signal.new(),
	onExited = Signal.new()
}
function HomeSystem.init()
	HomeBinder:Start()
	Interval.every(0.25):Connect(function()
		local rootPart = HomeSystem.queryCurrentStandingHome()
		if HomeSystem._currentStandingHome ~= rootPart then
			local previousStandingHome = HomeSystem._currentStandingHome
			HomeSystem._currentStandingHome = rootPart
			if rootPart then
				HomeSystem.onEntered:Fire(rootPart)
				return
			end
			HomeSystem.onExited:Fire(previousStandingHome)
		end
	end)
end
function HomeSystem.queryCurrentStandingHome()
	local rootPart = PlayerUtils.getRootPart(LocalPlayer)
	if rootPart then
		local rootPartPosition = rootPart.Position
		for i, home in ipairs(HomeBinder:GetAll()) do
			if home:IsPointInStandingPrism(rootPartPosition) then
				return home
			end
		end
	end
end
return HomeSystem
