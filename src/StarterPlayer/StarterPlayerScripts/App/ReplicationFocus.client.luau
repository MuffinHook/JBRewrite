local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local SOME_upvr = workspace:WaitForChild("_FocusParts"):WaitForChild(Players.LocalPlayer.Name)
SOME_upvr.Anchored = true
local any_new_result1_upvr = require(ReplicatedStorage.Std.Maid).new()
local RunService_upvr = game:GetService("RunService")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local SetReplicationFocusOverride_upvr = ReplicatedStorage:WaitForChild("SetReplicationFocusOverride")
local function Update_upvr(arg1) -- Line 16, Named "Update"
    any_new_result1_upvr:DoCleaning()
    if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable or arg1 then
        SOME_upvr.Anchored = false
        any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 20
            local Position = workspace.CurrentCamera.CFrame.Position
            if Position.Y < -50 then
                Position += Vector3.new(0, -50 - Position.Y, 0)
            end
            SOME_upvr.Position = Position
        end))
        any_new_result1_upvr:GivePromise(Promise_upvr.delay(1):andThen(function() -- Line 32
            SetReplicationFocusOverride_upvr:FireServer(true)
        end))
    else
        SetReplicationFocusOverride_upvr:FireServer(false)
        any_new_result1_upvr:GivePromise(Promise_upvr.delay(1):andThen(function() -- Line 37
            SOME_upvr.Position = Vector3.new(0, 500, 0)
            SOME_upvr.Anchored = true
        end))
    end
end
RxInstanceUtils_upvr.observeProperty(workspace.CurrentCamera, "CameraType", function(arg1) -- Line 45
    Update_upvr()
end)
RxInstanceUtils_upvr.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "Freecam", function(arg1) -- Line 49
    RxInstanceUtils_upvr.observeAttribute(arg1:WaitForChild("FreecamScript"), "FreecamEnabled", Update_upvr)
end)