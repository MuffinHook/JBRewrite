local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Promise = require(ReplicatedStorage.Std.Promise)
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local CameraShakeInstance = require(ReplicatedStorage.Game.CamShaker.CameraShakeInstance)
local ProximityCamShakeConsts = require(script.Parent.ProximityCamShakeConsts)
local v1 = Random.new()
local function Ease_InOutQuad(p1) --[[ Line: 16 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local t = {}
t.__index = t
local function makeCamShakeInst() --[[ Line: 23 | Upvalues: CameraShakeInstance (copy) ]]
	local v1 = CameraShakeInstance.new(2, 6, 1, 1)
	v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
	v1.RotationInfluence = Vector3.new(1, 1, 1)
	return v1
end
function t.new(p1) --[[ Line: 30 | Upvalues: t (copy), Maid (copy), ProximityCamShakeConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	if not p1:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
		p1:SetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME, false)
	end
	if not p1:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME) then
		p1:SetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME, 32)
	end
	if not p1:GetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME) then
		p1:SetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME, 1)
	end
	local function updateEnabled() --[[ Line: 47 | Upvalues: p1 (copy), ProximityCamShakeConsts (ref), t2 (copy) ]]
		if p1:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
			t2:Listen(p1)
		else
			t2._maid._listenLoop = nil
		end
	end
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(ProximityCamShakeConsts.ENABLED_ATTR_NAME):Connect(updateEnabled))
	if p1:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
		t2:Listen(p1)
	else
		t2._maid._listenLoop = nil
	end
	return t2
end
function t.Listen(p1, p2) --[[ Line: 60 | Upvalues: Interval (copy), PlayerUtils (copy), LocalPlayer (copy), ProximityCamShakeConsts (copy) ]]
	p1._maid._listenLoop = Interval.every(0.5):Connect(function() --[[ Line: 61 | Upvalues: PlayerUtils (ref), LocalPlayer (ref), p2 (copy), ProximityCamShakeConsts (ref), p1 (copy) ]]
		local v1 = PlayerUtils.getRootPart(LocalPlayer)
		if v1 and ((v1.Position - p2.Position).Magnitude / p2:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME) <= 1 and not p1._maid._camUpdater) then
			p1:StartUpdater(p2)
		end
	end)
end
function t.StartUpdater(p1, p2) --[[ Line: 76 | Upvalues: CurrentCamera (copy), CamShaker (copy), RunService (copy), v1 (copy), CameraShakeInstance (copy), ProximityCamShakeConsts (copy), Promise (copy) ]]
	local v12 = Enum.RenderPriority.Camera.Value + 5
	local v2 = CurrentCamera.CFrame
	local v3 = CamShaker.new(v12, function(p1) --[[ Line: 79 | Upvalues: v2 (ref), CurrentCamera (ref) ]]
		v2 = CurrentCamera.CFrame
		CurrentCamera.CFrame = CurrentCamera.CFrame * p1
	end)
	local v4 = RunService.Heartbeat:Connect(function() --[[ Line: 83 | Upvalues: CurrentCamera (ref), v2 (ref) ]]
		CurrentCamera.CFrame = v2
	end)
	v3._renderName = "ProximityCamShake_" .. tostring((v1:NextInteger(1, 1000000000)))
	v3:Start()
	local v6 = CameraShakeInstance.new(2, 6, 1, 1)
	v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
	v6.RotationInfluence = Vector3.new(1, 1, 1)
	local v7 = v3:ShakeSustain(v6)
	p1._maid._camUpdater = RunService.Heartbeat:Connect(function() --[[ Line: 91 | Upvalues: CurrentCamera (ref), p2 (copy), ProximityCamShakeConsts (ref), p1 (copy), v7 (copy) ]]
		local v2 = (CurrentCamera.CFrame.Position - p2.Position).Magnitude / p2:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME)
		if v2 > 1 or not p2:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
			p1._maid._stop = nil
		else
			local v3 = 1 - v2
			local v4, v5
			if v3 < 0.5 then
				v4 = 2 * v3 * v3
				if not v4 then
					v5 = v3
					v4 = -1 - 2 * (v3 - 2) * v3
				end
			else
				v5 = v3
				v4 = -1 - 2 * (v3 - 2) * v3
			end
			v7:SetScaleMagnitude(v4 * p2:GetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME))
		end
	end)
	function p1._maid._stop() --[[ Line: 106 | Upvalues: v7 (copy), Promise (ref), v3 (copy), v4 (copy), p1 (copy) ]]
		v7:StartFadeOut(1)
		Promise.delay(1):andThen(function() --[[ Line: 110 | Upvalues: v3 (ref), v4 (ref) ]]
			v3:Stop()
			v4:Disconnect()
		end):catch(warn)
		if p1._maid then
			p1._maid._camUpdater = nil
		end
	end
end
function t.Destroy(p1) --[[ Line: 121 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t