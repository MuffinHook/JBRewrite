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
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2._homeItem = self
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
function t._setArmJ(self, p2)
	for i, v in ipairs(DoorUtils.getInnerModel(self._doorModel):GetChildren()) do
		if v.Name == "Arm" then
			local cframe2 = v.CFrame
			v.Size = Vector3.new(p2 * 7.6 + (1 - p2) * 4, 0.5, 0.5)
			v.CFrame = cframe2
		end
	end
end
function t._onDeadlineChanged(self)
	local instance = Time.GetNowSync()
	if instance < self:GetDeadline() then
		self._maid._deadlineLoop = Interval.every(1):Connect(function()
			instance = Time.GetNowSync()
			local var12 = self:GetDeadline() - instance
			if var12 < 0 then
				var12 = 0
			end
			self:_updateDeadlineUi(var12)
			if var12 == 0 then
				self._maid._deadlineLoop = nil
			end
		end)
	else
		self:_updateDeadlineUi(0)
	end
end
function t._findDoor(self)
	local Door = self._obj:WaitForChild("Door")
	self._doorModel = Door
	BinderUtils.promiseBoundClass(DoorBinder, Door):andThen(function(p12)
		self:_receiveDoor(p12)
	end):catch(warn)
end
function t._receiveDoor(self, p2)
	local function preUpdateFun(p12)
		local instance = DoorUtils.getOpen(self._doorModel)
		local cframe2 = self:IsCounting()
		local var3 = self._homeItem:GetHome()
		local v4
		if var3 and (var3:HasPermissionToEnter(LocalPlayer) and not cframe2) then
			p12.Name = "Arm"
			v4 = true
		else
			v4 = false
		end
		if self._homeItem:IsBeingDragged() then
			v4 = false
		end
		if not instance then
			v4 = false
		end
		p12.Enabled = v4
	end
	local function action(p12, p2)
		if p2 then
			self._vaultInteractRemote:FireServer()
			return true
		end
	end
	local Body = DoorUtils.getInnerModel(self.obj.Door).Body
	self.maid:GiveTask(function()  end)
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
	self._maid:GiveTask(function()
		CircleAction.Remove(Body)
	end)
end
function t.GetIsVaultArmed(self)
	return not DoorUtils.getOpen(self.obj.Door)
end
function t.GetArmingTeamId(self)
	return VaultUtils.getArmingTeamId(self.obj)
end
function t._updateDeadlineUi(self, p2)
	local instance = math.floor(p2 / 60)
	DoorUtils.getInnerModel(self._obj.Door).Timer.SurfaceGui.TextLabel.Text = ("%02d:%02d"):format(instance, p2 % 60)
end
function t._onAmountChanged(self)
	local SurfaceGui = DoorUtils.getInnerModel(self._obj.Door).Cash.SurfaceGui
	if self._amountValue.Value > 0 then
		SurfaceGui.TextLabel.BackgroundColor3 = Color3.fromRGB(115, 250, 121)
		SurfaceGui.TextLabel.BackgroundTransparency = 0
		SurfaceGui.TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
	else
		SurfaceGui.TextLabel.BackgroundTransparency = 1
	end
	SurfaceGui.TextLabel.Text = ("%s"):format(Format.Currency(self._amountValue.Value))
end
function t.GetDeadline(self)
	return self._deadlineValue.Value
end
function t.IsCounting(self)
	return self:GetDeadline() > Time.GetNowSync()
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local instance = t.new(self)
		self._maid:GiveTask(instance)
		self._vault = instance
	end
}
