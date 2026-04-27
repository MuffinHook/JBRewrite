local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local HotbarItemConsts = require(script.Parent.HotbarItemConsts)
local HotbarItemBinder = require(script.Parent.HotbarItemBinder)
local HotbarItemUtils = require(script.Parent.HotbarItemUtils)
local HotbarItemSystem = {
	isDragging = false
}
function HotbarItemSystem.init()
	require(script.Parent.HotbarItemRes).init()
	local keyCodesList = {
		Enum.KeyCode.One,
		Enum.KeyCode.Two,
		Enum.KeyCode.Three,
		Enum.KeyCode.Four,
		Enum.KeyCode.Five,
		Enum.KeyCode.Six,
		Enum.KeyCode.Seven,
		Enum.KeyCode.Eight,
		Enum.KeyCode.Nine,
		Enum.KeyCode.Zero
	}
	local function updateDisplayOrder()
		if not HotbarItemSystem.isDragging then
			local sortedItems = HotbarItemSystem.getSortedHotbarItemsFor(Players.LocalPlayer)
			for i = 1, #sortedItems do
				local hotbarItem = sortedItems[i]
				if keyCodesList[i] then
					hotbarItem:SetKeyCode(keyCodesList[i])
					hotbarItem:SetBindText(("%d"):format(i))
				else
					hotbarItem:SetKeyCode(nil)
					hotbarItem:SetBindText(nil)
				end
			end
		end
	end
	HotbarItemBinder:GetClassAddedSignal():Connect(function(self)
		if self:GetOwner() == Players.LocalPlayer then
			local function getMaxDisplayOrder(hotbarItemRef)
				local displayOrder = HotbarItemUtils.getDisplayOrder(hotbarItemRef.obj) or 0
				if displayOrder > 50 then
					displayOrder = 0
				end
				return displayOrder
			end
			local maxDisplayOrder = math.max(unpack(TableUtils.map(HotbarItemSystem.getHotbarItemsFor(self:GetOwner()), getMaxDisplayOrder)))
			if not HotbarItemUtils.getDisplayOrder(self.obj) then
				HotbarItemUtils.setDisplayOrder(self.obj, maxDisplayOrder + 1)
			end
			updateDisplayOrder()
			self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(updateDisplayOrder))
			self._maid:GiveTask(self.onDragStarted:Connect(function()
				assert(not HotbarItemSystem.isDragging, "somehow hotbar is already dragging")
				HotbarItemSystem.isDragging = true
				local dragMaid = Maid.new()
				dragMaid:GiveTask(function()
					HotbarItemSystem.isDragging = false
				end)
				self._maid._dragMaid = dragMaid
				local sortedHotbarItems = HotbarItemSystem.getSortedHotbarItemsFor(self:GetOwner())
				local itemCount = #sortedHotbarItems
				self:SetSize(1.2)
				dragMaid:GiveTask(function()
					self:SetSize(1)
					self:Spin()
				end)
				local originalIndex = table.find(sortedHotbarItems, self)
				local targetIndex = originalIndex
				local layoutStartX = self._frame.Parent.UIListLayout.AbsoluteContentSize.X
				local layoutOffsetX = self._frame.Parent.AbsolutePosition.X + self._frame.Parent.AbsoluteSize.X * 0.5 - layoutStartX * 0.5
				local itemWidth = layoutStartX / itemCount
				dragMaid:GiveTask(RunService.Heartbeat:Connect(function()
					targetIndex = math.floor((UserInputService:GetMouseLocation().X - layoutOffsetX) / itemWidth) + 1
					if targetIndex < 1 then
						targetIndex = 1
					elseif itemCount < targetIndex then
						targetIndex = itemCount
					end
					for i, v in ipairs(sortedHotbarItems) do
						HotbarItemUtils.setDisplayOrder(v.obj, HotbarItemUtils.calculateNewIndex(i, originalIndex, targetIndex))
					end
				end))
				dragMaid:GiveTask(UserInputService.InputEnded:Connect(function(inputObject)
					if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or (inputObject.UserInputType == Enum.UserInputType.Touch or inputObject.UserInputType == Enum.UserInputType.Gamepad1) then
						self._maid._dragMaid = nil
						updateDisplayOrder()
					end
				end))
			end))
			self._maid:GiveTask(self:GetInventoryItem():GetEquippedSignal():Connect(function()
				local inventoryItem = self:GetInventoryItem()
				self:SetDropVisible(inventoryItem and inventoryItem:GetEquipped() and true or false)
			end))
			if self:GetInventoryItem():GetEquipped() then
				self:SetDropVisible(self:GetInventoryItem():GetEquipped())
			end
		end
	end)
	HotbarItemBinder:GetClassRemovingSignal():Connect(function(self)
		if self:GetOwner() == Players.LocalPlayer then
			task.defer(updateDisplayOrder)
		end
	end)
	HotbarItemBinder:Start()
	UserInputService.InputBegan:Connect(function(self, isGameProcessed)
		if not isGameProcessed and self.UserInputType == Enum.UserInputType.Keyboard then
			for i, v in ipairs((HotbarItemSystem.getHotbarItemsFor(Players.LocalPlayer))) do
				if self.KeyCode == v.keyCode then
					local inventoryItem = InventoryItemBinder:Get(v.obj)
					assert(inventoryItem, "hotbarItem is somehow not simultaneously inventoryItem")
					inventoryItem:AttemptSelect()
				end
			end
		end
	end)
	UserInputService.InputBegan:Connect(function(self, isGameProcessed)
		if isGameProcessed then
			return false
		end
		if self.UserInputType == Enum.UserInputType.Gamepad1 then
			local direction = nil
			if self.KeyCode == Enum.KeyCode.ButtonL1 then
				direction = -1
			elseif self.KeyCode == Enum.KeyCode.ButtonR1 then
				direction = 1
			end
			if direction then
				local currentItem = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)
				local sortedHotbarItems = HotbarItemSystem.getSortedHotbarItemsFor(Players.LocalPlayer)
				local currentItemRef = currentItem[1]
				local selectedIndex = if direction < 0 then #sortedHotbarItems else 1
				if currentItemRef then
					for i = 1, #sortedHotbarItems do
						if sortedHotbarItems[i].obj == currentItemRef.obj then
							selectedIndex = i
							break
						end
					end
					selectedIndex = selectedIndex + direction
					if selectedIndex <= 0 then
						selectedIndex = 0
					elseif #sortedHotbarItems + 1 <= selectedIndex then
						selectedIndex = #sortedHotbarItems + 1
					end
					InventoryItemSystem.unequipAll()
				end
				if sortedHotbarItems[selectedIndex] then
					InventoryItemSystem.toggleEquip(sortedHotbarItems[selectedIndex]:GetInventoryItem())
				end
			end
		end
	end)
end
function HotbarItemSystem.getHotbarItemsFor(self)
	return TableUtils.filter(HotbarItemBinder:GetAll(), function(hotbarItem)
		return hotbarItem:GetOwner() == self
	end)
end
function HotbarItemSystem.getSortedHotbarItemsFor(self)
	local sortedItems = HotbarItemSystem.getHotbarItemsFor(self)
	table.sort(sortedItems, function(self, otherHotbarItem)
		return (HotbarItemUtils.getDisplayOrder(self.obj) or 0) < (HotbarItemUtils.getDisplayOrder(otherHotbarItem.obj) or 0)
	end)
	return sortedItems
end
return HotbarItemSystem
