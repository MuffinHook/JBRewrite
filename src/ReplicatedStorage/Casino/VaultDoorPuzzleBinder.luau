-- Reviewed by Claude
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local DoorConsts = require(ReplicatedStorage.Door2.DoorConsts)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VaultDoorPuzzleUtils = require(ReplicatedStorage.Casino.VaultDoorPuzzleUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	v1.manifest = p2
	v1._pos = 0
	local function action(p1, p22)
		if p22 and v1:GetHacker() then
			p2.updateDirectionRemote:FireServer()
		elseif p22 then
			p2.requestHackRemote:FireServer()
		end
		return true
	end
	local function preUpdateFun(p1)
		local v12 = v1:GetHacker()
		local v2 = not v1:GetDisabled()
		if v2 then
			v2 = if v12 == nil then true else v12 == Players.LocalPlayer
		end
		p1.Enabled = v2
	end
	local t2 = {
		Part = v1.obj.PrimaryPart,
		Name = "",
		Timed = false,
		Dist = 8,
		Callback = action,
		Enabled = true,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.1
	}
	v1.spec = t2
	v1.maid:GiveTask(CircleAction.Add(t2, v1.obj.PrimaryPart))
	v1.maid:GiveTask(v1:GetHackerChangedSignal():Connect(function()
		local v12 = v1:GetHacker()
		if v12 then
			local v2 = Maid.new()
			v1.maid.hackMaid = v2
			v1:_hookHacker(v2, v12)
		else
			v1.maid.hackMaid = nil
			v1:_hookHacker()
		end
	end))
	v1:_hookHacker()
	return v1
end
function t._hookHacker(p1, p2, p3)
	if p2 == nil then
		p1.spec.Name = "Crack"
	else
		local v1 = 0
		local v2 = p1:GetDirection()
		p2:GiveTask(p1:GetDirectionChangedSignal():Connect(function()
			v2 = p1:GetDirection()
		end))
		p2:GiveTask(RunService.Heartbeat:Connect(function(p12)
			v1 = v1 + 5 * v2 * p12
			v1 = v1 * 0.95
			local v12 = p1
			v12._pos = v12._pos + v1 * p12
			p1.manifest.innerModel:SetPrimaryPartCFrame(p1.obj.PrimaryPart.CFrame * CFrame.Angles(0, 0, p1._pos))
		end))
		if p3 == Players.LocalPlayer then
			p1.spec.Name = "Change Direction"
		end
	end
end
function t.GetHackerChangedSignal(p1)
	return VaultDoorPuzzleUtils.getHackerChangedSignal(p1.obj)
end
function t.GetHacker(p1)
	return VaultDoorPuzzleUtils.getHacker(p1.obj)
end
function t.SetDirection(p1, p2)
	return VaultDoorPuzzleUtils.setDirection(p1.obj, p2)
end
function t.GetDirection(p1)
	return VaultDoorPuzzleUtils.getDirection(p1.obj)
end
function t.GetDirectionChangedSignal(p1)
	return VaultDoorPuzzleUtils.getDirectionChangedSignal(p1.obj)
end
function t.GetDisabled(p1)
	return VaultDoorPuzzleUtils.getDisabled(p1.obj)
end
return ManifestBinder.new("VaultDoorPuzzle", {
	innerModel = DoorConsts.INNER_MODEL_NAME,
	requestHackRemote = "RequestHack",
	updateDirectionRemote = "UpdateDirection"
}, t)