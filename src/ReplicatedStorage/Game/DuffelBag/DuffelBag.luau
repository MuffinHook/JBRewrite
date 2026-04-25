-- Reviewed by Claude
-- variables reassigned
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local RobberyMoneyUI = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Settings = require(ReplicatedStorage.Resource.Settings)
local DuffelBagConsts = require(script.Parent.DuffelBagConsts)
local function GetDevProdByTier(p1)
	for i, v in ipairs(Settings.DevProduct) do
		if v.Type == "DuffelBagUpgrade" and v.Tier == p1 then
			return v
		end
	end
end
local t = {}
t.__index = t
function t.new(p1)
	local instance = {}
	setmetatable(instance, t)
	instance._obj = p1
	instance._maid = Maid.new()
	instance._ownerMaid = Maid.new()
	instance._maid:GiveTask(instance._ownerMaid)
	instance._ownerObj = p1:WaitForChild(DuffelBagConsts.OWNER_VALUE_NAME, 2)
	instance._maid:GiveTask(instance._ownerObj.Changed:Connect(function()
		instance:_handleOwner()
	end))
	instance:_handleOwner()
	local function updateParent(p1)
		instance:_handleOwner()
	end
	instance._maid:GiveTask(p1.AncestryChanged:Connect(function(p1, p2)
		instance:_handleOwner()
	end))
	local remoteEvent = p1:WaitForChild(DuffelBagConsts.REMOTE_EVENT_NAME, 2)
	instance._maid:GiveTask(remoteEvent.OnClientEvent:Connect(function(...)
		instance:_onClientEvent(...)
	end))
	instance._remoteEvent = remoteEvent
	instance._robberyEnumValue = p1:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME, 2)
	return instance
end
function t._handleOwner(p1)
	p1._ownerMaid:DoCleaning()
	if p1:IsHeld() and p1:GetOwner() == LocalPlayer then
		RobberyMoneyUI.Show()
		p1._ownerMaid:GiveTask(function()
			RobberyMoneyUI.Hide()
		end)
		local _obj = p1._obj
		local amountValue = _obj:WaitForChild(DuffelBagConsts.AMOUNT_VALUE_NAME)
		local maximumValue = _obj:WaitForChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
		local multValue = _obj:WaitForChild(DuffelBagConsts.MULT_VALUE_NAME)
		local multEnabledValue = _obj:WaitForChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
		local tierValue = _obj:WaitForChild(DuffelBagConsts.TIER_VALUE_NAME)
		local robberyEnumValue = _obj:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME)
		local function setAmountValue()
			p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end
		local formatterValue = _obj:WaitForChild(DuffelBagConsts.FORMATTER_VALUE_NAME)
		p1:_setFormatter(formatterValue.Value)
		p1._ownerMaid:GiveTask(formatterValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setFormatter(formatterValue.Value)
			p1:_setTier(tierValue.Value, multEnabledValue.Value)
			p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		p1._ownerMaid:GiveTask(amountValue:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		p1._ownerMaid:GiveTask(maximumValue:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		local timeValue = _obj:WaitForChild(DuffelBagConsts.TIME_VALUE_NAME)
		p1:_setTime(timeValue.Value)
		p1._ownerMaid:GiveTask(timeValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTime(timeValue.Value)
		end))
		p1:_setTier(tierValue.Value, multEnabledValue.Value)
		p1._ownerMaid:GiveTask(tierValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTier(tierValue.Value, multEnabledValue.Value)
			p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		p1._ownerMaid:GiveTask(multValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		p1._ownerMaid:GiveTask(multEnabledValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTier(tierValue.Value, multEnabledValue.Value)
			p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
		end))
		local messageValue = _obj:WaitForChild(DuffelBagConsts.MESSAGE_VALUE_NAME)
		p1:_setMessage(messageValue.Value)
		p1._ownerMaid:GiveTask(messageValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setMessage(messageValue.Value)
		end))
		p1._ownerMaid:GiveTask(RobberyMoneyUI.getUpgradeButton().MouseButton1Down:Connect(function()
			local nextTier = tierValue.Value + 1
			local devProduct = nil
			for i, v in ipairs(Settings.DevProduct) do
				if v.Type == "DuffelBagUpgrade" and v.Tier == nextTier then
					devProduct = v
					break
				end
			end
			assert(devProduct)
			MarketplaceService:PromptProductPurchase(LocalPlayer, devProduct.Id)
		end))
		p1:_setRobbery(robberyEnumValue.Value)
		p1._ownerMaid:GiveTask(robberyEnumValue:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setRobbery(robberyEnumValue.Value)
		end))
		p1:_setAmount(amountValue.Value, multEnabledValue.Value and math.ceil(maximumValue.Value * multValue.Value) or maximumValue.Value)
	end
end
function t._setAmount(p1, p2, p3)
	RobberyMoneyUI.SetMoney(p2, p3)
end
function t._setFormatter(p1, p2)
	RobberyMoneyUI.SetFormatter((assert(RobberyMoneyUI.Formatter[p2])))
end
function t._setTime(p1, p2)
	if p2 <= 0.001 then
		p2 = nil
	end
	RobberyMoneyUI.SetTime(p2)
end
function t._setTier(p1, p2, p3)
	assert(p2 ~= nil)
	assert(p3 ~= nil)
	RobberyMoneyUI.SetTier(p2, p3)
end
function t._setMessage(p1, p2)
	RobberyMoneyUI.SetMessage(p2)
end
function t._setRobbery(p1, p2)
	RobberyMoneyUI.SetRobbery(p2)
end
function t._onClientEvent(p1, p2)
	if p2 == DuffelBagConsts.net.PLAY_AWARD_SOUND then
		Audio.ObjectLocal(script, 1988476450)
	end
end
function t.IsHeld(p1)
	return p1:GetOwner() and p1._obj:IsDescendantOf(Players)
end
function t.GetOwner(p1)
	return p1._ownerObj.Value
end
function t.GetRobbery(p1)
	return p1._robberyEnumValue.Value
end
function t.GetRobberyChangedSignal(p1)
	return p1._robberyEnumValue.Changed
end
function t.Destroy(p1)
	p1._maid:Destroy()
	p1._maid = nil
end
return t
