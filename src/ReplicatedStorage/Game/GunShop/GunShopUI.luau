local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
require(ReplicatedStorage.Gamepass.GamepassUtils)
local GunShopSystem = require(script.Parent.GunShopSystem)
local GunShopSlider = require(script.Parent.GunShopSlider)
local GunShopItem = require(script.Parent.GunShopItem)
local GunShopUtils = require(script.Parent.GunShopUtils)
local v1 = nil
local v2 = nil
local function SelectIfGamepad(p1) --[[ Line: 17 | Upvalues: EzUtils (copy) ]]
	EzUtils.selectIfGamepad(p1)
end
local t = {
	maid = nil,
	currentSlider = nil
}
function t.init(p1) --[[ Line: 24 | Upvalues: v1 (ref), v2 (ref), ReplicatedStorage (copy), LocalPlayer (copy), t (copy) ]]
	v1 = p1.Event
	v2 = p1.em
	local GunShopGui = ReplicatedStorage.StarterGui:FindFirstChild("GunShopGui")
	GunShopGui.Parent = LocalPlayer.PlayerGui
	t.gui = GunShopGui
end
function t.isOpen() --[[ Line: 31 | Upvalues: t (copy) ]]
	return t.maid ~= nil
end
function t.open() --[[ Line: 34 | Upvalues: t (copy), Maid (copy), GunShopUtils (copy), EzUtils (copy) ]]
	assert(not t.isOpen())
	local v2 = Maid.new()
	t.maid = v2
	local gui = t.gui
	gui.Enabled = true
	v2:GiveTask(function() --[[ Line: 40 | Upvalues: gui (copy) ]]
		gui.Enabled = false
	end)
	local Sidebar = gui.Container.Container.Sidebar
	local list = {}
	for i, v in ipairs(Sidebar:GetChildren()) do
		if v:IsA("ImageButton") then
			table.insert(list, v)
		end
	end
	local function onButtonClick(p1) --[[ Line: 52 | Upvalues: list (copy), GunShopUtils (ref), t (ref) ]]
		assert(p1)
		for i, v in ipairs(list) do
			v.Image = "rbxassetid://5834230837"
		end
		p1.Image = "rbxassetid://5834230671"
		local v1 = p1.Name
		local v2 = GunShopUtils.getCategoryData(v1)
		if not v2 then
			error(("No data for gun shop category: %s"):format(v1))
		end
		t.displayList(v2)
	end
	for i, v in ipairs(list) do
		v2:GiveTask(v.MouseButton1Down:Connect(function() --[[ Line: 66 | Upvalues: onButtonClick (copy), v (copy) ]]
			onButtonClick(v)
		end))
	end
	onButtonClick(Sidebar.Held)
	EzUtils.selectIfGamepad(Sidebar.Held)
	v2:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function() --[[ Line: 74 | Upvalues: t (ref) ]]
		t.close()
	end))
end
function t.displayList(p1) --[[ Line: 78 | Upvalues: GunShopSlider (copy), t (copy), ItemSystem (copy), GunShopSystem (copy), GunShopItem (copy), GunShopUtils (copy), v1 (ref), LocalPlayer (copy), InventoryItemBinder (copy) ]]
	local v12 = GunShopSlider.new(p1)
	t.maid.currentSlider = v12
	v12:SetParent(t.gui.Container.Container.Main.Container)
	for i, v in ipairs(p1) do
		local v2
		local v3 = v.Name
		local v4 = ItemSystem.GetConfig(v3)
		if not v4 then
			error(("Missing item config for item: %s"):format(v3))
		end
		if not v4.Price then
			error(("Missing price data for item: %s"):format(v3))
		end
		if not v4.ImageId then
			error(("Missing image asset for item: %s"):format(v3))
		end
		local v5 = GunShopSystem.doesPlayerOwn(v3)
		v2 = not v4.ShopHidden or v5
		if v2 then
			local v6 = GunShopItem.new()
			v6:SetName(v3, GunShopUtils.getTranslatedTitleFromName(v3))
			v6:SetPrice(v4.Price)
			if not v4.ImageId then
				error(("Missing image asset for item: %s"):format(v3))
			end
			v6:SetImageId(v4.ImageId)
			if v4.ImageColor then
				v6:SetImageColor(v4.ImageColor)
			end
			v6:SetLevel(v4.Level)
			v6._maid:GiveTask(v6.onMouseButton1Down:Connect(function() --[[ Line: 123 | Upvalues: v6 (copy), v1 (ref), v3 (copy), GunShopSystem (ref) ]]
				if v6:GetEquipped() then
					v1:FireServer("y" .. ("krhwwn"):sub(3, 3):reverse() .. "" .. "" .. ("kmadf"):sub(2, 3):reverse():reverse():reverse() .. "" .. "" .. ("xed5y4"):sub(2, 2):reverse() .. "qcz", v3)
				elseif GunShopSystem.doesPlayerOwn(v3) then
					v1:FireServer("t" .. ("cdtv2wm"):sub(5, 5):reverse() .. "" .. "" .. ("j9gelw"):sub(4, 5):reverse():reverse():reverse() .. "y62p", v3)
				else
					v1:FireServer("tlcucis3", v3)
				end
			end))
			if v4.RequireAnyGamepass then
				for i2, v7 in ipairs(v4.RequireAnyGamepass) do
					v6:AddRequiredGamepass(v7)
				end
			end
			if v5 then
				v6:SetOwned(true)
			end
			v12:AddItem(v6)
			v6:SetLayoutOrder((v4.SortOrderPage or 0) * 100000 + v4.Price * 10)
		end
	end
	v12._maid:GiveTask(GunShopSystem.onAnyOwned:Connect(function(p1) --[[ Line: 148 | Upvalues: v12 (copy) ]]
		for i, v in ipairs(v12._listItem) do
			if v:GetName() == p1 then
				v:SetOwned(true)
				return
			end
		end
	end))
	local function handleInventoryItemAdded(p1) --[[ Line: 158 | Upvalues: LocalPlayer (ref), v12 (copy) ]]
		if p1:GetOwner() == LocalPlayer then
			for i, v in ipairs(v12._listItem) do
				if v:GetName() == p1:GetName() then
					v:SetEquipped(true)
					return
				end
			end
		end
	end
	local function handleInventoryItemRemoved(p1) --[[ Line: 168 | Upvalues: LocalPlayer (ref), v12 (copy) ]]
		if p1:GetOwner() == LocalPlayer then
			for i, v in ipairs(v12._listItem) do
				if v:GetName() == p1:GetName() then
					v:SetEquipped(false)
					return
				end
			end
		end
	end
	v12._maid:GiveTask(InventoryItemBinder:GetClassAddedSignal():Connect(handleInventoryItemAdded))
	for i, v in ipairs(InventoryItemBinder:GetAll()) do
		handleInventoryItemAdded(v)
	end
	v12._maid:GiveTask(InventoryItemBinder:GetClassRemovingSignal():Connect(handleInventoryItemRemoved))
end
function t.close() --[[ Line: 195 | Upvalues: t (copy) ]]
	assert(t.isOpen())
	local maid = t.maid
	t.maid = nil
	maid:Destroy()
end
return t