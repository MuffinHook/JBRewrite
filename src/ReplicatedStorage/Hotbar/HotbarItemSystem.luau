-- Reviewed by Claude
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
local t = {
	isDragging = false
}
function t.init()
	require(script.Parent.HotbarItemRes).init()
	local t2 = {
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
		if not t.isDragging then
			local localPlayer = t.getSortedHotbarItemsFor(Players.LocalPlayer)
			for i = 1, #localPlayer do
				local instance2 = localPlayer[i]
				if t2[i] then
					instance2:SetKeyCode(t2[i])
					instance2:SetBindText(("%d"):format(i))
				else
					instance2:SetKeyCode(nil)
					instance2:SetBindText(nil)
				end
			end
		end
	end
	HotbarItemBinder:GetClassAddedSignal():Connect(function(self)
		if self:GetOwner() == Players.LocalPlayer then
			local function f2(self)
				local localPlayer = HotbarItemUtils.getDisplayOrder(self.obj) or 0
				if localPlayer > 50 then
					localPlayer = 0
				end
				return localPlayer
			end
			local table4 = math.max(unpack(TableUtils.map(t.getHotbarItemsFor(self:GetOwner()), f2)))
			if not HotbarItemUtils.getDisplayOrder(self.obj) then
				HotbarItemUtils.setDisplayOrder(self.obj, table4 + 1)
			end
			updateDisplayOrder()
			self._maid:GiveTask(self.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(updateDisplayOrder))
			self._maid:GiveTask(self.onDragStarted:Connect(function()
				assert(not t.isDragging, "somehow hotbar is already dragging")
				t.isDragging = true
				local instance2 = Maid.new()
				instance2:GiveTask(function()
					t.isDragging = false
				end)
				self._maid._dragMaid = instance2
				local var3 = t.getSortedHotbarItemsFor(self:GetOwner())
				local table4 = #var3
				self:SetSize(1.2)
				instance2:GiveTask(function()
					self:SetSize(1)
					self:Spin()
				end)
				local table5 = table.find(var3, self)
				local var6 = table5
				local X = self._frame.Parent.UIListLayout.AbsoluteContentSize.X
				local var7 = self._frame.Parent.AbsolutePosition.X + self._frame.Parent.AbsoluteSize.X * 0.5 - X * 0.5
				local var8 = X / table4
				instance2:GiveTask(RunService.Heartbeat:Connect(function()
					var6 = math.floor((UserInputService:GetMouseLocation().X - var7) / var8) + 1
					if var6 < 1 then
						var6 = 1
					elseif table4 < var6 then
						var6 = table4
					end
					for i, v in ipairs(var3) do
						HotbarItemUtils.setDisplayOrder(v.obj, HotbarItemUtils.calculateNewIndex(i, table5, var6))
					end
				end))
				instance2:GiveTask(UserInputService.InputEnded:Connect(function(p12)
					if p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.Gamepad1) then
						self._maid._dragMaid = nil
						updateDisplayOrder()
					end
				end))
			end))
			self._maid:GiveTask(self:GetInventoryItem():GetEquippedSignal():Connect(function()
				local localPlayer = self:GetInventoryItem()
				self:SetDropVisible(localPlayer and localPlayer:GetEquipped() and true or false)
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
	UserInputService.InputBegan:Connect(function(self, p2)
		if not p2 and self.UserInputType == Enum.UserInputType.Keyboard then
			for i, v in ipairs((t.getHotbarItemsFor(Players.LocalPlayer))) do
				if self.KeyCode == v.keyCode then
					local instance2 = InventoryItemBinder:Get(v.obj)
					assert(instance2, "hotbarItem is somehow not simultaneously inventoryItem")
					instance2:AttemptSelect()
				end
			end
		end
	end)
	UserInputService.InputBegan:Connect(function(self, p2)
		if p2 then
			return false
		end
		if self.UserInputType == Enum.UserInputType.Gamepad1 then
			local localPlayer = nil
			if self.KeyCode == Enum.KeyCode.ButtonL1 then
				localPlayer = -1
			elseif self.KeyCode == Enum.KeyCode.ButtonR1 then
				localPlayer = 1
			end
			if localPlayer then
				local instance2 = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)
				local var3 = t.getSortedHotbarItemsFor(Players.LocalPlayer)
				local table4 = instance2[1]
				local sum = if localPlayer < 0 then #var3 else 1
				if table4 then
					for i = 1, #var3 do
						if var3[i].obj == table4.obj then
							sum = i
							break
						end
					end
					sum = sum + localPlayer
					if sum <= 0 then
						sum = 0
					elseif #var3 + 1 <= sum then
						sum = #var3 + 1
					end
					InventoryItemSystem.unequipAll()
				end
				if var3[sum] then
					InventoryItemSystem.toggleEquip(var3[sum]:GetInventoryItem())
				end
			end
		end
	end)
end
function t.getHotbarItemsFor(self)
	return TableUtils.filter(HotbarItemBinder:GetAll(), function(p12)
		return p12:GetOwner() == self
	end)
end
function t.getSortedHotbarItemsFor(self)
	local localPlayer = t.getHotbarItemsFor(self)
	table.sort(localPlayer, function(self, p2)
		return (HotbarItemUtils.getDisplayOrder(self.obj) or 0) < (HotbarItemUtils.getDisplayOrder(p2.obj) or 0)
	end)
	return localPlayer
end
return t
