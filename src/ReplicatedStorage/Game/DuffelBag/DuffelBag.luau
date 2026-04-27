local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local RobberyMoneyUI = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Settings = require(ReplicatedStorage.Resource.Settings)
local DuffelBagConsts = require(script.Parent.DuffelBagConsts)
local function GetDevProdByTier(tier)
	for i, product in ipairs(Settings.DevProduct) do
		if product.Type == "DuffelBagUpgrade" and product.Tier == tier then
			return product
		end
	end
end
local DuffelBag = {}
DuffelBag.__index = DuffelBag
function DuffelBag.new(duffelBagObject)
	local instance = {}
	setmetatable(instance, DuffelBag)
	instance._obj = duffelBagObject
	instance._maid = Maid.new()
	instance._ownerMaid = Maid.new()
	instance._maid:GiveTask(instance._ownerMaid)
	instance._ownerObj = duffelBagObject:WaitForChild(DuffelBagConsts.OWNER_VALUE_NAME, 2)
	instance._maid:GiveTask(instance._ownerObj.Changed:Connect(function()
		instance:_handleOwner()
	end))
	instance:_handleOwner()
	local function updateParent(parent)
		instance:_handleOwner()
	end
	instance._maid:GiveTask(duffelBagObject.AncestryChanged:Connect(function(parent, grandparent)
		instance:_handleOwner()
	end))
	local remoteEvent = duffelBagObject:WaitForChild(DuffelBagConsts.REMOTE_EVENT_NAME, 2)
	instance._maid:GiveTask(remoteEvent.OnClientEvent:Connect(function(...)
		instance:_onClientEvent(...)
	end))
	instance._remoteEvent = remoteEvent
	instance._robberyEnumValue = duffelBagObject:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME, 2)
	return instance
end
function DuffelBag._handleOwner(self)
	self._ownerMaid:DoCleaning()
	if self:IsHeld() and self:GetOwner() == LocalPlayer then
		RobberyMoneyUI.Show()
		self._ownerMaid:GiveTask(function()
			RobberyMoneyUI.Hide()
		end)
		local _obj = self._obj
		local amountValue = _obj:WaitForChild(DuffelBagConsts.AMOUNT_VALUE_NAME)
		local maximumValue = _obj:WaitForChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
		local multValue = _obj:WaitForChild(DuffelBagConsts.MULT_VALUE_NAME)
		local multEnabledValue = _obj:WaitForChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
		local tierValue = _obj:WaitForChild(DuffelBagConsts.TIER_VALUE_NAME)
		local robberyEnumValue = _obj:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME)
		local function setAmountValue()
			self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end
		local formatterValue = _obj:WaitForChild(DuffelBagConsts.FORMATTER_VALUE_NAME)
		self:_setFormatter(formatterValue.Value)
		self._ownerMaid:GiveTask(formatterValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setFormatter(formatterValue.Value)
			self:_setTier(tierValue.Value, multEnabledValue.Value)
			self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		self._ownerMaid:GiveTask(amountValue:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		self._ownerMaid:GiveTask(maximumValue:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		local timeValue = _obj:WaitForChild(DuffelBagConsts.TIME_VALUE_NAME)
		self:_setTime(timeValue.Value)
		self._ownerMaid:GiveTask(timeValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setTime(timeValue.Value)
		end))
		self:_setTier(tierValue.Value, multEnabledValue.Value)
		self._ownerMaid:GiveTask(tierValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setTier(tierValue.Value, multEnabledValue.Value)
			self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		self._ownerMaid:GiveTask(multValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		self._ownerMaid:GiveTask(multEnabledValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setTier(tierValue.Value, multEnabledValue.Value)
			self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		local messageValue = _obj:WaitForChild(DuffelBagConsts.MESSAGE_VALUE_NAME)
		self:_setMessage(messageValue.Value)
		self._ownerMaid:GiveTask(messageValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setMessage(messageValue.Value)
		end))
		self._ownerMaid:GiveTask(RobberyMoneyUI.getUpgradeButton().MouseButton1Down:Connect(function()
			local nextTier = tierValue.Value + 1
			local devProduct = nil
			for i, product in ipairs(Settings.DevProduct) do
				if product.Type == "DuffelBagUpgrade" and product.Tier == nextTier then
					devProduct = product
					break
				end
			end
			assert(devProduct)
			MarketplaceService:PromptProductPurchase(LocalPlayer, devProduct.Id)
		end))
		self:_setRobbery(robberyEnumValue.Value)
		self._ownerMaid:GiveTask(robberyEnumValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:_setRobbery(robberyEnumValue.Value)
		end))
		self:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
	end
end
function DuffelBag._setAmount(self, currentAmount, maximumAmount)
	RobberyMoneyUI.SetMoney(currentAmount, maximumAmount)
end
function DuffelBag._setFormatter(self, formatterValue)
	RobberyMoneyUI.SetFormatter((assert(RobberyMoneyUI.Formatter[formatterValue])))
end
function DuffelBag._setTime(self, timeValue)
	if timeValue <= 0.001 then
		timeValue = nil
	end
	RobberyMoneyUI.SetTime(timeValue)
end
function DuffelBag._setTier(self, tier, multEnabled)
	assert(tier ~= nil)
	assert(multEnabled ~= nil)
	RobberyMoneyUI.SetTier(tier, multEnabled)
end
function DuffelBag._setMessage(self, messageValue)
	RobberyMoneyUI.SetMessage(messageValue)
end
function DuffelBag._setRobbery(self, robberyValue)
	RobberyMoneyUI.SetRobbery(robberyValue)
end
function DuffelBag._onClientEvent(self, eventType)
	if eventType == DuffelBagConsts.net.PLAY_AWARD_SOUND then
		Audio.ObjectLocal(script, 1988476450)
	end
end
function DuffelBag.IsHeld(self)
	return self:GetOwner() and self._obj:IsDescendantOf(Players)
end
function DuffelBag.GetOwner(self)
	return self._ownerObj.Value
end
function DuffelBag.GetRobbery(self)
	return self._robberyEnumValue.Value
end
function DuffelBag.GetRobberyChangedSignal(self)
	return self._robberyEnumValue.Changed
end
function DuffelBag.Destroy(self)
	self._maid:Destroy()
	self._maid = nil
end
return DuffelBag
