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
local C4System = {}
local emService = nil
local initialized = false
function C4System.onExplode(explosionPosition, explosionRadius, minImpulse, maxImpulse, preventImpulse)
	if initialized then
		if not minImpulse then
			minImpulse = 24
		end
		if not maxImpulse then
			maxImpulse = 128
		end
		local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
		local RootPart = Humanoid.RootPart
		local positionDifference = RootPart.Position - explosionPosition
		if positionDifference.Magnitude < explosionRadius then
			if Humanoid.SeatPart then
				Humanoid.Jump = true
				task.wait(0.1)
			end
			task.spawn(emService.e9kobedq)
			local cameraFrame = CurrentCamera.CFrame
			local shaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(cframeOffset)
				cameraFrame = CurrentCamera.CFrame
				CurrentCamera.CFrame = CurrentCamera.CFrame * cframeOffset
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
			if not preventImpulse then
				RootPart:ApplyImpulse(RootPart.AssemblyMass * positionDifference.Unit * ((maxImpulse - minImpulse) * (1 - positionDifference.Magnitude / explosionRadius) + minImpulse))
			end
		end
	end
end
function C4System.init(serviceContainer)
	emService = serviceContainer.em
	initialized = true
	C4Binder:Start()
	local function hideC4Object(c4Object)
		c4Object._obj.PrimaryPart.Anchored = true
		c4Object._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
	end
	C4Binder:GetClassAddedSignal():Connect(function(c4Instance)
		RxInstanceUtils.yieldForProperty(c4Instance.obj, "PrimaryPart")
		if c4Instance:GetCreator() == LocalPlayer then
			c4Instance._obj.PrimaryPart.Anchored = true
			c4Instance._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		c4Instance._maid:GiveTask(c4Instance._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function()
			if c4Instance:GetCreator() == LocalPlayer then
				local c4Obj = c4Instance
				c4Obj._obj.PrimaryPart.Anchored = true
				c4Obj._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
		end))
	end)
	ReplicatedStorage:FindFirstChild(C4Consts.PLAY_EXPLOSION_REMOTE_NAME).OnClientEvent:Connect(function(explosionPos, explosionData)
		C4Utils.explosionVisual(explosionPos)
	end)
	ReplicatedStorage:FindFirstChild("C4ExplodedRemote").OnClientEvent:Connect(C4System.onExplode)
end
return C4System
