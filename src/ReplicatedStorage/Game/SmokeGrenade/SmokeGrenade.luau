local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Anim = require(ReplicatedStorage.Module.Anim)
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local Promise = require(ReplicatedStorage.Std.Promise)
local SmokeGrenadeConsts = require(script.Parent.SmokeGrenadeConsts)
local t = {}
t.__index = t
t.__ClassName = "SmokeGrenade"
function t.new(p1) --[[ Line: 18 | Upvalues: t (copy), Maid (copy), SmokeGrenadeConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2.maid = t2._maid
	t2._obj = p1
	t2.obj = t2._obj
	t2._thrownRemote = p1:WaitForChild(SmokeGrenadeConsts.THROWN_REMOTE_NAME)
	t2._thrownValue = p1:WaitForChild(SmokeGrenadeConsts.THROWN_VALUE_NAME)
	t2._maid:GiveTask(p1:WaitForChild(SmokeGrenadeConsts.EXPLODE_REMOTE_NAME).OnClientEvent:Connect(function() --[[ Line: 34 | Upvalues: t2 (copy) ]]
		t2:_playExplosionFx()
	end))
	t2._creatorIdValue = p1:WaitForChild(SmokeGrenadeConsts.CREATOR_ID_VALUE_NAME)
	return t2
end
local v1 = Color3.new(255/255, 255/255, 255/255)
function t._getJ(p1, p2) --[[ Line: 44 | Upvalues: SmokeGrenadeConsts (copy) ]]
	local v1 = (p1._obj.PrimaryPart.Position - p2).Magnitude / SmokeGrenadeConsts.BLAST_RADIUS
	if v1 < 0.001 then
		v1 = 0
	end
	if v1 > 0.999 then
		v1 = 1
	end
	return 1 - v1
end
function t._playExplosionFx(p1) --[[ Line: 55 | Upvalues: SmokeGrenadeConsts (copy), Maid (copy), Promise (copy), PlayerUtils (copy), LocalPlayer (copy), CamShaker (copy), CurrentCamera (copy), Lighting (copy), v1 (copy), Anim (copy), RunService (copy) ]]
	local FX_DURATION = SmokeGrenadeConsts.FX_DURATION
	local v12 = Maid.new()
	Promise.delay(FX_DURATION):andThenCall(v12.Destroy, v12)
	local v2 = PlayerUtils.getHumanoid(LocalPlayer)
	local v3 = PlayerUtils.getRootPart(LocalPlayer)
	if (p1._obj.PrimaryPart.Position - v3.Position).Magnitude < SmokeGrenadeConsts.BLAST_RADIUS then
		local v4 = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(p1) --[[ Line: 67 | Upvalues: CurrentCamera (ref) ]]
			CurrentCamera.CFrame = CurrentCamera.CFrame * p1
		end)
		v4:Start()
		v4:Shake(CamShaker.Presets.Explosion)
		Promise.delay(2):andThenCall(v4.Stop, v4)
		v2.NameDisplayDistance = 0
		v12:GiveTask(function() --[[ Line: 76 | Upvalues: v2 (copy) ]]
			v2.NameDisplayDistance = 100
		end)
	end
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Parent = Lighting
	v12:GiveTask(BlurEffect)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.TintColor = v1
	ColorCorrectionEffect.Parent = Lighting
	v12:GiveTask(ColorCorrectionEffect)
	local v5 = Anim.new(0.1)
	v5.OnCompleted:Connect(function() --[[ Line: 92 | Upvalues: v5 (copy) ]]
		v5:Destroy()
	end)
	v12:GiveTask(v5)
	v5.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 96 | Upvalues: v5 (copy), p1 (copy), v3 (ref), BlurEffect (copy), SmokeGrenadeConsts (ref), ColorCorrectionEffect (copy), v1 (ref) ]]
		local v12 = v5:Update()
		local v2 = p1:_getJ(v3.Position)
		BlurEffect.Size = v12 * v2 * SmokeGrenadeConsts.FX_BLUR_SIZE
		ColorCorrectionEffect.TintColor = v1:lerp(SmokeGrenadeConsts.FX_COLOR, v12 * v2)
	end))
	v5.Maid:GiveTask(function() --[[ Line: 103 | Upvalues: v12 (ref), RunService (ref), v3 (ref), PlayerUtils (ref), LocalPlayer (ref), p1 (copy), BlurEffect (copy), SmokeGrenadeConsts (ref), ColorCorrectionEffect (copy), v1 (ref) ]]
		v12.distanceRuntime = RunService.Heartbeat:Connect(function() --[[ Line: 104 | Upvalues: v3 (ref), PlayerUtils (ref), LocalPlayer (ref), p1 (ref), BlurEffect (ref), SmokeGrenadeConsts (ref), ColorCorrectionEffect (ref), v1 (ref) ]]
			v3 = PlayerUtils.getRootPart(LocalPlayer)
			local v12 = p1:_getJ(v3.Position)
			BlurEffect.Size = v12 * SmokeGrenadeConsts.FX_BLUR_SIZE
			ColorCorrectionEffect.TintColor = v1:lerp(SmokeGrenadeConsts.FX_COLOR, v12)
		end)
	end)
	Promise.delay(FX_DURATION - 0.1 - 1):andThen(function() --[[ Line: 113 | Upvalues: v12 (ref), Anim (ref), RunService (ref), p1 (copy), v3 (ref), BlurEffect (copy), SmokeGrenadeConsts (ref), ColorCorrectionEffect (copy), v1 (ref) ]]
		v12.distanceRuntime = nil
		local v13 = Anim.new(1)
		v12:GiveTask(v13)
		v13.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 117 | Upvalues: v13 (copy), p1 (ref), v3 (ref), BlurEffect (ref), SmokeGrenadeConsts (ref), ColorCorrectionEffect (ref), v1 (ref) ]]
			local v12 = v13:Update()
			local v2 = p1:_getJ(v3.Position)
			BlurEffect.Size = (1 - v12) * v2 * SmokeGrenadeConsts.FX_BLUR_SIZE
			ColorCorrectionEffect.TintColor = v1:lerp(SmokeGrenadeConsts.FX_COLOR, (1 - v12) * v2)
		end))
	end)
	Promise.delay(FX_DURATION):andThen(function() --[[ Line: 125 | Upvalues: v12 (ref) ]]
		v12:Destroy()
		v12 = nil
	end)
end
function t.SetThrown(p1) --[[ Line: 130 ]]
	p1._thrownValue.Value = true
	p1._thrownRemote:FireServer()
end
function t.GetThrown(p1) --[[ Line: 134 ]]
	return p1._thrownValue.Value
end
function t.GetCreator(p1) --[[ Line: 137 | Upvalues: Players (copy) ]]
	return Players:GetPlayerByUserId(p1._creatorIdValue.Value)
end
function t.SetVelocity(p1, p2) --[[ Line: 142 ]]
	assert(p2 ~= nil)
	p1._obj.PrimaryPart.Velocity = p2
end
function t.SetRotVelocity(p1, p2) --[[ Line: 147 ]]
	assert(p2 ~= nil)
	p1._obj.PrimaryPart.RotVelocity = p2
end
function t.Destroy(p1) --[[ Line: 152 ]]
	assert(p1._maid)
	local _maid_2 = p1._maid
	p1._maid = nil
	_maid_2:Destroy()
	setmetatable(p1, nil)
end
return t