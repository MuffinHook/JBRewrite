-- Reviewed by Claude
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
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = p1
	t2._maid = Maid.new()
	t2._ownerMaid = Maid.new()
	t2._maid:GiveTask(t2._ownerMaid)
	t2._ownerObj = p1:WaitForChild(DuffelBagConsts.OWNER_VALUE_NAME, 2)
	t2._maid:GiveTask(t2._ownerObj.Changed:Connect(function()
		t2:_handleOwner()
	end))
	t2:_handleOwner()
	local function updateParent(p1)
		t2:_handleOwner()
	end
	t2._maid:GiveTask(p1.AncestryChanged:Connect(function(p1, p2)
		t2:_handleOwner()
	end))
	local v2 = p1:WaitForChild(DuffelBagConsts.REMOTE_EVENT_NAME, 2)
	t2._maid:GiveTask(v2.OnClientEvent:Connect(function(...)
		t2:_onClientEvent(...)
	end))
	t2._remoteEvent = v2
	t2._robberyEnumValue = p1:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME, 2)
	return t2
end
function t._handleOwner(p1)
	p1._ownerMaid:DoCleaning()
	if p1:IsHeld() and p1:GetOwner() == LocalPlayer then
		RobberyMoneyUI.Show()
		p1._ownerMaid:GiveTask(function()
			RobberyMoneyUI.Hide()
		end)
		local _obj = p1._obj
		local v1 = _obj:WaitForChild(DuffelBagConsts.AMOUNT_VALUE_NAME)
		local v2 = _obj:WaitForChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
		local v3 = _obj:WaitForChild(DuffelBagConsts.MULT_VALUE_NAME)
		local v4 = _obj:WaitForChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
		local v5 = _obj:WaitForChild(DuffelBagConsts.TIER_VALUE_NAME)
		local v6 = _obj:WaitForChild(DuffelBagConsts.ROBBERY_ENUM_VALUE_NAME)
		local function setAmountValue()
			p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
		end
		local v7 = _obj:WaitForChild(DuffelBagConsts.FORMATTER_VALUE_NAME)
		p1:_setFormatter(v7.Value)
		p1._ownerMaid:GiveTask(v7:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setFormatter(v7.Value)
			p1:_setTier(v5.Value, v4.Value)
			p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
		end))
		p1._ownerMaid:GiveTask(v1:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		p1._ownerMaid:GiveTask(v2:GetPropertyChangedSignal("Value"):Connect(setAmountValue))
		local v8 = _obj:WaitForChild(DuffelBagConsts.TIME_VALUE_NAME)
		p1:_setTime(v8.Value)
		p1._ownerMaid:GiveTask(v8:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTime(v8.Value)
		end))
		p1:_setTier(v5.Value, v4.Value)
		p1._ownerMaid:GiveTask(v5:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTier(v5.Value, v4.Value)
			p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
		end))
		p1._ownerMaid:GiveTask(v3:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
		end))
		p1._ownerMaid:GiveTask(v4:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setTier(v5.Value, v4.Value)
			p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
		end))
		local v9 = _obj:WaitForChild(DuffelBagConsts.MESSAGE_VALUE_NAME)
		p1:_setMessage(v9.Value)
		p1._ownerMaid:GiveTask(v9:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setMessage(v9.Value)
		end))
		p1._ownerMaid:GiveTask(RobberyMoneyUI.getUpgradeButton().MouseButton1Down:Connect(function()
			local v1 = v5.Value + 1
			local v2 = nil
			for i, v in ipairs(Settings.DevProduct) do
				if v.Type == "DuffelBagUpgrade" and v.Tier == v1 then
					v2 = v
					break
				end
			end
			assert(v2)
			MarketplaceService:PromptProductPurchase(LocalPlayer, v2.Id)
		end))
		p1:_setRobbery(v6.Value)
		p1._ownerMaid:GiveTask(v6:GetPropertyChangedSignal("Value"):Connect(function()
			p1:_setRobbery(v6.Value)
		end))
		p1:_setAmount(v1.Value, v4.Value and math.ceil(v2.Value * v3.Value) or v2.Value)
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
