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
local HomeSaleUISystem = require(script.Parent.HomeUI.HomeSaleUISystem)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Game.GameUtil)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)

local HomeItemBinder = nil

local Home = {}
Home.__index = Home
Home.__ClassName = "Home"

function Home.new(homeObj)
	local self = setmetatable({}, Home)

	self._maid = Maid.new()
	self._obj = homeObj

	self._priceValue = homeObj:WaitForChild(HomeConsts.PRICE_VALUE_NAME)
	self._homeItemNewRemote = homeObj:WaitForChild(HomeConsts.HOME_ITEM_NEW_REMOTE_NAME)
	self._homePurchaseRemote = homeObj:WaitForChild(HomeConsts.HOME_PURCHASE_REMOTE_NAME)
	self._doorInteractRemote = homeObj:WaitForChild(HomeConsts.DOOR_INTERACT_REMOTE_NAME)
	self._updateCustomizingRemote = homeObj:WaitForChild(HomeConsts.UPDATE_CUSTOMIZING_REMOTE_NAME)
	self._homeClaimRemote = homeObj:WaitForChild(HomeConsts.HOME_CLAIM_REMOTE_NAME)
	self._homeUnclaimRemote = homeObj:WaitForChild(HomeConsts.HOME_UNCLAIM_REMOTE_NAME)
	self._permissionsFolder = homeObj:WaitForChild(HomeConsts.PERMISSIONS_FOLDER_NAME)
	self._setSavedSettingRemote = homeObj:WaitForChild(HomeConsts.SET_SAVED_SETTING_REMOTE_NAME)

	local function ownsHome()
		local folder = LocalPlayer:FindFirstChild(HomeConsts.HOMES_OWNED_FOLDER_NAME)
		if not folder then
			error("Player does not have a homes owned folder")
		end
		return folder:FindFirstChild(self._obj.Name) ~= nil
	end

	local sign = homeObj:WaitForChild("SaleSign"):WaitForChild("Sign")

	CircleAction.Add({
		Part = sign,
		Name = "Buy",
		NoRay = true,
		Timed = false,
		Dist = 16,

		Callback = function(_, activated)
			if not activated then
				return false
			end

			local ownerId = self:GetOwnerId()

			if ownerId == nil then
				if ownsHome() then
					self._homeClaimRemote:FireServer()
				else
					HomeSaleUISystem.setPrice(self._priceValue.Value)
					HomeSaleUISystem.open()

					self._maid._onSaleYes = HomeSaleUISystem.getOnClickYesSignal():Connect(function()
						HomeSaleUISystem.close()
						self._homePurchaseRemote:FireServer()
					end)

					self._maid._onSaleNo = HomeSaleUISystem.getOnClickNoSignal():Connect(function()
						HomeSaleUISystem.close()
					end)

					self._maid._onClosed = HomeSaleUISystem.getOnClosedSignal():Connect(function()
						self._maid._onClosed = nil
						self._maid._onSaleYes = nil
						self._maid._onSaleNo = nil
					end)
				end

			elseif ownerId == LocalPlayer.UserId then
				local confirm = Confirmation.new("Unclaim home? You will still own it, but will have to claim the land again.")
				self._maid._confirm = confirm

				confirm.Maid:GiveTask(confirm.OnYes:Connect(function()
					self._homeUnclaimRemote:FireServer()
					self._maid._confirm = nil
				end))

				confirm.Maid:GiveTask(confirm.OnNo:Connect(function()
					self._maid._confirm = nil
				end))
			end

			return true
		end,

		PreUpdateFun = function(action)
			local enabled = false
			local name = nil

			if not HomeSaleUISystem.isOpen() then
				local ownerId = self:GetOwnerId()

				if ownerId == nil then
					enabled = true
					name = ownsHome() and "Claim" or "Buy"
				elseif ownerId == LocalPlayer.UserId then
					enabled = true
					name = "Unclaim"
				end
			end

			action.Enabled = enabled
			action.Name = name
		end,

		PreUpdatePeriod = 0.1
	}, sign)

	self._maid:GiveTask(function()
		CircleAction.Remove(sign)
	end)

	self._maid:GiveTask(RxInstanceUtils.observeChildrenNamed(self._obj, "Door", function(doorModel)
		self:_receiveDoorModel(doorModel)
	end))

	return self
end

function Home:_receiveDoorModel(doorModel)
	local door = DoorUtils.getInnerModel(doorModel):FindFirstChild("Door")
	assert(door)

	CircleAction.Add({
		Part = door,
		Name = "Open",
		NoRay = true,
		Timed = false,
		Dist = 10,

		Callback = function(action, activated)
			if activated then
				self._doorInteractRemote:FireServer(doorModel, true)
				return true
			elseif action.Timed then
				self._doorInteractRemote:FireServer(doorModel, false)
			end
			return false
		end,

		PreUpdateFun = function(action)
			local root = PlayerUtils.getRootPart(LocalPlayer)
			if not root then
				return
			end

			local isInside = self:IsPointInStandingPrism(root.Position)

			if self:HasPermissionToEnter(LocalPlayer) or isInside then
				action.Enabled = true
				action.Timed = false
				action.Name = DoorUtils.getOpen(doorModel) ~= 0 and "Close" or "Open"
			else
				local ownerId = self:GetOwnerId()
				local ownerPlayer = ownerId and Players:GetPlayerByUserId(ownerId)
				local ownerTeam = ownerPlayer and PlayerUtils.getTeamId(ownerPlayer)

				if ownerId ~= nil and ownerTeam ~= PlayerUtils.getTeamId(LocalPlayer) then
					action.Enabled = true
					action.Timed = true
					action.Duration = HomeConsts.POLICE_BUST_DOOR_DURATION
					action.Name = "Break In"
				else
					action.Enabled = false
				end
			end
		end,

		PreUpdatePeriod = 0.5
	}, door)

	self._maid:GiveTask(function()
		CircleAction.Remove(door)
	end)
end

function Home:GetObj()
	return self._obj
end

function Home:GetHomeItems()
	if not HomeItemBinder then
		HomeItemBinder = require(script.Parent.HomeItem.HomeItemBinder)
	end

	return BinderUtils.getChildren(HomeItemBinder, self._obj)
end

function Home:AttemptCreateHomeItem(data)
	assert(data ~= nil)
	self._homeItemNewRemote:FireServer(data)
end

function Home:GetSurfaces()
	return BinderUtils.getDescendants(SurfaceBinder, self._obj)
end

function Home:IsPointInStandingPrism(point)
	for _, surface in ipairs(self:GetSurfaces()) do
		local cf, size = surface:GetStandingPrism()

		if cf.UpVector:Dot(Vector3.new(0, 1, 0)) >= -0.5 then
			local localPoint = cf:pointToObjectSpace(point) + size * 0.5

			if localPoint.X >= 0 and localPoint.X <= size.X
			and localPoint.Y >= 0 and localPoint.Y <= size.Y
			and localPoint.Z >= 0 and localPoint.Z <= size.Z then
				return true
			end
		end
	end

	return false
end

function Home:GetArmedVault()
	for _, item in ipairs(self:GetHomeItems()) do
		local vault = item._vault
		if vault and vault:GetIsVaultArmed() then
			return vault
		end
	end
	return nil
end

function Home:ReplicateCustomizing(data)
	self._updateCustomizingRemote:FireServer(data)
end

function Home:GetOwnerId()
	return self._obj:GetAttribute(HomeConsts.OWNER_ID_ATTR_NAME)
end

function Home:_getPlayerPermObj(player)
	return self._permissionsFolder:FindFirstChild(tostring(player.UserId))
end

function Home:HasPermissionToEnter(player)
	local obj = self:_getPlayerPermObj(player)
	return obj and obj:GetAttribute(HomeConsts.PERMISSION_CAN_ENTER_ATTR_NAME) == true or false
end

function Home:HasPermissionToEdit(player)
	local obj = self:_getPlayerPermObj(player)
	return obj and obj:GetAttribute(HomeConsts.PERMISSION_CAN_EDIT_ATTR_NAME) == true or false
end

function Home:SetSavedSetting(key, value)
	self._setSavedSettingRemote:FireServer(key, value)
end

function Home:Destroy()
	local maid = self._maid
	assert(maid ~= nil)

	self._maid = nil
	maid:Destroy()
end

return Home