-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Promise = require(ReplicatedStorage.Std.Promise)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local InventoryItemConsts = require(script.Parent.InventoryItemConsts)
local InventoryItemUtils = require(script.Parent.InventoryItemUtils)
local InventoryItemOwnerBinder = require(script.Parent.InventoryItemOwnerBinder)
local t = {}
t.__index = t
function t.new(itemObj)
	local instance = {}
	setmetatable(instance, t)
	instance.obj = itemObj
	instance._maid = Maid.new()
	instance.onAttemptSelect = Signal.new()
	instance._maid:GiveTask(instance.onAttemptSelect)
	instance.onAttemptDrop = Signal.new()
	instance._maid:GiveTask(instance.onAttemptDrop)
	instance._maid:GiveTask(function()
		InventoryItemUtils.setEquipped(instance.obj, false)
	end)
	instance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(itemObj, InventoryItemConsts.EQUIP_REMOTE_NAME, function(remote, maid)
		maid:GiveTask(remote.OnClientEvent:Connect(function()
			instance:AttemptSelect()
		end))
	end))
	local function update()
		local serverEquipped = itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
		if (itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < serverEquipped then
			itemObj:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, serverEquipped)
		end
	end
	instance._maid:GiveTask(itemObj:GetAttributeChangedSignal(InventoryItemConsts.EQUIPPED_ATTR_NAME):Connect(update))
	local serverEquipped = itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
	if (itemObj:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < serverEquipped then
		itemObj:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, serverEquipped)
	end
	instance._overriddenOwner = nil
	return instance
end
function t.GetName(p1)
	return InventoryItemUtils.getName(p1.obj)
end
function t.GetOwner(p1)
	local v1 = p1.obj.Parent.Parent
	if v1 then
		local v2 = InventoryItemOwnerBinder:Get(v1)
		if v2 then
			return v2
		end
		if v1.Parent == game:GetService("Players") then
			return v1
		end
	end
end
function t.PromiseOwner(p1)
	local v1 = p1.obj.Parent.Parent
	if v1 then
		if v1.Parent == game:GetService("Players") then
			return Promise.resolve(v1)
		else
			return InventoryItemOwnerBinder:Promise(v1)
		end
	end
end
function t.GetAttr(p1, ...)
	return InventoryItemUtils.getAttr(p1.obj, ...)
end
function t.SetAttr(p1, ...)
	InventoryItemUtils.setAttr(p1.obj, ...)
end
function t.GetEquipped(p1, ...)
	return InventoryItemUtils.getEquipped(p1.obj, ...)
end
function t.SetEquipped(p1, ...)
	InventoryItemUtils.setEquipped(p1.obj, ...)
end
function t.GetEquippedSignal(p1)
	return InventoryItemUtils.getEquippedSignal(p1.obj)
end
function t.AttemptSetEquipped(p1, p2)
	assert(p2 ~= nil, "missing value")
	InventoryItemUtils.setEquipped(p1.obj, p2)
	p1.obj:FindFirstChild(InventoryItemConsts.EQUIP_REMOTE_NAME):FireServer(p2)
end
function t.AttemptSelect(p1)
	p1.onAttemptSelect:Fire()
end
function t.AttemptDrop(p1)
	p1.onAttemptDrop:Fire()
end
function t.Destroy(p1)
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return t
