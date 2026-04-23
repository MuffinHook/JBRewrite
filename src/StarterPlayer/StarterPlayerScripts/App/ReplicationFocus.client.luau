local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local RunService = game:GetService("RunService")
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local v1 = workspace:WaitForChild("_FocusParts"):WaitForChild(Players.LocalPlayer.Name)
v1.Anchored = true
local SetReplicationFocusOverride = ReplicatedStorage:WaitForChild("SetReplicationFocusOverride")
local v2 = Maid.new()
local function Update(p1) --[[ Line: 16 | Upvalues: v2 (copy), v1 (copy), RunService (copy), Promise (copy), SetReplicationFocusOverride (copy) ]]
	v2:DoCleaning()
	if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable or p1 then
		v1.Anchored = false
		v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 20 | Upvalues: v1 (ref) ]]
			local Position = workspace.CurrentCamera.CFrame.Position
			if Position.Y < -50 then
				Position = Position + Vector3.new(0, -50 - Position.Y, 0)
			end
			v1.Position = Position
		end))
		v2:GivePromise(Promise.delay(1):andThen(function() --[[ Line: 32 | Upvalues: SetReplicationFocusOverride (ref) ]]
			SetReplicationFocusOverride:FireServer(true)
		end))
	else
		SetReplicationFocusOverride:FireServer(false)
		v2:GivePromise(Promise.delay(1):andThen(function() --[[ Line: 37 | Upvalues: v1 (ref) ]]
			v1.Position = Vector3.new(0, 500, 0)
			v1.Anchored = true
		end))
	end
end
RxInstanceUtils.observeProperty(workspace.CurrentCamera, "CameraType", function(p1) --[[ Line: 45 | Upvalues: Update (copy) ]]
	Update()
end)
RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "Freecam", function(p1) --[[ Line: 49 | Upvalues: RxInstanceUtils (copy), Update (copy) ]]
	local FreecamScript = p1:WaitForChild("FreecamScript")
	RxInstanceUtils.observeAttribute(FreecamScript, "FreecamEnabled", Update)
end)