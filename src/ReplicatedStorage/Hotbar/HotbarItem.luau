local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Spring = require(ReplicatedStorage.Std.Spring)
local HotbarItemConsts = require(script.Parent.HotbarItemConsts)
local HotbarItemRes = require(script.Parent.HotbarItemRes)
local HotbarItemUtils = require(script.Parent.HotbarItemUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 17 | Upvalues: t (copy), Maid (copy), Players (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	t2._maid = Maid.new()
	if t2:GetOwner() == Players.LocalPlayer then
		t2:_setupLocal()
	end
	t2.lastDroppedAt = 0
	return t2
end
function t.GetOwner(p1) --[[ Line: 34 ]]
	local v1 = p1.obj.Parent.Parent
	local isParent = v1.Parent == game:GetService("Players")
	assert(isParent, "this hotbarItem is not a valid descendant of a player")
	return v1
end
function t.SetKeyCode(p1, p2) --[[ Line: 39 ]]
	p1.keyCode = p2
end
function t.SetBindText(p1, p2) --[[ Line: 42 ]]
	p1._frame.Index.Visible = p2 ~= nil
	if p2 then
		p1._frame.Index.Text = p2
	end
end
function t.SetDropVisible(p1, p2) --[[ Line: 48 ]]
	assert(typeof(p2) == "boolean", "value must be a boolean")
	p1._frame.Drop.Visible = p2
end
function t._setupLocal(p1) --[[ Line: 52 | Upvalues: HotbarItemRes (copy), Signal (copy), Spring (copy), InventoryItemUtils (copy) ]]
	local v1 = HotbarItemRes.presetFrame:Clone()
	v1.Parent = HotbarItemRes.gui.Container
	p1._frame = v1
	p1._maid:GiveTask(p1._frame)
	p1:_setupDisplayOrder()
	p1:_setupImageSrc()
	p1:_setupDragging()
	p1.onDragStarted = Signal.new()
	p1._maid:GiveTask(p1.onDragStarted)
	p1.sizeSpring = Spring.new(1, 0, 0.5, 50)
	p1.spinSpring = Spring.new(0, 0, 0.8, 20)
	local function handleEquipped() --[[ Line: 67 | Upvalues: InventoryItemUtils (ref), p1 (copy) ]]
		p1._frame.ImageTransparency = if InventoryItemUtils.getEquipped(p1.obj) then 0.5 else 0
	end
	p1._maid:GiveTask(InventoryItemUtils.getEquippedSignal(p1.obj):Connect(handleEquipped))
	p1._frame.ImageTransparency = if InventoryItemUtils.getEquipped(p1.obj) then 0.5 else 0
	p1._maid:GiveTask(v1.Drop.MouseButton1Down:Connect(function() --[[ Line: 74 | Upvalues: p1 (copy) ]]
		p1:GetInventoryItem():AttemptDrop()
		p1.lastDroppedAt = os.clock()
	end))
end
function t._setupDisplayOrder(p1) --[[ Line: 79 | Upvalues: HotbarItemUtils (copy), HotbarItemConsts (copy) ]]
	local function update() --[[ Line: 80 | Upvalues: HotbarItemUtils (ref), p1 (copy) ]]
		p1._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(p1.obj) or 0
	end
	p1._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(p1.obj) or 0
	p1._maid:GiveTask(p1.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(update))
end
function t._setupImageSrc(p1) --[[ Line: 87 | Upvalues: HotbarItemUtils (copy), HotbarItemConsts (copy) ]]
	local function update() --[[ Line: 88 | Upvalues: HotbarItemUtils (ref), p1 (copy) ]]
		p1._frame.Icon.Image = HotbarItemUtils.getImageSrc(p1.obj) or ""
	end
	p1._frame.Icon.Image = HotbarItemUtils.getImageSrc(p1.obj) or ""
	p1._maid:GiveTask(p1.obj:GetAttributeChangedSignal(HotbarItemConsts.IMAGE_SRC_ATTR_NAME):Connect(update))
end
function t._setupDragging(p1) --[[ Line: 95 ]]
	p1._maid:GiveTask(p1._frame.MouseButton1Down:Connect(function() --[[ Line: 96 | Upvalues: p1 (copy) ]]
		p1:_onPressStarted()
	end))
	p1._maid:GiveTask(p1._frame.MouseButton1Up:Connect(function() --[[ Line: 99 | Upvalues: p1 (copy) ]]
		p1:_onPressEnded()
	end))
end
function t._onPressStarted(p1) --[[ Line: 103 | Upvalues: HotbarItemConsts (copy) ]]
	local v1 = (p1._pressCounter or 0) + 1
	p1._pressCounter = v1
	p1._pressCounterAtStart = p1._pressCounter
	task.delay(HotbarItemConsts.MIN_DRAG_DURATION, function() --[[ Line: 108 | Upvalues: p1 (copy), v1 (copy) ]]
		if p1._pressCounter == v1 then
			p1._pressCounter = p1._pressCounter + 1
			p1.onDragStarted:Fire()
		end
	end)
end
function t._onPressEnded(p1) --[[ Line: 116 ]]
	if os.clock() - p1.lastDroppedAt < 0.1 then
	elseif p1._pressCounter == p1._pressCounterAtStart then
		p1._pressCounter = (p1._pressCounter or 0) + 1
		p1:GetInventoryItem():AttemptSelect()
	end
end
function t.GetInventoryItem(p1) --[[ Line: 128 | Upvalues: InventoryItemBinder (copy) ]]
	return InventoryItemBinder:Get(p1.obj)
end
function t.SetSize(p1, p2) --[[ Line: 131 | Upvalues: RunService (copy) ]]
	p1.sizeSpring:SetTarget(p2)
	p1._maid.springHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 133 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1, v2 = p1.sizeSpring:Update()
		if math.abs(p2 - v1) < 0.001 and math.abs(v2) < 0.001 then
			p1._maid.springHeartbeat = nil
			v1 = p2
		end
		p1._frame.Size = UDim2.new(v1, 0, v1, 0)
	end)
end
function t.Spin(p1) --[[ Line: 142 | Upvalues: RunService (copy) ]]
	p1.spinSpring:SetTarget(360)
	p1.spinSpring.p = 0
	p1._maid.spinHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 146 | Upvalues: p1 (copy) ]]
		local v1, v2 = p1.spinSpring:Update()
		if math.abs(360 - v1) < 0.001 and math.abs(v2) < 0.001 then
			p1._maid.spinHeartbeat = nil
			v1 = 0
		end
		p1._frame.Icon.Rotation = v1
	end)
end
function t.Destroy(p1) --[[ Line: 155 ]]
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return t