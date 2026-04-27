local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local RunService = game:GetService("RunService")
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local localPlayer = workspace:WaitForChild("_FocusParts"):WaitForChild(Players.LocalPlayer.Name)
localPlayer.Anchored = true
local SetReplicationFocusOverride = ReplicatedStorage:WaitForChild("SetReplicationFocusOverride")
local cleanupMaid = Maid.new()
local function Update(forceScriptableMode)
	cleanupMaid:DoCleaning()
	if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable or forceScriptableMode then
		localPlayer.Anchored = false
		cleanupMaid:GiveTask(RunService.Heartbeat:Connect(function()
			local Position = workspace.CurrentCamera.CFrame.Position
			if Position.Y < -50 then
				Position = Position + Vector3.new(0, -50 - Position.Y, 0)
			end
			localPlayer.Position = Position
		end))
		cleanupMaid:GivePromise(Promise.delay(1):andThen(function()
			SetReplicationFocusOverride:FireServer(true)
		end))
	else
		SetReplicationFocusOverride:FireServer(false)
		cleanupMaid:GivePromise(Promise.delay(1):andThen(function()
			localPlayer.Position = Vector3.new(0, 500, 0)
			localPlayer.Anchored = true
		end))
	end
end
RxInstanceUtils.observeProperty(workspace.CurrentCamera, "CameraType", function(cameraType)
	Update()
end)
RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "Freecam", function(freecamGui)
	local FreecamScript = freecamGui:WaitForChild("FreecamScript")
	RxInstanceUtils.observeAttribute(FreecamScript, "FreecamEnabled", Update)
end)
