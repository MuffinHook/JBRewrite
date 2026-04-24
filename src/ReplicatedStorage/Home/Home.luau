-- Reviewed by Claude
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local SurfaceBinder = require(script.Parent.Surface.SurfaceBinder)
local HomeConsts = require(script.Parent.HomeConsts)
local localPlayer = nil
local HomeSaleUISystem = require(script.Parent.HomeUI.HomeSaleUISystem)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Game.GameUtil)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local function isPointInPrism(point, cframe, size)
	local localPoint = cframe:pointToObjectSpace(point) + size * 0.5
	return if localPoint.x >= 0 and (localPoint.x <= size.x and (localPoint.y >= 0 and (localPoint.y <= size.y and localPoint.z >= 0))) then localPoint.z <= size.z else false
end
local t = {}
t.__index = t
t.__ClassName = "Home"
function t.new(homeObj)
	local self = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = self
	t2._priceValue = self:WaitForChild(HomeConsts.PRICE_VALUE_NAME)
	t2._homeItemNewRemote = self:WaitForChild(HomeConsts.HOME_ITEM_NEW_REMOTE_NAME)
	t2._homePurchaseRemote = self:WaitForChild(HomeConsts.HOME_PURCHASE_REMOTE_NAME)
	t2._doorInteractRemote = self:WaitForChild(HomeConsts.DOOR_INTERACT_REMOTE_NAME)
	t2._updateCustomizingRemote = self:WaitForChild(HomeConsts.UPDATE_CUSTOMIZING_REMOTE_NAME)
	t2._homeClaimRemote = self:WaitForChild(HomeConsts.HOME_CLAIM_REMOTE_NAME)
	t2._homeUnclaimRemote = self:WaitForChild(HomeConsts.HOME_UNCLAIM_REMOTE_NAME)
	t2._permissionsFolder = self:WaitForChild(HomeConsts.PERMISSIONS_FOLDER_NAME)
	t2._setSavedSettingRemote = self:WaitForChild(HomeConsts.SET_SAVED_SETTING_REMOTE_NAME)
	local function doIOwnThisHomeName()
		local localPlayer = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
		if localPlayer then
			return localPlayer:FindFirstChild(t2._obj.Name) ~= nil
		end
		error("Player does not have a homes owned folder")
	end
	local Sign = t2._obj:WaitForChild("SaleSign"):WaitForChild("Sign")
	CircleAction.Add({
		Part = Sign,
		Name = "Buy",
		NoRay = true,
		Timed = false,
		Dist = 16,
		Callback = function(self, p2)
			if p2 then
				if t2:GetOwnerId() == nil then
					local localPlayer = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
					local localPlayer
					if localPlayer then
						localPlayer = localPlayer:FindFirstChild(t2._obj.Name) ~= nil
					else
						error("Player does not have a homes owned folder")
					end
					if localPlayer then
						t2._homeClaimRemote:FireServer()
					else
						HomeSaleUISystem.setPrice(t2._priceValue.Value)
						HomeSaleUISystem.open()
						t2._maid._onSaleYes = HomeSaleUISystem.getOnClickYesSignal():Connect(function()
							HomeSaleUISystem.close()
							t2._homePurchaseRemote:FireServer()
						end)
						t2._maid._onSaleNo = HomeSaleUISystem.getOnClickNoSignal():Connect(function()
							HomeSaleUISystem.close()
						end)
						t2._maid._onClosed = HomeSaleUISystem.getOnClosedSignal():Connect(function()
							t2._maid._onClosed = nil
							t2._maid._onSaleYes = nil
							t2._maid._onSaleNo = nil
						end)
					end
				elseif t2:GetOwnerId() == LocalPlayer.UserId then
					local instance4 = Confirmation.new("Unclaim home? You will still own it, but will have to claim the land again.")
					t2._maid._confirm = instance4
					instance4.Maid:GiveTask(instance4.OnYes:Connect(function()
						t2._homeUnclaimRemote:FireServer()
						t2._maid._confirm = nil
					end))
					instance4.Maid:GiveTask(instance4.OnNo:Connect(function()
						t2._maid._confirm = nil
					end))
				end
				return true
			else
				return false
			end
		end,
		PreUpdateFun = function(self)
			local localPlayer = false
			local localPlayer = nil
			if not HomeSaleUISystem.isOpen() then
				if t2:GetOwnerId() == nil then
					localPlayer = true
					local localPlayer = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
					local instance4
					if localPlayer then
						instance4 = localPlayer:FindFirstChild(t2._obj.Name) ~= nil
					else
						error("Player does not have a homes owned folder")
					end
					localPlayer = if instance4 then "Claim" else "Buy"
				elseif t2:GetOwnerId() == LocalPlayer.UserId then
					localPlayer = true
					localPlayer = "Unclaim"
				end
			end
			self.Enabled = localPlayer
			self.Name = localPlayer
		end,
		PreUpdatePeriod = 0.1
	}, Sign)
	t2._maid:GiveTask(function()
		CircleAction.Remove(Sign)
	end)
	t2._maid:GiveTask(RxInstanceUtils.observeChildrenNamed(t2._obj, "Door", function(self, p2)
		t2:_receiveDoorModel(self)
	end))
	return t2
end
function t._receiveDoorModel(self, p2)
	local Door = DoorUtils.getInnerModel(p2):FindFirstChild("Door")
	assert(Door)
	CircleAction.Add({
		Part = Door,
		Name = "Open",
		NoRay = true,
		Timed = false,
		Dist = 10,
		Callback = function(p12, p22)
			if p22 then
				self._doorInteractRemote:FireServer(p2, true)
				return true
			else
				if p12.Timed then
					self._doorInteractRemote:FireServer(p2, false)
				end
				return false
			end
		end,
		PreUpdateFun = function(p12)
			local localPlayer = DoorUtils.getPctOpen(p2) ~= 0
			local localPlayer = PlayerUtils.getRootPart(LocalPlayer)
			if localPlayer then
				local localPlayer = self:IsPointInStandingPrism(localPlayer.Position)
				local instance4
				if self:HasPermissionToEnter(LocalPlayer) or localPlayer then
					instance4 = true
					p12.Timed = false
					p12.Name = if localPlayer then "Close" else "Open"
				else
					local var6 = self:GetOwnerId()
					local localPlayer = var6 and Players:GetPlayerByUserId(var6)
					local var8 = localPlayer and PlayerUtils.getTeamId(localPlayer)
					if var6 == nil or var8 == PlayerUtils.getTeamId(LocalPlayer) then
						instance4 = false
					else
						p12.Timed = true
						p12.Duration = HomeConsts.POLICE_BUST_DOOR_DURATION
						p12.Name = "Break In"
						instance4 = true
					end
				end
				p12.Enabled = instance4
			end
		end,
		PreUpdatePeriod = 0.5
	}, Door)
	self._maid:GiveTask(function()
		CircleAction.Remove(Door)
	end)
end
function t.GetObj(self)
	return self._obj
end
function t.GetHomeItems(self)
	localPlayer = localPlayer or require(script.Parent.HomeItem.HomeItemBinder)
	return BinderUtils.getChildren(localPlayer, self._obj)
end
function t.AttemptCreateHomeItem(self, p2)
	assert(p2 ~= nil)
	self._homeItemNewRemote:FireServer(p2)
end
function t.GetSurfaces(self)
	return BinderUtils.getDescendants(SurfaceBinder, self._obj)
end
function t.IsPointInStandingPrism(self, p2)
	for i, v in ipairs((self:GetSurfaces())) do
		local localPlayer
		local localPlayer, instance4 = v:GetStandingPrism()
		if not (localPlayer.UpVector:Dot(Vector3.new(0, 1, 0)) < -0.5) then
			local var5 = localPlayer:pointToObjectSpace(p2) + instance4 * 0.5
			localPlayer = if var5.x >= 0 and (var5.x <= instance4.x and (var5.y >= 0 and (var5.y <= instance4.y and var5.z >= 0))) then var5.z <= instance4.z else false
			if localPlayer then
				return true
			end
		end
	end
	return false
end
function t.GetArmedVault(self)
	for i, v in ipairs((self:GetHomeItems())) do
		local _vault = v._vault
		if _vault and _vault:GetIsVaultArmed() then
			return _vault
		end
	end
	return nil
end
function t.ReplicateCustomizing(self, p2)
	self._updateCustomizingRemote:FireServer(p2)
end
function t.GetOwnerId(self)
	return self._obj:GetAttribute(HomeConsts.OWNER_ID_ATTR_NAME)
end
function t._getPlayerPermObj(self, p2)
	local localPlayer = self._permissionsFolder:FindFirstChild((tostring(p2.UserId)))
	if localPlayer then
		return localPlayer
	else
		return nil
	end
end
function t.HasPermissionToEnter(self, p2)
	local localPlayer = self:_getPlayerPermObj(p2)
	if localPlayer then
		return localPlayer:GetAttribute(HomeConsts.PERMISSION_CAN_ENTER_ATTR_NAME) == true
	else
		return false
	end
end
function t.HasPermissionToEdit(self, p2)
	local localPlayer = self:_getPlayerPermObj(p2)
	if localPlayer then
		return localPlayer:GetAttribute(HomeConsts.PERMISSION_CAN_EDIT_ATTR_NAME) == true
	else
		return false
	end
end
function t.SetSavedSetting(self, p2, p3)
	self._setSavedSettingRemote:FireServer(p2, p3)
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return t
