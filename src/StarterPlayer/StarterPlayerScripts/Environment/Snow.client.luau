-- Reviewed by Claude
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
	local v1 = Maid.new()
	for v2, v3 in DefaultSnow:GetChildren() do
		if v3:IsA("BasePart") then
			v3.CanCollide = false
			v3.CanTouch = false
			v3.CanQuery = false
		end
	end
	local function StartSnow()
		DefaultSnow.Parent = workspace
		v1:GiveTask(function()
			DefaultSnow.Parent = ReplicatedStorage.Resource
		end)
		local v12 = Vector3.new(0, 0, 0)
		local v2 = 0
		v1:GiveTask(RunService.Heartbeat:Connect(function(p1)
			debug.profilebegin("snow Update")
			v2 = v2 + p1
			if v2 > 0.2 then
				v2 = 0
			end
			local v1 = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart
			if v1 then
				v12 = v1.Position + v1.Velocity * Vector3.new(1, 0, 1)
			end
			if v2 == 0 then
				local v22 = RaycastParams.new()
				v22.FilterDescendantsInstances = {
					workspace.Vehicles,
					LocalPlayer.Character,
					DefaultSnow,
					workspace:FindFirstChild("Clouds")
				}
				local v3 = Raycast.collidable(v12, Vector3.new(0, 1, 0), 100, v22) ~= nil
				if DefaultSnow.RainFall.Rain.Enabled == true and v3 then
					DefaultSnow.RainFall.Rain:Clear()
				end
				DefaultSnow.RainFall.Rain.Enabled = not v3
			end
			if DefaultSnow.RainFall.Rain.Enabled then
				DefaultSnow.RainFall.Position = v12 + Vector3.new(0, 37, 0)
			end
			debug.profileend()
		end))
	end
	local function UpdateSnowCheck()
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			v1:Destroy()
			return false
		else
			StartSnow()
			return true
		end
	end
	EnvironmentUtils.getPrecipitationChangedSignal():Connect(function()
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			v1:Destroy()
		else
			StartSnow()
		end
	end)
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		v1:Destroy()
	else
		StartSnow()
	end
end
