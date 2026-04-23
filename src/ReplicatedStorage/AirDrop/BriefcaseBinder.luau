-- Reviewed by Claude
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Audio)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local createElement = Roact.createElement
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local BriefcaseConsts = require(ReplicatedStorage.AirDrop.BriefcaseConsts)
local BriefcaseUtils = require(ReplicatedStorage.AirDrop.BriefcaseUtils)
local BriefcaseDisplay = require(ReplicatedStorage.AirDrop.UI.BriefcaseDisplay)
local AirDropUtils = require(ReplicatedStorage.AirDrop.AirDropUtils)
local t = { 9238451278, 9238451797, 9238452703, 9238452956, 9238453431, 9238453749 }
local t2 = {}
t2.__index = t2
setmetatable(t2, BaseObject)
function t2.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t2)
	v1.maid:GiveTask(RxInstanceUtils.observeAttribute(p1, BriefcaseConsts.BORN_AT_ATTR_NAME, function(p1, p2)
		if p1 then
			v1.maid.updatePositionThread = RunService.Heartbeat:Connect(function()
				v1:_update(p1)
			end)
		end
	end))
	local function pressCallback(p1, p2)
		v1:_pressed(p1, p2)
		if p2 then
			return v1:_collect()
		end
	end
	local function releaseCallback(p1, p2)
		v1:_released(p1, p2)
	end
	local function whilePressedUpdate(p12)
		local v2 = math.ceil(p12 * #t)
		for i, v in ipairs(p1:FindFirstChild("Walls"):GetDescendants()) do
			if v:IsA("Decal") then
				if t[v2] then
					v.Texture = ("rbxassetid://%d"):format(t[v2])
				else
					v.Texture = ""
				end
			end
		end
	end
	local function getCurrentAccumulation()
		return v1.obj:GetAttribute(BriefcaseConsts.BRIEFCASE_PRESS_DURATION_ACCUMULATION_ATTRIBUTE_NAME)
	end
	local v3 = BriefcaseUtils.getOpenDuration(v1.obj)
	assert(v3, "No opening duration for this briefcase")
	local t3 = {
		Name = "Open Crate",
		Timed = true,
		Duration = v3,
		Dist = 10,
		Callback = pressCallback,
		ReleaseCallback = releaseCallback,
		GetAccumulation = getCurrentAccumulation,
		WhilePressedUpdate = whilePressedUpdate
	}
	local function onCollectedChanged()
		if v1:GetCollected() then
			t3.Enabled = false
			p1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = true
			p1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = true
			local function onFinished()
				p1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
				p1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
			end
			local v12 = os.clock()
			local v2 = nil
			v2 = RunService.Heartbeat:Connect(function()
				local v1 = os.clock() - v12
				if v1 > 0.4 then
					v1 = 0.4
					v2:Disconnect()
					v2 = nil
					p1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
					p1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
				end
				p1:FindFirstChild("Particles").Transparency = v1 / 0.4
			end)
		end
	end
	onCollectedChanged()
	v1.maid:GiveTask(v1:GetCollectedChangedSignal():Connect(onCollectedChanged))
	local function onLandedChanged()
		if v1:GetLanded() then
			v1.maid.updatePositionThread = nil
			t3.Part = v1.obj.PrimaryPart
			t3.ValidRoot = v1.obj
			v1.maid:GiveTask(CircleAction.Add(t3, v1.obj))
			v1:_update(p1:GetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME))
			v1.maid:GiveTask(RunService.Heartbeat:Connect(function()
				local v1 = not AirDropUtils.getPlayerIsInAmbulanceStretcher(Players.LocalPlayer)
				if t3.Enabled ~= v1 then
					t3.Enabled = v1
				end
			end))
			local Chute = p1:FindFirstChild("Chute")
			local v12 = os.clock()
			local v2 = nil
			v2 = RunService.Heartbeat:Connect(function()
				local v1 = os.clock() - v12
				if v1 > 1 then
					v1 = 1
					v2:Disconnect()
					v2 = nil
				end
				local v22 = v1 / 1
				if not Chute then
					Chute = p1:FindFirstChild("Chute")
				end
				if Chute then
					Chute.Transparency = v22 * 0.75
				end
			end)
		end
	end
	onLandedChanged()
	v1.maid:GiveTask(v1:GetLandedChangedSignal():Connect(onLandedChanged))
	v1.maid:GivePromise(Promise.all({
		RxInstanceUtils.waitForChild(p1, "RarityProbsDisplay"),
		RxInstanceUtils.waitForChild(p1, BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME),
		RxInstanceUtils.waitForChild(p1, BriefcaseConsts.RELEASE_REMOTE_NAME),
		RxInstanceUtils.waitForChild(p1, BriefcaseConsts.HOLD_UPDATE_REMOTE_NAME)
	}):andThen(function(p1)
		local v4 = p1[4]
		local v6 = Roact.mount(createElement("SurfaceGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ResetOnSpawn = false,
			PixelsPerStud = 16,
			Adornee = p1[1],
			Face = Enum.NormalId.Front
		}, {
			Display = createElement(BriefcaseDisplay, {
				probsFolder = p1[2]
			})
		}), Players.LocalPlayer.PlayerGui, "BriefcaseGui")
		v1.maid:GiveTask(function()
			Roact.unmount(v6)
		end)
		v1.maid:GiveTask(p1[3].OnClientEvent:Connect(function()
			if t3.Pressed then
				t3.ForceRelease = true
			end
		end))
		v1.maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
			if t3.Pressed then
				v4:FireServer()
			end
		end))
	end))
	return v1
end
function t2._collect(p1)
	p1.obj:FindFirstChild(BriefcaseConsts.COLLECT_REMOTE_NAME):FireServer()
	return true
end
function t2._pressed(p1, p2, p3)
	p1.obj:FindFirstChild(BriefcaseConsts.PRESS_REMOTE_NAME):FireServer(p3)
	return true
end
function t2._released(p1, p2, p3)
	p1.obj:FindFirstChild(BriefcaseConsts.RELEASE_REMOTE_NAME):FireServer(p3)
	return true
end
function t2._update(p1, p2)
	local v1 = workspace:GetServerTimeNow() - p2
	local v2 = p1:GetDuration()
	if v2 < v1 then
		v1 = v2
	end
	if p1.obj.PrimaryPart then
		local v3 = p1:GetCFrameAt(v1)
		p1.obj:PivotTo(v3 * CFrame.new(0, p1.obj.PrimaryPart.Size.Y * 0.5, 0))
	end
end
function t2.SetOrigin(p1, p2)
	return BriefcaseUtils.setOrigin(p1.obj, p2)
end
function t2.GetOrigin(p1)
	return BriefcaseUtils.getOrigin(p1.obj)
end
function t2.SetTarget(p1, p2)
	return BriefcaseUtils.setTarget(p1.obj, p2)
end
function t2.GetTarget(p1)
	return BriefcaseUtils.getTarget(p1.obj)
end
function t2.SetTargetNormal(p1, p2)
	return BriefcaseUtils.setTargetNormal(p1.obj, p2)
end
function t2.GetTargetNormal(p1)
	return BriefcaseUtils.getTargetNormal(p1.obj)
end
function t2.SetSpeed(p1, p2)
	return BriefcaseUtils.setSpeed(p1.obj, p2)
end
function t2.GetSpeed(p1)
	return BriefcaseUtils.getSpeed(p1.obj)
end
function t2.SetBornAt(p1, p2)
	return BriefcaseUtils.setBornAt(p1.obj, p2)
end
function t2.GetBornAt(p1)
	return BriefcaseUtils.getBornAt(p1.obj)
end
function t2.SetLanded(p1, p2)
	return BriefcaseUtils.setLanded(p1.obj, p2)
end
function t2.GetLanded(p1)
	return BriefcaseUtils.getLanded(p1.obj)
end
function t2.GetLandedChangedSignal(p1)
	return BriefcaseUtils.getLandedChangedSignal(p1.obj)
end
function t2.SetLandedTime(p1, p2)
	return BriefcaseUtils.setLandedTime(p1.obj, p2)
end
function t2.GetLandedTime(p1)
	return BriefcaseUtils.getLandedTime(p1.obj)
end
function t2.SetRarityProbabilities(p1, p2)
	return BriefcaseUtils.setRarityProbabilities(p1.obj, p2)
end
function t2.GetRarityProbabilities(p1)
	return BriefcaseUtils.getRarityProbabilities(p1.obj)
end
function t2.GetCollected(p1)
	return BriefcaseUtils.getCollected(p1.obj)
end
function t2.SetCollected(p1, p2)
	return BriefcaseUtils.setCollected(p1.obj, p2)
end
function t2.GetCollectedChangedSignal(p1)
	return BriefcaseUtils.getCollectedChangedSignal(p1.obj)
end
function t2.GetDuration(p1)
	local v1 = p1:GetOrigin()
	local v2 = p1:GetTarget()
	local v3 = p1:GetSpeed()
	assert(v3 > 0, "speed must be > 0")
	return (v2 - v1).Magnitude / v3
end
function t2.GetPositionAt(p1, p2)
	local v1 = p1:GetOrigin()
	if v1 then
		local v2 = p1:GetTarget()
		if v2 then
			return BriefcaseUtils.getPositionAt(p2, v1, v2, (p1:GetDuration()))
		end
	end
end
function t2.GetCFrameAt(p1, p2)
	local v1 = p1:GetOrigin()
	if v1 then
		local v2 = p1:GetTarget()
		if v2 then
			local v3 = p1:GetTargetNormal()
			if v3 then
				return BriefcaseUtils.getCFrameAt(p2, v1, v2, v3, (p1:GetDuration()))
			end
		end
	end
end
return Binder.new(BriefcaseConsts.TAG_NAME, t2)