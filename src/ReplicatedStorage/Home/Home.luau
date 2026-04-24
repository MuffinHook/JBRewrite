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
local v1 = nil
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
	t2._obj = p1
	t2._priceValue = p1:WaitForChild(HomeConsts.PRICE_VALUE_NAME)
	t2._homeItemNewRemote = p1:WaitForChild(HomeConsts.HOME_ITEM_NEW_REMOTE_NAME)
	t2._homePurchaseRemote = p1:WaitForChild(HomeConsts.HOME_PURCHASE_REMOTE_NAME)
	t2._doorInteractRemote = p1:WaitForChild(HomeConsts.DOOR_INTERACT_REMOTE_NAME)
	t2._updateCustomizingRemote = p1:WaitForChild(HomeConsts.UPDATE_CUSTOMIZING_REMOTE_NAME)
	t2._homeClaimRemote = p1:WaitForChild(HomeConsts.HOME_CLAIM_REMOTE_NAME)
	t2._homeUnclaimRemote = p1:WaitForChild(HomeConsts.HOME_UNCLAIM_REMOTE_NAME)
	t2._permissionsFolder = p1:WaitForChild(HomeConsts.PERMISSIONS_FOLDER_NAME)
	t2._setSavedSettingRemote = p1:WaitForChild(HomeConsts.SET_SAVED_SETTING_REMOTE_NAME)
	local function doIOwnThisHomeName()
		local v1 = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
		if v1 then
			return v1:FindFirstChild(t2._obj.Name) ~= nil
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
		Callback = function(p1, p2)
			if p2 then
				if t2:GetOwnerId() == nil then
					local v1 = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
					local v2
					if v1 then
						v2 = v1:FindFirstChild(t2._obj.Name) ~= nil
					else
						error("Player does not have a homes owned folder")
					end
					if v2 then
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
					local v4 = Confirmation.new("Unclaim home? You will still own it, but will have to claim the land again.")
					t2._maid._confirm = v4
					v4.Maid:GiveTask(v4.OnYes:Connect(function()
						t2._homeUnclaimRemote:FireServer()
						t2._maid._confirm = nil
					end))
					v4.Maid:GiveTask(v4.OnNo:Connect(function()
						t2._maid._confirm = nil
					end))
				end
				return true
			else
				return false
			end
		end,
		PreUpdateFun = function(p1)
			local v1 = false
			local v2 = nil
			if not HomeSaleUISystem.isOpen() then
				if t2:GetOwnerId() == nil then
					v1 = true
					local v3 = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
					local v4
					if v3 then
						v4 = v3:FindFirstChild(t2._obj.Name) ~= nil
					else
						error("Player does not have a homes owned folder")
					end
					v2 = if v4 then "Claim" else "Buy"
				elseif t2:GetOwnerId() == LocalPlayer.UserId then
					v1 = true
					v2 = "Unclaim"
				end
			end
			p1.Enabled = v1
			p1.Name = v2
		end,
		PreUpdatePeriod = 0.1
	}, Sign)
	t2._maid:GiveTask(function()
		CircleAction.Remove(Sign)
	end)
	t2._maid:GiveTask(RxInstanceUtils.observeChildrenNamed(t2._obj, "Door", function(p1, p2)
		t2:_receiveDoorModel(p1)
	end))
	return t2
end
function t._receiveDoorModel(p1, p2)
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
				p1._doorInteractRemote:FireServer(p2, true)
				return true
			else
				if p12.Timed then
					p1._doorInteractRemote:FireServer(p2, false)
				end
				return false
			end
		end,
		PreUpdateFun = function(p12)
			local v1 = DoorUtils.getPctOpen(p2) ~= 0
			local v2 = PlayerUtils.getRootPart(LocalPlayer)
			if v2 then
				local v3 = p1:IsPointInStandingPrism(v2.Position)
				local v4
				if p1:HasPermissionToEnter(LocalPlayer) or v3 then
					v4 = true
					p12.Timed = false
					p12.Name = if v1 then "Close" else "Open"
				else
					local v6 = p1:GetOwnerId()
					local v7 = v6 and Players:GetPlayerByUserId(v6)
					local v8 = v7 and PlayerUtils.getTeamId(v7)
					if v6 == nil or v8 == PlayerUtils.getTeamId(LocalPlayer) then
						v4 = false
					else
						p12.Timed = true
						p12.Duration = HomeConsts.POLICE_BUST_DOOR_DURATION
						p12.Name = "Break In"
						v4 = true
					end
				end
				p12.Enabled = v4
			end
		end,
		PreUpdatePeriod = 0.5
	}, Door)
	p1._maid:GiveTask(function()
		CircleAction.Remove(Door)
	end)
end
function t.GetObj(p1)
	return p1._obj
end
function t.GetHomeItems(p1)
	v1 = v1 or require(script.Parent.HomeItem.HomeItemBinder)
	return BinderUtils.getChildren(v1, p1._obj)
end
function t.AttemptCreateHomeItem(p1, p2)
	assert(p2 ~= nil)
	p1._homeItemNewRemote:FireServer(p2)
end
function t.GetSurfaces(p1)
	return BinderUtils.getDescendants(SurfaceBinder, p1._obj)
end
function t.IsPointInStandingPrism(p1, p2)
	for i, v in ipairs((p1:GetSurfaces())) do
		local v2
		local v3, v4 = v:GetStandingPrism()
		if not (v3.UpVector:Dot(Vector3.new(0, 1, 0)) < -0.5) then
			local v5 = v3:pointToObjectSpace(p2) + v4 * 0.5
			v2 = if v5.x >= 0 and (v5.x <= v4.x and (v5.y >= 0 and (v5.y <= v4.y and v5.z >= 0))) then v5.z <= v4.z else false
			if v2 then
				return true
			end
		end
	end
	return false
end
function t.GetArmedVault(p1)
	for i, v in ipairs((p1:GetHomeItems())) do
		local _vault = v._vault
		if _vault and _vault:GetIsVaultArmed() then
			return _vault
		end
	end
	return nil
end
function t.ReplicateCustomizing(p1, p2)
	p1._updateCustomizingRemote:FireServer(p2)
end
function t.GetOwnerId(p1)
	return p1._obj:GetAttribute(HomeConsts.OWNER_ID_ATTR_NAME)
end
function t._getPlayerPermObj(p1, p2)
	local v1 = p1._permissionsFolder:FindFirstChild((tostring(p2.UserId)))
	if v1 then
		return v1
	else
		return nil
	end
end
function t.HasPermissionToEnter(p1, p2)
	local v1 = p1:_getPlayerPermObj(p2)
	if v1 then
		return v1:GetAttribute(HomeConsts.PERMISSION_CAN_ENTER_ATTR_NAME) == true
	else
		return false
	end
end
function t.HasPermissionToEdit(p1, p2)
	local v1 = p1:_getPlayerPermObj(p2)
	if v1 then
		return v1:GetAttribute(HomeConsts.PERMISSION_CAN_EDIT_ATTR_NAME) == true
	else
		return false
	end
end
function t.SetSavedSetting(p1, p2, p3)
	p1._setSavedSettingRemote:FireServer(p2, p3)
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t
