local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.App.RunUtils)
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local EnvironmentUtils = require(ReplicatedStorage.Environment.EnvironmentUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local LocalPlayer = Players.LocalPlayer
if EnvironmentConsts.SNOW then
	local DefaultSnow = ReplicatedStorage.Resource.DefaultSnow
	local snowMaid = Maid.new()
	for index, snowPart in DefaultSnow:GetChildren() do
		if snowPart:IsA("BasePart") then
			snowPart.CanCollide = false
			snowPart.CanTouch = false
			snowPart.CanQuery = false
		end
	end
	local function StartSnow()
		DefaultSnow.Parent = workspace
		snowMaid:GiveTask(function()
			DefaultSnow.Parent = ReplicatedStorage.Resource
		end)
		local targetPosition = Vector3.new(0, 0, 0)
		local timeSinceLastUpdate = 0
		snowMaid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
			debug.profilebegin("snow Update")
			timeSinceLastUpdate = timeSinceLastUpdate + deltaTime
			if timeSinceLastUpdate > 0.2 then
				timeSinceLastUpdate = 0
			end
			local playerCharacterPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart
			if playerCharacterPart then
				targetPosition = playerCharacterPart.Position + playerCharacterPart.Velocity * Vector3.new(1, 0, 1)
			end
			if timeSinceLastUpdate == 0 then
				local raycastParams = RaycastParams.new()
				raycastParams.FilterDescendantsInstances = {
					workspace.Vehicles,
					LocalPlayer.Character,
					DefaultSnow,
					workspace:FindFirstChild("Clouds")
				}
				local isPositionOccluded = Raycast.collidable(targetPosition, Vector3.new(0, 1, 0), 100, raycastParams) ~= nil
				if DefaultSnow.RainFall.Rain.Enabled == true and isPositionOccluded then
					DefaultSnow.RainFall.Rain:Clear()
				end
				DefaultSnow.RainFall.Rain.Enabled = not isPositionOccluded
			end
			if DefaultSnow.RainFall.Rain.Enabled then
				DefaultSnow.RainFall.Position = targetPosition + Vector3.new(0, 37, 0)
			end
			debug.profileend()
		end))
	end
	local function UpdateSnowCheck()
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			snowMaid:Destroy()
			return false
		else
			StartSnow()
			return true
		end
	end
	EnvironmentUtils.getPrecipitationChangedSignal():Connect(function()
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			snowMaid:Destroy()
		else
			StartSnow()
		end
	end)
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		snowMaid:Destroy()
	else
		StartSnow()
	end
end
