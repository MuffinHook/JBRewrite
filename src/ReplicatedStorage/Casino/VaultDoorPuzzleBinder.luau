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
function t.new(p1, p2) --[[ Line: 18 | Upvalues: BaseObject (copy), t (copy), RxInstanceUtils (copy), Players (copy), CircleAction (copy), Maid (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	v1.manifest = p2
	v1._pos = 0
	local function action(p1, p22) --[[ Line: 27 | Upvalues: v1 (copy), p2 (copy) ]]
		if p22 and v1:GetHacker() then
			p2.updateDirectionRemote:FireServer()
		elseif p22 then
			p2.requestHackRemote:FireServer()
		end
		return true
	end
	local function preUpdateFun(p1) --[[ Line: 37 | Upvalues: v1 (copy), Players (ref) ]]
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
	v1.maid:GiveTask(v1:GetHackerChangedSignal():Connect(function() --[[ Line: 54 | Upvalues: v1 (copy), Maid (ref) ]]
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
function t._hookHacker(p1, p2, p3) --[[ Line: 69 | Upvalues: RunService (copy), Players (copy) ]]
	if p2 == nil then
		p1.spec.Name = "Crack"
	else
		local v1 = 0
		local v2 = p1:GetDirection()
		p2:GiveTask(p1:GetDirectionChangedSignal():Connect(function() --[[ Line: 74 | Upvalues: v2 (ref), p1 (copy) ]]
			v2 = p1:GetDirection()
		end))
		p2:GiveTask(RunService.Heartbeat:Connect(function(p12) --[[ Line: 77 | Upvalues: v1 (ref), v2 (ref), p1 (copy) ]]
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
function t.GetHackerChangedSignal(p1) --[[ Line: 91 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.getHackerChangedSignal(p1.obj)
end
function t.GetHacker(p1) --[[ Line: 94 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.getHacker(p1.obj)
end
function t.SetDirection(p1, p2) --[[ Line: 97 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.setDirection(p1.obj, p2)
end
function t.GetDirection(p1) --[[ Line: 100 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.getDirection(p1.obj)
end
function t.GetDirectionChangedSignal(p1) --[[ Line: 103 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.getDirectionChangedSignal(p1.obj)
end
function t.GetDisabled(p1) --[[ Line: 106 | Upvalues: VaultDoorPuzzleUtils (copy) ]]
	return VaultDoorPuzzleUtils.getDisabled(p1.obj)
end
return ManifestBinder.new("VaultDoorPuzzle", {
	innerModel = DoorConsts.INNER_MODEL_NAME,
	requestHackRemote = "RequestHack",
	updateDirectionRemote = "UpdateDirection"
}, t)