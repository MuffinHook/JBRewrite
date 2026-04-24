-- Reviewed by Claude
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
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = self
	t2._maid = Maid.new()
	if t2:GetOwner() == Players.LocalPlayer then
		t2:_setupLocal()
	end
	t2.lastDroppedAt = 0
	return t2
end
function t.GetOwner(self)
	local v1 = self.obj.Parent.Parent
	local isParent = v1.Parent == game:GetService("Players")
	assert(isParent, "this hotbarItem is not a valid descendant of a player")
	return v1
end
function t.SetKeyCode(self, p2)
	self.keyCode = p2
end
function t.SetBindText(self, p2)
	self._frame.Index.Visible = p2 ~= nil
	if p2 then
		self._frame.Index.Text = p2
	end
end
function t.SetDropVisible(self, p2)
	assert(typeof(p2) == "boolean", "value must be a boolean")
	self._frame.Drop.Visible = p2
end
function t._setupLocal(self)
	local v1 = HotbarItemRes.presetFrame:Clone()
	v1.Parent = HotbarItemRes.gui.Container
	self._frame = v1
	self._maid:GiveTask(self._frame)
	self:_setupDisplayOrder()
	self:_setupImageSrc()
	self:_setupDragging()
	self.onDragStarted = Signal.new()
	self._maid:GiveTask(self.onDragStarted)
	self.sizeSpring = Spring.new(1, 0, 0.5, 50)
	self.spinSpring = Spring.new(0, 0, 0.8, 20)
	local function handleEquipped()
		self._frame.ImageTransparency = if InventoryItemUtils.getEquipped(self.obj) then 0.5 else 0
	end
	self._maid:GiveTask(InventoryItemUtils.getEquippedSignal(self.obj):Connect(handleEquipped))
	self._frame.ImageTransparency = if InventoryItemUtils.getEquipped(self.obj) then 0.5 else 0
	self._maid:GiveTask(v1.Drop.MouseButton1Down:Connect(function()
		self:GetInventoryItem():AttemptDrop()
		self.lastDroppedAt = os.clock()
	end))
end
function t._setupDisplayOrder(self)
	local function update()
		self._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(self.obj) or 0
	end
	self._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(self.obj) or 0
	self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(update))
end
function t._setupImageSrc(self)
	local function update()
		self._frame.Icon.Image = HotbarItemUtils.getImageSrc(self.obj) or ""
	end
	self._frame.Icon.Image = HotbarItemUtils.getImageSrc(self.obj) or ""
	self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.IMAGE_SRC_ATTR_NAME):Connect(update))
end
function t._setupDragging(self)
	self._maid:GiveTask(self._frame.MouseButton1Down:Connect(function()
		self:_onPressStarted()
	end))
	self._maid:GiveTask(self._frame.MouseButton1Up:Connect(function()
		self:_onPressEnded()
	end))
end
function t._onPressStarted(self)
	local v1 = (self._pressCounter or 0) + 1
	self._pressCounter = v1
	self._pressCounterAtStart = self._pressCounter
	task.delay(HotbarItemConsts.MIN_DRAG_DURATION, function()
		if self._pressCounter == v1 then
			self._pressCounter = self._pressCounter + 1
			self.onDragStarted:Fire()
		end
	end)
end
function t._onPressEnded(self)
	if os.clock() - self.lastDroppedAt < 0.1 then
	elseif self._pressCounter == self._pressCounterAtStart then
		self._pressCounter = (self._pressCounter or 0) + 1
		self:GetInventoryItem():AttemptSelect()
	end
end
function t.GetInventoryItem(self)
	return InventoryItemBinder:Get(self.obj)
end
function t.SetSize(self, p2)
	self.sizeSpring:SetTarget(p2)
	self._maid.springHeartbeat = RunService.Heartbeat:Connect(function()
		local v1, v2 = self.sizeSpring:Update()
		if math.abs(p2 - v1) < 0.001 and math.abs(v2) < 0.001 then
			self._maid.springHeartbeat = nil
			v1 = p2
		end
		self._frame.Size = UDim2.new(v1, 0, v1, 0)
	end)
end
function t.Spin(self)
	self.spinSpring:SetTarget(360)
	self.spinSpring.p = 0
	self._maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local v1, v2 = self.spinSpring:Update()
		if math.abs(360 - v1) < 0.001 and math.abs(v2) < 0.001 then
			self._maid.spinHeartbeat = nil
			v1 = 0
		end
		self._frame.Icon.Rotation = v1
	end)
end
function t.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return t
