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
			local v1 = t.getSortedHotbarItemsFor(Players.LocalPlayer)
			for i = 1, #v1 do
				local v2 = v1[i]
				if t2[i] then
					v2:SetKeyCode(t2[i])
					v2:SetBindText(("%d"):format(i))
				else
					v2:SetKeyCode(nil)
					v2:SetBindText(nil)
				end
			end
		end
	end
	HotbarItemBinder:GetClassAddedSignal():Connect(function(p1)
		if p1:GetOwner() == Players.LocalPlayer then
			local function f2(p1)
				local v1 = HotbarItemUtils.getDisplayOrder(p1.obj) or 0
				if v1 > 50 then
					v1 = 0
				end
				return v1
			end
			local v4 = math.max(unpack(TableUtils.map(t.getHotbarItemsFor(p1:GetOwner()), f2)))
			if not HotbarItemUtils.getDisplayOrder(p1.obj) then
				HotbarItemUtils.setDisplayOrder(p1.obj, v4 + 1)
			end
			updateDisplayOrder()
			p1._maid:GiveTask(p1.obj:GetAttributeChangedSignal(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME):Connect(updateDisplayOrder))
			p1._maid:GiveTask(p1.onDragStarted:Connect(function()
				assert(not t.isDragging, "somehow hotbar is already dragging")
				t.isDragging = true
				local v2 = Maid.new()
				v2:GiveTask(function()
					t.isDragging = false
				end)
				p1._maid._dragMaid = v2
				local v3 = t.getSortedHotbarItemsFor(p1:GetOwner())
				local v4 = #v3
				p1:SetSize(1.2)
				v2:GiveTask(function()
					p1:SetSize(1)
					p1:Spin()
				end)
				local v5 = table.find(v3, p1)
				local v6 = v5
				local X = p1._frame.Parent.UIListLayout.AbsoluteContentSize.X
				local v7 = p1._frame.Parent.AbsolutePosition.X + p1._frame.Parent.AbsoluteSize.X * 0.5 - X * 0.5
				local v8 = X / v4
				v2:GiveTask(RunService.Heartbeat:Connect(function()
					v6 = math.floor((UserInputService:GetMouseLocation().X - v7) / v8) + 1
					if v6 < 1 then
						v6 = 1
					elseif v4 < v6 then
						v6 = v4
					end
					for i, v in ipairs(v3) do
						HotbarItemUtils.setDisplayOrder(v.obj, HotbarItemUtils.calculateNewIndex(i, v5, v6))
					end
				end))
				v2:GiveTask(UserInputService.InputEnded:Connect(function(p12)
					if p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.Gamepad1) then
						p1._maid._dragMaid = nil
						updateDisplayOrder()
					end
				end))
			end))
			p1._maid:GiveTask(p1:GetInventoryItem():GetEquippedSignal():Connect(function()
				local v1 = p1:GetInventoryItem()
				p1:SetDropVisible(v1 and v1:GetEquipped() and true or false)
			end))
			if p1:GetInventoryItem():GetEquipped() then
				p1:SetDropVisible(p1:GetInventoryItem():GetEquipped())
			end
		end
	end)
	HotbarItemBinder:GetClassRemovingSignal():Connect(function(p1)
		if p1:GetOwner() == Players.LocalPlayer then
			task.defer(updateDisplayOrder)
		end
	end)
	HotbarItemBinder:Start()
	UserInputService.InputBegan:Connect(function(p1, p2)
		if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard then
			for i, v in ipairs((t.getHotbarItemsFor(Players.LocalPlayer))) do
				if p1.KeyCode == v.keyCode then
					local v2 = InventoryItemBinder:Get(v.obj)
					assert(v2, "hotbarItem is somehow not simultaneously inventoryItem")
					v2:AttemptSelect()
				end
			end
		end
	end)
	UserInputService.InputBegan:Connect(function(p1, p2)
		if p2 then
			return false
		end
		if p1.UserInputType == Enum.UserInputType.Gamepad1 then
			local v1 = nil
			if p1.KeyCode == Enum.KeyCode.ButtonL1 then
				v1 = -1
			elseif p1.KeyCode == Enum.KeyCode.ButtonR1 then
				v1 = 1
			end
			if v1 then
				local v2 = InventoryItemSystem.getEquippedFor(Players.LocalPlayer)
				local v3 = t.getSortedHotbarItemsFor(Players.LocalPlayer)
				local v4 = v2[1]
				local sum = if v1 < 0 then #v3 else 1
				if v4 then
					for i = 1, #v3 do
						if v3[i].obj == v4.obj then
							sum = i
							break
						end
					end
					sum = sum + v1
					if sum <= 0 then
						sum = 0
					elseif #v3 + 1 <= sum then
						sum = #v3 + 1
					end
					InventoryItemSystem.unequipAll()
				end
				if v3[sum] then
					InventoryItemSystem.toggleEquip(v3[sum]:GetInventoryItem())
				end
			end
		end
	end)
end
function t.getHotbarItemsFor(p1)
	return TableUtils.filter(HotbarItemBinder:GetAll(), function(p12)
		return p12:GetOwner() == p1
	end)
end
function t.getSortedHotbarItemsFor(p1)
	local v1 = t.getHotbarItemsFor(p1)
	table.sort(v1, function(p1, p2)
		return (HotbarItemUtils.getDisplayOrder(p1.obj) or 0) < (HotbarItemUtils.getDisplayOrder(p2.obj) or 0)
	end)
	return v1
end
return t
