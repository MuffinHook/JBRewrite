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
function t.new(p1) --[[ Line: 14 | Upvalues: t (copy), Maid (copy), Signal (copy), InventoryItemUtils (copy), RxInstanceUtils (copy), InventoryItemConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	t2._maid = Maid.new()
	t2.onAttemptSelect = Signal.new()
	t2._maid:GiveTask(t2.onAttemptSelect)
	t2.onAttemptDrop = Signal.new()
	t2._maid:GiveTask(t2.onAttemptDrop)
	t2._maid:GiveTask(function() --[[ Line: 25 | Upvalues: InventoryItemUtils (ref), t2 (copy) ]]
		InventoryItemUtils.setEquipped(t2.obj, false)
	end)
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, InventoryItemConsts.EQUIP_REMOTE_NAME, function(p1, p2) --[[ Line: 34 | Upvalues: t2 (copy) ]]
		p2:GiveTask(p1.OnClientEvent:Connect(function() --[[ Line: 35 | Upvalues: t2 (ref) ]]
			t2:AttemptSelect()
		end))
	end))
	local function update() --[[ Line: 42 | Upvalues: p1 (copy), InventoryItemConsts (ref) ]]
		local v1 = p1:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
		if (p1:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < v1 then
			p1:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, v1)
		end
	end
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(InventoryItemConsts.EQUIPPED_ATTR_NAME):Connect(update))
	local v2 = p1:GetAttribute(InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
	if (p1:GetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME) or 0) < v2 then
		p1:SetAttribute(InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME, v2)
	end
	t2._overriddenOwner = nil
	return t2
end
function t.GetName(p1) --[[ Line: 56 | Upvalues: InventoryItemUtils (copy) ]]
	return InventoryItemUtils.getName(p1.obj)
end
function t.GetOwner(p1) --[[ Line: 59 | Upvalues: InventoryItemOwnerBinder (copy) ]]
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
function t.PromiseOwner(p1) --[[ Line: 74 | Upvalues: Promise (copy), InventoryItemOwnerBinder (copy) ]]
	local v1 = p1.obj.Parent.Parent
	if v1 then
		if v1.Parent == game:GetService("Players") then
			return Promise.resolve(v1)
		else
			return InventoryItemOwnerBinder:Promise(v1)
		end
	end
end
function t.GetAttr(p1, ...) --[[ Line: 84 | Upvalues: InventoryItemUtils (copy) ]]
	return InventoryItemUtils.getAttr(p1.obj, ...)
end
function t.SetAttr(p1, ...) --[[ Line: 87 | Upvalues: InventoryItemUtils (copy) ]]
	InventoryItemUtils.setAttr(p1.obj, ...)
end
function t.GetEquipped(p1, ...) --[[ Line: 90 | Upvalues: InventoryItemUtils (copy) ]]
	return InventoryItemUtils.getEquipped(p1.obj, ...)
end
function t.SetEquipped(p1, ...) --[[ Line: 93 | Upvalues: InventoryItemUtils (copy) ]]
	InventoryItemUtils.setEquipped(p1.obj, ...)
end
function t.GetEquippedSignal(p1) --[[ Line: 96 | Upvalues: InventoryItemUtils (copy) ]]
	return InventoryItemUtils.getEquippedSignal(p1.obj)
end
function t.AttemptSetEquipped(p1, p2) --[[ Line: 99 | Upvalues: InventoryItemUtils (copy), InventoryItemConsts (copy) ]]
	assert(p2 ~= nil, "missing value")
	InventoryItemUtils.setEquipped(p1.obj, p2)
	p1.obj:FindFirstChild(InventoryItemConsts.EQUIP_REMOTE_NAME):FireServer(p2)
end
function t.AttemptSelect(p1) --[[ Line: 105 ]]
	p1.onAttemptSelect:Fire()
end
function t.AttemptDrop(p1) --[[ Line: 108 ]]
	p1.onAttemptDrop:Fire()
end
function t.Destroy(p1) --[[ Line: 111 ]]
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return t