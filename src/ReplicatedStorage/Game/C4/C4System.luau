-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local Promise = require(ReplicatedStorage.Std.Promise)
local C4Consts = require(script.Parent.C4Consts)
local C4Utils = require(script.Parent.C4Utils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local C4Binder = require(script.Parent.C4Binder)
local CurrentCamera = workspace.CurrentCamera
local t = {}
local emService = nil
local initialized = false
function t.onExplode(p1, p2, p3, p4, p5)
	if initialized then
		if not p3 then
			p3 = 24
		end
		if not p4 then
			p4 = 128
		end
		local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
		local RootPart = Humanoid.RootPart
		local positionDifference = RootPart.Position - p1
		if positionDifference.Magnitude < p2 then
			if Humanoid.SeatPart then
				Humanoid.Jump = true
				task.wait(0.1)
			end
			task.spawn(emService.e9kobedq)
			local cameraFrame = CurrentCamera.CFrame
			local shaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(p1)
				cameraFrame = CurrentCamera.CFrame
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			local heartbeatConnection = RunService.Heartbeat:Connect(function()
				CurrentCamera.CFrame = cameraFrame
			end)
			shaker:Start()
			shaker:Shake(CamShaker.Presets.Explosion)
			Promise.delay(2):andThen(function()
				shaker:Stop()
				heartbeatConnection:Disconnect()
			end)
			if not p5 then
				RootPart:ApplyImpulse(RootPart.AssemblyMass * positionDifference.Unit * ((p4 - p3) * (1 - positionDifference.Magnitude / p2) + p3))
			end
		end
	end
end
function t.init(p1)
	emService = p1.em
	initialized = true
	C4Binder:Start()
	local function hide(p1)
		p1._obj.PrimaryPart.Anchored = true
		p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
	end
	C4Binder:GetClassAddedSignal():Connect(function(p1)
		RxInstanceUtils.yieldForProperty(p1.obj, "PrimaryPart")
		if p1:GetCreator() == LocalPlayer then
			p1._obj.PrimaryPart.Anchored = true
			p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		p1._maid:GiveTask(p1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function()
			if p1:GetCreator() == LocalPlayer then
				local c4Obj = p1
				c4Obj._obj.PrimaryPart.Anchored = true
				c4Obj._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
		end))
	end)
	ReplicatedStorage:FindFirstChild(C4Consts.PLAY_EXPLOSION_REMOTE_NAME).OnClientEvent:Connect(function(p1, p2)
		C4Utils.explosionVisual(p1)
	end)
	ReplicatedStorage:FindFirstChild("C4ExplodedRemote").OnClientEvent:Connect(t.onExplode)
end
return t
