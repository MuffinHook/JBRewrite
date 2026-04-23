local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Players = game:GetService("Players")
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Falling = require(ReplicatedStorage.Game.Falling)
local Shockwave = require(ReplicatedStorage.Game.Shockwave)
local Maid = require(ReplicatedStorage.Std.Maid)
require(ReplicatedStorage.Module.UI)
local Binder = require(ReplicatedStorage.Std.Binder)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local RobberyUtils = require(ReplicatedStorage.Robbery.RobberyUtils)
local OilRigConsts = require(ReplicatedStorage.OilRig.OilRigConsts)
local OilRigUtils = require(ReplicatedStorage.OilRig.OilRigUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 21 | Upvalues: BaseObject (copy), t (copy), Maid (copy), OilRigUtils (copy), Players (copy), RobberyUtils (copy), RobberyConsts (copy), RxInstanceUtils (copy), OilRigConsts (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local function handleProgressionState() --[[ Line: 25 | Upvalues: Maid (ref), v1 (copy), OilRigUtils (ref), Players (ref) ]]
		v1.maid.progressionMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			OilRigUtils.getProgressionState(v1.obj)
		end
	end
	v1.maid:GiveTask(OilRigUtils.getProgressionStateChangedSignal(v1.obj):Connect(handleProgressionState))
	local function handleStatus() --[[ Line: 36 | Upvalues: RobberyUtils (ref), v1 (copy), Maid (ref), OilRigUtils (ref), Players (ref), RobberyConsts (ref) ]]
		local v12 = RobberyUtils.getStatus(v1.obj)
		v1.maid.currRobberyMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			local isSTARTED = v12 == RobberyConsts.ENUM_STATUS.STARTED
		end
	end
	v1.maid:GiveTask(RobberyUtils.getStatusChangedSignal(v1.obj):Connect(handleStatus))
	v1.maid.localPlayerRobberyMaid = Maid.new()
	local function handleLocalPlayerInRobbery() --[[ Line: 50 | Upvalues: Maid (ref), v1 (copy), OilRigUtils (ref), Players (ref), RobberyUtils (ref), RobberyConsts (ref) ]]
		v1.maid.progressionMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			OilRigUtils.getProgressionState(v1.obj)
		end
		local v2 = RobberyUtils.getStatus(v1.obj)
		v1.maid.currRobberyMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			local isSTARTED = v2 == RobberyConsts.ENUM_STATUS.STARTED
		end
		v1.maid.localPlayerRobberyMaid:DoCleaning()
	end
	v1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(v1.obj, OilRigConsts.PLAYERS_IN_ROBBERY_FOLDER_NAME, function(p1, p2) --[[ Line: 61 | Upvalues: RxInstanceUtils (ref), Players (ref), Maid (ref), v1 (copy), OilRigUtils (ref), RobberyUtils (ref), RobberyConsts (ref), handleLocalPlayerInRobbery (copy) ]]
		p2:GiveTask(RxInstanceUtils.observeChildren(p1, function(p1, p2) --[[ Line: 63 | Upvalues: Players (ref), Maid (ref), v1 (ref), OilRigUtils (ref), RobberyUtils (ref), RobberyConsts (ref), handleLocalPlayerInRobbery (ref) ]]
			if p1.Name == tostring(Players.LocalPlayer.UserId) then
				v1.maid.progressionMaid = Maid.new()
				if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
					OilRigUtils.getProgressionState(v1.obj)
				end
				local v3 = RobberyUtils.getStatus(v1.obj)
				v1.maid.currRobberyMaid = Maid.new()
				if OilRigUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
					local isSTARTED = v3 == RobberyConsts.ENUM_STATUS.STARTED
				end
				v1.maid.localPlayerRobberyMaid:DoCleaning()
				p2:GiveTask(p1.Changed:Connect(handleLocalPlayerInRobbery))
			end
		end))
	end))
	local UpdateOilTankRemote = v1.obj:WaitForChild("UpdateOilTankRemote")
	v1.maid:GiveTask(UpdateOilTankRemote.OnClientEvent:Connect(function(p1, p2) --[[ Line: 75 ]]
		local v1 = p1:GetAttribute("OriginalCFrame")
		local v2 = p1:GetAttribute("OriginalSize")
		local Oil = p1:FindFirstChild("Oil")
		assert(Oil and Oil:IsA("BasePart"))
		local v4 = 1 - p2
		Oil.Size = Vector3.new(1, v4, 1) * v2
		Oil.CFrame = v1 * CFrame.new(0, -v2.Y / 2 * (1 - v4), 0)
		if v4 <= 0.001 then
			Oil.Transparency = 1
		else
			Oil.Transparency = 0
		end
	end))
	v1:_listenEverywhere()
	return v1
end
function t._listenEverywhere(p1) --[[ Line: 94 | Upvalues: OilRigUtils (copy), OilRigConsts (copy) ]]
	local function handleProgressionState() --[[ Line: 95 | Upvalues: OilRigUtils (ref), p1 (copy), OilRigConsts (ref) ]]
		if OilRigUtils.getProgressionState(p1.obj) == OilRigConsts.PROGRESSION_STATE.BlowUp then
			p1:_launchBlowUp()
		end
	end
	p1.maid:GiveTask(OilRigUtils.getProgressionStateChangedSignal(p1.obj):Connect(handleProgressionState))
end
function t.IsPlayerInRobbery(p1, p2) --[[ Line: 103 | Upvalues: OilRigUtils (copy) ]]
	return OilRigUtils.getIsPlayerInRobbery(p1.obj, p2)
end
function t._launchBlowUp(p1) --[[ Line: 106 | Upvalues: Shockwave (copy), VehicleUtils (copy), CharacterUtil (copy), Falling (copy) ]]
	local Explosion = p1.obj:FindFirstChild("OpenCloseSignal"):FindFirstChild("Explosion")
	assert(Explosion)
	Shockwave.new(Explosion.Position, {
		Duration = 4,
		MaxRadius = 750,
		StartTransparency = 0.2,
		EndTransparency = 1
	}).OnPastLocalPlayer:Connect(function() --[[ Line: 118 | Upvalues: p1 (copy), VehicleUtils (ref), CharacterUtil (ref), Falling (ref) ]]
		local ShockwaveRemote = p1.obj:FindFirstChild("ShockwaveRemote")
		if ShockwaveRemote then
			ShockwaveRemote:FireServer()
		end
		if VehicleUtils.GetLocalVehiclePacket() ~= nil then
			CharacterUtil.OnJump()
			task.wait(0.1)
		end
		Falling.StartRagdolling(5)
	end)
end
return Binder.new(OilRigConsts.TAG_NAME, t)