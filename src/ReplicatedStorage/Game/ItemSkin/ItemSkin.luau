-- Reviewed by Claude
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local v1 = nil
local t = {}
function t.Init(p1)
	local v12 = p1.Event
	v1 = require(ReplicatedStorage.Game.ItemSkin.UI.UI)
	function p1.em.efbs1qej(p1)
		assert(p1)
		t.ItemSkinsOwned = p1
		v1.UpdateOwned()
	end
	v1.OnSkinClick:Connect(function(p1)
		local v1 = ItemSystem.GetLocalEquipped()
		if v1 == nil then
			error("Player has no item equipped.")
		end
		if v1.ApplySkin == nil then
			error(("Item %s does not suppory skins."):format(v1.__ClassName))
		end
		if t.DoesPlayerOwn(p1.Name) then
			v1:ApplySkin(p1.Name)
		else
			v1:ApplySkinLocal(p1.Name)
		end
		Audio.ObjectLocal(v1.Model.Skeleton.BoundingBox, 4761679152)
	end)
	v1.OnSkinBuyClick:Connect(function(p1)
		local v1 = ItemSystem.GetLocalEquipped()
		if v1 == nil then
			error("Player has no item equipped.")
		end
		if v1.ApplySkin == nil then
			error(("Item %s does not suppory skins."):format(v1.__ClassName))
		end
		v12:FireServer("o" .. ("jfjtfr"):sub(2, 3):reverse() .. "" .. "" .. ("t1n6l5n"):sub(3, 4):reverse() .. "" .. "" .. ("bgszyfh"):sub(3, 3):reverse():reverse():reverse() .. "2g", v1.inventoryItemValue, p1.Name)
		Audio.ObjectLocal(v1.Model.Skeleton.BoundingBox, 4761679547)
	end)
	v1.OnClosed:Connect(function()
		local v1 = ItemSystem.GetLocalEquipped()
		if v1 ~= nil then
			if v1.ApplySkin == nil then
				error(("Item %s does not suppory skins."):format(v1.__ClassName))
			end
			v1:ApplySkinLocal((InventoryItemUtils.getAttr(v1.inventoryItemValue, "SkinName")))
		end
	end)
end
function t.DoesPlayerOwn(p1)
	if p1 == "None" then
		return true
	else
		if t.ItemSkinsOwned == nil then
			error("Item skins have not been synced on client yet.")
		end
		return t.ItemSkinsOwned[p1]
	end
end
return t
