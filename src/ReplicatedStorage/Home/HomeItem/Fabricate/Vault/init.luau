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
local Vault = {}
Vault.__index = Vault
function Vault.new(self)
	local vaultInstance = {}
	setmetatable(vaultInstance, Vault)
	vaultInstance._homeItem = self
	vaultInstance._obj = vaultInstance._homeItem._obj
	vaultInstance.obj = vaultInstance._obj
	vaultInstance._maid = Maid.new()
	vaultInstance.maid = vaultInstance._maid
	vaultInstance._deadlineValue = vaultInstance._obj:WaitForChild(VaultConsts.DEADLINE_VALUE_NAME)
	vaultInstance._maid:GiveTask(vaultInstance._deadlineValue.Changed:Connect(function()
		vaultInstance:_onDeadlineChanged()
	end))
	vaultInstance:_onDeadlineChanged()
	vaultInstance._amountValue = vaultInstance._obj:WaitForChild(VaultConsts.AMOUNT_VALUE_NAME)
	vaultInstance._maid:GiveTask(vaultInstance._amountValue.Changed:Connect(function()
		vaultInstance:_onAmountChanged()
	end))
	vaultInstance:_onAmountChanged()
	vaultInstance._vaultInteractRemote = vaultInstance._obj:WaitForChild(VaultConsts.VAULT_INTERACT_REMOTE_NAME)
	vaultInstance:_findDoor()
	return vaultInstance
end
function Vault._setArmJ(self, armSizeMultiplier)
	for i, v in ipairs(DoorUtils.getInnerModel(self._doorModel):GetChildren()) do
		if v.Name == "Arm" then
			local originalCFrame = v.CFrame
			v.Size = Vector3.new(armSizeMultiplier * 7.6 + (1 - armSizeMultiplier) * 4, 0.5, 0.5)
			v.CFrame = originalCFrame
		end
	end
end
function Vault._onDeadlineChanged(self)
	local currentTime = Time.GetNowSync()
	if currentTime < self:GetDeadline() then
		self._maid._deadlineLoop = Interval.every(1):Connect(function()
			currentTime = Time.GetNowSync()
			local timeRemaining = self:GetDeadline() - currentTime
			if timeRemaining < 0 then
				timeRemaining = 0
			end
			self:_updateDeadlineUi(timeRemaining)
			if timeRemaining == 0 then
				self._maid._deadlineLoop = nil
			end
		end)
	else
		self:_updateDeadlineUi(0)
	end
end
function Vault._findDoor(self)
	local Door = self._obj:WaitForChild("Door")
	self._doorModel = Door
	BinderUtils.promiseBoundClass(DoorBinder, Door):andThen(function(doorInstance)
		self:_receiveDoor(doorInstance)
	end):catch(warn)
end
function Vault._receiveDoor(self, doorInstance)
	local function preUpdateFun(armPart)
		local isDoorOpen = DoorUtils.getOpen(self._doorModel)
		local isCounting = self:IsCounting()
		local home = self._homeItem:GetHome()
		local shouldShowArmButton
		if home and (home:HasPermissionToEnter(LocalPlayer) and not isCounting) then
			armPart.Name = "Arm"
			shouldShowArmButton = true
		else
			shouldShowArmButton = false
		end
		if self._homeItem:IsBeingDragged() then
			shouldShowArmButton = false
		end
		if not isDoorOpen then
			shouldShowArmButton = false
		end
		armPart.Enabled = shouldShowArmButton
	end
	local function action(armPart, isActivated)
		if isActivated then
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
function Vault.GetIsVaultArmed(self)
	return not DoorUtils.getOpen(self.obj.Door)
end
function Vault.GetArmingTeamId(self)
	return VaultUtils.getArmingTeamId(self.obj)
end
function Vault._updateDeadlineUi(self, timeRemaining)
	local minutesElapsed = math.floor(timeRemaining / 60)
	DoorUtils.getInnerModel(self._obj.Door).Timer.SurfaceGui.TextLabel.Text = ("%02d:%02d"):format(minutesElapsed, timeRemaining % 60)
end
function Vault._onAmountChanged(self)
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
function Vault.GetDeadline(self)
	return self._deadlineValue.Value
end
function Vault.IsCounting(self)
	return self:GetDeadline() > Time.GetNowSync()
end
function Vault.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local instance = Vault.new(self)
		self._maid:GiveTask(instance)
		self._vault = instance
	end
}
