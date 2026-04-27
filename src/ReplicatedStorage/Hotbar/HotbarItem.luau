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
local HotbarItem = {}
HotbarItem.__index = HotbarItem
function HotbarItem.new(self)
	local hotbarItem = {}
	setmetatable(hotbarItem, HotbarItem)
	hotbarItem.obj = self
	hotbarItem._maid = Maid.new()
	if hotbarItem:GetOwner() == Players.LocalPlayer then
		hotbarItem:_setupLocal()
	end
	hotbarItem.lastDroppedAt = 0
	return hotbarItem
end
function HotbarItem.GetOwner(self)
	local player = self.obj.Parent.Parent
	local isParent = player.Parent == game:GetService("Players")
	assert(isParent, "this hotbarItem is not a valid descendant of a player")
	return player
end
function HotbarItem.SetKeyCode(self, keyCode)
	self.keyCode = keyCode
end
function HotbarItem.SetBindText(self, bindText)
	self._frame.Index.Visible = bindText ~= nil
	if bindText then
		self._frame.Index.Text = bindText
	end
end
function HotbarItem.SetDropVisible(self, isVisible)
	assert(typeof(isVisible) == "boolean", "value must be a boolean")
	self._frame.Drop.Visible = isVisible
end
function HotbarItem._setupLocal(self)
	local itemFrame = HotbarItemRes.presetFrame:Clone()
	itemFrame.Parent = HotbarItemRes.gui.Container
	self._frame = itemFrame
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
	self._maid:GiveTask(itemFrame.Drop.MouseButton1Down:Connect(function()
		self:GetInventoryItem():AttemptDrop()
		self.lastDroppedAt = os.clock()
	end))
end
function HotbarItem._setupDisplayOrder(self)
	local function update()
		self._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(self.obj) or 0
	end
	self._frame.LayoutOrder = HotbarItemUtils.getDisplayOrder(self.obj) or 0
	self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(update))
end
function HotbarItem._setupImageSrc(self)
	local function update()
		self._frame.Icon.Image = HotbarItemUtils.getImageSrc(self.obj) or ""
	end
	self._frame.Icon.Image = HotbarItemUtils.getImageSrc(self.obj) or ""
	self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.IMAGE_SRC_ATTR_NAME):Connect(update))
end
function HotbarItem._setupDragging(self)
	self._maid:GiveTask(self._frame.MouseButton1Down:Connect(function()
		self:_onPressStarted()
	end))
	self._maid:GiveTask(self._frame.MouseButton1Up:Connect(function()
		self:_onPressEnded()
	end))
end
function HotbarItem._onPressStarted(self)
	local newPressCounter = (self._pressCounter or 0) + 1
	self._pressCounter = newPressCounter
	self._pressCounterAtStart = self._pressCounter
	task.delay(HotbarItemConsts.MIN_DRAG_DURATION, function()
		if self._pressCounter == newPressCounter then
			self._pressCounter = self._pressCounter + 1
			self.onDragStarted:Fire()
		end
	end)
end
function HotbarItem._onPressEnded(self)
	if os.clock() - self.lastDroppedAt < 0.1 then
	elseif self._pressCounter == self._pressCounterAtStart then
		self._pressCounter = (self._pressCounter or 0) + 1
		self:GetInventoryItem():AttemptSelect()
	end
end
function HotbarItem.GetInventoryItem(self)
	return InventoryItemBinder:Get(self.obj)
end
function HotbarItem.SetSize(self, targetSize)
	self.sizeSpring:SetTarget(targetSize)
	self._maid.springHeartbeat = RunService.Heartbeat:Connect(function()
		local sizeValue, sizeVelocity = self.sizeSpring:Update()
		if math.abs(targetSize - sizeValue) < 0.001 and math.abs(sizeVelocity) < 0.001 then
			self._maid.springHeartbeat = nil
			sizeValue = targetSize
		end
		self._frame.Size = UDim2.new(sizeValue, 0, sizeValue, 0)
	end)
end
function HotbarItem.Spin(self)
	self.spinSpring:SetTarget(360)
	self.spinSpring.p = 0
	self._maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local rotationValue, rotationVelocity = self.spinSpring:Update()
		if math.abs(360 - rotationValue) < 0.001 and math.abs(rotationVelocity) < 0.001 then
			self._maid.spinHeartbeat = nil
			rotationValue = 0
		end
		self._frame.Icon.Rotation = rotationValue
	end)
end
function HotbarItem.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return HotbarItem
