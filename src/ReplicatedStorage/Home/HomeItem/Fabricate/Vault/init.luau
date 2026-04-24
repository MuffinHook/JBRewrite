-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VaultUtils = require(script.VaultUtils)
local DoorBinder = require(ReplicatedStorage.Door2.DoorBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local Interval = require(ReplicatedStorage.Std.Interval)
local Format = require(ReplicatedStorage.Module.Format)
local VaultConsts = require(script.VaultConsts)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Game.PlayerUtils)
require(ReplicatedStorage.Resource.Settings)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local LocalPlayer = Players.LocalPlayer
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._homeItem = p1
	t2._obj = t2._homeItem._obj
	t2.obj = t2._obj
	t2._maid = Maid.new()
	t2.maid = t2._maid
	t2._deadlineValue = t2._obj:WaitForChild(VaultConsts.DEADLINE_VALUE_NAME)
	t2._maid:GiveTask(t2._deadlineValue.Changed:Connect(function()
		t2:_onDeadlineChanged()
	end))
	t2:_onDeadlineChanged()
	t2._amountValue = t2._obj:WaitForChild(VaultConsts.AMOUNT_VALUE_NAME)
	t2._maid:GiveTask(t2._amountValue.Changed:Connect(function()
		t2:_onAmountChanged()
	end))
	t2:_onAmountChanged()
	t2._vaultInteractRemote = t2._obj:WaitForChild(VaultConsts.VAULT_INTERACT_REMOTE_NAME)
	t2:_findDoor()
	return t2
end
function t._setArmJ(p1, p2)
	for i, v in ipairs(DoorUtils.getInnerModel(p1._doorModel):GetChildren()) do
		if v.Name == "Arm" then
			local v2 = v.CFrame
			v.Size = Vector3.new(p2 * 7.6 + (1 - p2) * 4, 0.5, 0.5)
			v.CFrame = v2
		end
	end
end
function t._onDeadlineChanged(p1)
	local v1 = Time.GetNowSync()
	if v1 < p1:GetDeadline() then
		p1._maid._deadlineLoop = Interval.every(1):Connect(function()
			v1 = Time.GetNowSync()
			local v12 = p1:GetDeadline() - v1
			if v12 < 0 then
				v12 = 0
			end
			p1:_updateDeadlineUi(v12)
			if v12 == 0 then
				p1._maid._deadlineLoop = nil
			end
		end)
	else
		p1:_updateDeadlineUi(0)
	end
end
function t._findDoor(p1)
	local Door = p1._obj:WaitForChild("Door")
	p1._doorModel = Door
	BinderUtils.promiseBoundClass(DoorBinder, Door):andThen(function(p12)
		p1:_receiveDoor(p12)
	end):catch(warn)
end
function t._receiveDoor(p1, p2)
	local function preUpdateFun(p12)
		local v1 = DoorUtils.getOpen(p1._doorModel)
		local v2 = p1:IsCounting()
		local v3 = p1._homeItem:GetHome()
		local v4
		if v3 and (v3:HasPermissionToEnter(LocalPlayer) and not v2) then
			p12.Name = "Arm"
			v4 = true
		else
			v4 = false
		end
		if p1._homeItem:IsBeingDragged() then
			v4 = false
		end
		if not v1 then
			v4 = false
		end
		p12.Enabled = v4
	end
	local function action(p12, p2)
		if p2 then
			p1._vaultInteractRemote:FireServer()
			return true
		end
	end
	local Body = DoorUtils.getInnerModel(p1.obj.Door).Body
	p1.maid:GiveTask(function()  end)
	CircleAction.Add({
		Part = Body,
		Name = "",
		NoRay = true,
		Timed = true,
		Duration = 3,
		Dist = 10,
		Callback = action,
		PreUpdateFun = preUpdateFun
	}, Body)
	p1._maid:GiveTask(function()
		CircleAction.Remove(Body)
	end)
end
function t.GetIsVaultArmed(p1)
	return not DoorUtils.getOpen(p1.obj.Door)
end
function t.GetArmingTeamId(p1)
	return VaultUtils.getArmingTeamId(p1.obj)
end
function t._updateDeadlineUi(p1, p2)
	local v1 = math.floor(p2 / 60)
	DoorUtils.getInnerModel(p1._obj.Door).Timer.SurfaceGui.TextLabel.Text = ("%02d:%02d"):format(v1, p2 % 60)
end
function t._onAmountChanged(p1)
	local SurfaceGui = DoorUtils.getInnerModel(p1._obj.Door).Cash.SurfaceGui
	if p1._amountValue.Value > 0 then
		SurfaceGui.TextLabel.BackgroundColor3 = Color3.fromRGB(115, 250, 121)
		SurfaceGui.TextLabel.BackgroundTransparency = 0
		SurfaceGui.TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
	else
		SurfaceGui.TextLabel.BackgroundTransparency = 1
	end
	SurfaceGui.TextLabel.Text = ("%s"):format(Format.Currency(p1._amountValue.Value))
end
function t.GetDeadline(p1)
	return p1._deadlineValue.Value
end
function t.IsCounting(p1)
	return p1:GetDeadline() > Time.GetNowSync()
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return {
	setup = function(p1)
		local v1 = t.new(p1)
		p1._maid:GiveTask(v1)
		p1._vault = v1
	end
}
