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
local v1 = nil
local v2 = false
function t.onExplode(p1, p2, p3, p4, p5) --[[ Line: 16 | Upvalues: v2 (ref), LocalPlayer (copy), v1 (ref), CurrentCamera (copy), CamShaker (copy), RunService (copy), Promise (copy) ]]
	if v2 then
		if not p3 then
			p3 = 24
		end
		if not p4 then
			p4 = 128
		end
		local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
		local RootPart = Humanoid.RootPart
		local v12 = RootPart.Position - p1
		if v12.Magnitude < p2 then
			if Humanoid.SeatPart then
				Humanoid.Jump = true
				task.wait(0.1)
			end
			task.spawn(v1.e9kobedq)
			local v22 = CurrentCamera.CFrame
			local v3 = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(p1) --[[ Line: 38 | Upvalues: v22 (ref), CurrentCamera (ref) ]]
				v22 = CurrentCamera.CFrame
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			local v4 = RunService.Heartbeat:Connect(function() --[[ Line: 42 | Upvalues: CurrentCamera (ref), v22 (ref) ]]
				CurrentCamera.CFrame = v22
			end)
			v3:Start()
			v3:Shake(CamShaker.Presets.Explosion)
			Promise.delay(2):andThen(function() --[[ Line: 48 | Upvalues: v3 (copy), v4 (copy) ]]
				v3:Stop()
				v4:Disconnect()
			end)
			if not p5 then
				RootPart:ApplyImpulse(RootPart.AssemblyMass * v12.Unit * ((p4 - p3) * (1 - v12.Magnitude / p2) + p3))
			end
		end
	end
end
function t.init(p1) --[[ Line: 61 | Upvalues: v1 (ref), v2 (ref), C4Binder (copy), RxInstanceUtils (copy), LocalPlayer (copy), ReplicatedStorage (copy), C4Consts (copy), C4Utils (copy), t (copy) ]]
	v1 = p1.em
	v2 = true
	C4Binder:Start()
	local function hide(p1) --[[ Line: 66 ]]
		p1._obj.PrimaryPart.Anchored = true
		p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
	end
	C4Binder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 70 | Upvalues: RxInstanceUtils (ref), LocalPlayer (ref) ]]
		RxInstanceUtils.yieldForProperty(p1.obj, "PrimaryPart")
		if p1:GetCreator() == LocalPlayer then
			p1._obj.PrimaryPart.Anchored = true
			p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		p1._maid:GiveTask(p1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 75 | Upvalues: p1 (copy), LocalPlayer (ref) ]]
			if p1:GetCreator() == LocalPlayer then
				local v1 = p1
				v1._obj.PrimaryPart.Anchored = true
				v1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
		end))
	end)
	ReplicatedStorage:FindFirstChild(C4Consts.PLAY_EXPLOSION_REMOTE_NAME).OnClientEvent:Connect(function(p1, p2) --[[ Line: 83 | Upvalues: C4Utils (ref) ]]
		C4Utils.explosionVisual(p1)
	end)
	ReplicatedStorage:FindFirstChild("C4ExplodedRemote").OnClientEvent:Connect(t.onExplode)
end
return t